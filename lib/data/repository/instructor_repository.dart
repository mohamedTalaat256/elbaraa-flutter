import 'package:elbaraa/data/models/instructor.model.dart';
import 'package:elbaraa/data/models/requests/app_response.dart';
import 'package:elbaraa/utils/dio_client/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InstructorRepository {
  late Dio dio;
  late SharedPreferences sharedPreferences;
  InstructorRepository() {
    dio = DioClient().instance;
  }
 
 
  Future<AppResponse<dynamic>> getActiveInstructorByMaterialI(int materialId) async {
    final response = await dio.get('/allActiveInstructorsByMaterial/$materialId');

    return AppResponse<List<Instructor>>.fromJson(
      response.data,
      (dynamic json) => json != null
          ? (json as List<dynamic>).map((e) => Instructor.fromJson(e)).toList()
          : [],
    );
  }
 
}
