import 'package:elbaraa/data/models/homeData.dart';
import 'package:elbaraa/data/models/requests/app_response.dart';
import 'package:elbaraa/utils/dio_client/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepository {
  late Dio dio;
  late SharedPreferences sharedPreferences;
  HomeRepository() {
    dio = DioClient().instance;
  }


Future<AppResponse<HomeData>> homeData() async {
  Response response = await dio.get('/landingPage');
  return AppResponse<HomeData>.fromJson(
    response.data,
    (json) => HomeData.fromJson(json as Map<String, dynamic>),
  );
}

}
