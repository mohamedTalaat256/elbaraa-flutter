part of 'user_cubit.dart';


@immutable
abstract class UserState {}

class ChatInitial extends UserState {}


class UsersLoaded extends UserState {
  final List<User> users;
  UsersLoaded(this.users);
}

class UsersLoading extends UserState {
}



