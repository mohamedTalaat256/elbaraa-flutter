import 'package:elbaraa/data/models/user.dart';
import 'package:elbaraa/data/web_services/users_web_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersRepository {

  final UsersWebService usersWebService;

  UsersRepository(this.usersWebService) {
  }

  Future<int> getUserId() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    int? userId = await sp.getInt('userid');
    return userId!;
  }

  Future<List<User>> getUsers() async {
    final users = await usersWebService.getUsers();
    return users.map((user) => User.fromJson(user)).toList();
  }

}
