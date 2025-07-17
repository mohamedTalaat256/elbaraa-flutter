import 'package:elbaraa/data/models/user.dart';
import 'package:elbaraa/utils/dio_client/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  late User authUser;

  late SharedPreferences sharedPreferences;

  late Dio dio;
  AuthRepository() {
    dio = DioClient().instance;
  }

  login(String email, String password) async {
   // FirebaseMessaging messaging = FirebaseMessaging.instance;
   // String? token = await messaging.getToken();
    
    Response response = await dio.post('/auth/login',
        data: {'login': email, 'password': password, /* 'fcm_token': token */});
    return response.data;
  }

  myProfile() async {
    sharedPreferences = await SharedPreferences.getInstance();

    int? userId = await sharedPreferences.getInt('userid');

    Response response = await dio.get('my_profile?id=' + userId.toString());

   /*  User user = User(
        id: response.data['id'].toString(),
        email: response.data['email'],
        firstName: response.data['firstName'],
        imageUrl: response.data['imageUrl'],
        phone: response.data['phone'],
        online: response.data['active_staus']); */

    return null;
  }

  uploadProfileImage(FormData data) async {
    int? userId = await sharedPreferences.getInt('userid');
    try {
      Response response = await dio
          .post('update_profile_image?id=' + userId.toString(), data: data);

      print(response.data);

      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }

  updateProfile(FormData data) async {
    int? userId = await sharedPreferences.getInt('userid');

    Response response =
        await dio.post('update_profile?id=' + userId.toString(), data: data);

    return response;
  }
}
