import 'package:equatable/equatable.dart';

class AuthEvents extends Equatable{

  @override
  List<Object> get props =>[];
}


class AutoLoginEvent extends AuthEvents{ }


class LoginButtonPressed extends AuthEvents{

  final String email;
  final String password;

  LoginButtonPressed({
    required this.email,
    required this.password
  });
}


class LogoutButtonPressed extends AuthEvents{

  LogoutButtonPressed();
}

