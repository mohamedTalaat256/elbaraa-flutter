

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  

  int userId =0;


  AuthCubit(AuthState authState) : super(LoginInitState());






  Future<int?> setId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt("userid")!;
    return null;
  }





}
