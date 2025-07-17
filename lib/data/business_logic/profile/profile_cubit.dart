import 'dart:convert';
import 'package:elbaraa/data/models/user.dart';
import 'package:elbaraa/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepository authRepository;
  ProfileCubit(this.authRepository) : super(ProfileInitial());

  Future<User?> getMyProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      emit(ProfileLoaded(User.fromJson(userMap)));
    } else {
      emit(ProfileLoadingError("not found in shared prefrences"));
    }
    return null;
  }
}
