import 'package:dio/dio.dart';
import 'package:elbaraa/utils/dio_client/dio_client.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatWebService {
  late Dio dio;
  late SharedPreferences sharedPreferences;

  ChatWebService() {
    dio = DioClient().instance;
  }

  Future<List> getChatMessages(int secondPersonId) async {
    sharedPreferences = await SharedPreferences.getInstance();
    int? userId = await sharedPreferences.getInt("userid");

    print('sender_id: ' + userId.toString());
    try {
      Response response = await dio.get('/messages?user_id=' +
          userId.toString() +
          '&second_person_id=' +
          secondPersonId.toString());

      return response.data['data'];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
