import 'package:bloc/bloc.dart';
import 'package:elbaraa/data/models/user.dart';
import 'package:elbaraa/data/repository/users_repository.dart';
import 'package:meta/meta.dart';


part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UsersRepository usersRepository;

  List<User> users = [];
  UserCubit(this.usersRepository) : super(ChatInitial());



  List<User> getAllChats() {
    emit(UsersLoading());
    usersRepository.getUsers().then((users) {
      emit(UsersLoaded(users));
      this.users = users;
    });
    return users;
  }

}
