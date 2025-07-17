import 'package:elbaraa/data/models/ChatMessage.dart';
import 'package:elbaraa/data/models/chat.dart';
import 'package:elbaraa/data/models/requests/app_response.dart';
import 'package:elbaraa/data/web_services/chats_web_service.dart';
import 'package:elbaraa/utils/dio_client/dio_client.dart';
import 'package:dio/dio.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatRepository {
  late SharedPreferences sharedPreferences;
  final ChatWebService chatWebService;

  late Dio dio;
  ChatRepository(this.chatWebService) {
    dio = DioClient().instance;
  }

  Future<int> getUserId() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    int? userId = await sp.getInt('userid');
    return userId!;
  }

  /* Future<AppResponse<HomeData>> homeData() async {
  Response response = await dio.get('/landingPage');
  return AppResponse<HomeData>.fromJson(
    response.data,
    (json) => HomeData.fromJson(json as Map<String, dynamic>),
  );
} */

  Future<AppResponse<List<Chat>>> getAuthUserChat() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // FirebaseMessaging messaging = FirebaseMessaging.instance;
    // String? FCMtoken = await messaging.getToken();

    /*  final response =  await dio.get('/users?user_id=${userId}&fcm_token=${FCMtoken}'); */

    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('role');
    var url = '';
    if (role == 'INSTRUCTOR') {
      url = '/instructor/chats';
    } else if (role == 'STUDENT') {
      url = '/student/chats';
    } else if (role == 'ADMIN') {
      url = '/admin/chats';
    }
    final response = await dio.get(url);
    return AppResponse<List<Chat>>.fromJson(
      response.data,
      (dynamic json) => json != null
          ? (json as List<dynamic>).map((e) => Chat.fromJson(e)).toList()
          : [],
    );
  }

  Future<List<ChatMessage>> getChatMessages(int secondPersonId) async {
    final chatMessages = await chatWebService.getChatMessages(secondPersonId);
    return chatMessages
        .map((chatMessage) => ChatMessage.fromJson(chatMessage))
        .toList();
  }

  Future<bool> sendMessage(String reciver_id, String message) async {
    sharedPreferences = await SharedPreferences.getInstance();
    int? userId = await sharedPreferences.getInt("userid");

    /*  FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken(); */

    Response response = await dio.post(
      '/send_message?sender_id=${userId}&reciver_id=${reciver_id}&message=${message}',
    );

    return response.data['data'];
  }
}
