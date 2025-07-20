import 'package:elbaraa/utils/dio_client/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MaterialRepository {
  late Dio dio;
  late SharedPreferences sharedPreferences;
  MaterialRepository() {
    dio = DioClient().instance;
  }
 
 
  /* Future<AppResponse<List<MaterialModel>>> */ getAllActiveMaterials() async {
   /*  final response = await dio.get('/');
    return /* AppResponse<List<MaterialModel>>.fromJson(
      response.data,
      (dynamic json) => json != null
          ? (json as List<dynamic>).map((e) => Chat.fromJson(e)).toList()
          : [],
    ); */ */
  }
 
}
