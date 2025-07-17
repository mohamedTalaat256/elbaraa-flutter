import 'dart:convert';

import 'package:elbaraa/data/business_logic/auth/auth_event.dart';
import 'package:elbaraa/data/business_logic/auth/auth_state.dart';
import 'package:elbaraa/data/business_logic/dio_error_handeler.dart';
import 'package:elbaraa/data/models/user.dart';
import 'package:elbaraa/data/repository/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  final AuthRepository authRepository;
  SharedPreferences? sharedPreferences;

  String? authToken;
  int? userId;

  AuthBloc(this.authRepository) : super(LoginInitState()) {
    on<AuthEvents>(_handleEvent);
  }

  Future<void> _handleEvent(AuthEvents event, Emitter<AuthState> emit) async {
    sharedPreferences ??= await SharedPreferences.getInstance();

    if (event is AutoLoginEvent) {
      await _handleAutoLogin(emit);
    } else if (event is LoginButtonPressed) {
      await _handleLogin(event, emit);
    } else if (event is LogoutButtonPressed) {
      await _handleLogout(emit);
    }
  }

  Future<void> _handleAutoLogin(Emitter<AuthState> emit) async {
    final prefs = sharedPreferences;
    if (prefs == null) {
      emit(IsNotLogedInState());
      return;
    }

    final userJson = prefs.getString('user');
    final token = prefs.getString('authToken');

    if (userJson == null || token == null) {
      emit(IsNotLogedInState());
      return;
    }

    try {
      final authUser = User.fromJson(jsonDecode(userJson));
      authToken = token;

      emit(IsLogedInState(authToken: token, userId: authUser.id.toString()));
    } catch (e) {
      emit(IsNotLogedInState());
    }
  }

  Future<void> _handleLogin(
    LoginButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoginLoadingState());

    try {
      final response = await authRepository.login(event.email, event.password);

      if (response['success'] == true) {
        final data = response['data'];

        User user = User.authUser(
          id: data['user']['id'],
          firstName: data['user']['firstName'],
          lastName: data['user']['lastName'],
          imageUrl: data['user']['imageUrl'],
          phone: data['user']['phone'],
          email: data['user']['email'],
          country: data['user']['country'],
        );
        userId = user.id;
        authToken = data['token'];

        final prefs = sharedPreferences;
        if (prefs != null && userId != null && authToken != null) {
          await prefs.setInt('userid', userId!);
          await prefs.setString('authToken', authToken!);
          await prefs.setString('role', data['user']['role']);
          await prefs.setString('user', jsonEncode(user.toJson()));

          emit(
            UserLoginSuccessState(
              userId: userId!.toString(),
              authToken: authToken!,
            ),
          );
        } else {
          emit(LoginErrorState(message: 'Invalid login response'));
        }
      } else {
        emit(LoginErrorState(message: 'Login failed'));
      }
    } on DioException catch (e) {
      emit(LoginErrorState(message: DioErrorHandler.decodeErrorResponse(e)));
    } catch (e) {
      emit(LoginErrorState(message: 'Unexpected error occurred'));
    }
  }

  Future<void> _handleLogout(Emitter<AuthState> emit) async {
    emit(LogoutLoadingState());

    final prefs = sharedPreferences;
    if (prefs != null) {
      await prefs.remove('useremail');
      await prefs.remove('userid');
      await prefs.remove('authToken');
    }

    emit(UserLogoutSuccessState());
  }
}
