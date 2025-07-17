

import 'package:equatable/equatable.dart';

class AuthState extends Equatable{
  List<Object> get props =>[];
}

class LoginInitState extends AuthState{
  

}

class IsLogedInState extends AuthState{
   final String userId;
  final String authToken;

  IsLogedInState({
    required this.userId,
    required this.authToken
  });

}

class IsNotLogedInState extends AuthState{}

class LoginLoadingState extends AuthState{}

class UserLoginSuccessState extends AuthState{

   final String userId;
  final String authToken;

  UserLoginSuccessState({
    required this.userId,
    required this.authToken
  });

}

class LoginErrorState extends AuthState{
  final String message;

  LoginErrorState({
    required this.message
  });
}


class LogoutLoadingState extends AuthState{}
class UserLogoutSuccessState extends AuthState{}