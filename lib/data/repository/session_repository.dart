import 'package:elbaraa/data/models/requests/app_response.dart';
import 'package:elbaraa/data/models/session.model.dart';
import 'package:elbaraa/utils/dio_client/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionRepository {
  late Dio dio;
  late SharedPreferences sharedPreferences;
  SessionRepository() {
    dio = DioClient().instance;
  }

  Future<AppResponse<List<Session>>> getUserCalendar() async {
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('role');
    var url = '';
    if (role == 'INSTRUCTOR') {
      url = '/instructor/calendar';
    } else if (role == 'STUDENT') {
      url = '/student/calendar';
    }
    Response response = await dio.get(url);
    /*  return AppResponse<List<Session>>.fromJson(
      response.data['sessions'],
      (dynamic json) => json != null
          ? (json as List<dynamic>).map((e) => Session.fromJson(e)).toList()
          : [],
    ); */

    return AppResponse<List<Session>>.fromJson(response.data, (json) {
      final sessions =
          (json as Map<String, dynamic>)['sessions'] as List<dynamic>? ?? [];
      return sessions.map((e) => Session.fromJson(e)).toList();
    });
  }
}
