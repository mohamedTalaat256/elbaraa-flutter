import 'package:elbaraa/data/models/material.model.dart';
import 'package:elbaraa/data/models/plan.model.dart';
import 'package:elbaraa/data/models/requests/app_response.dart';
import 'package:elbaraa/utils/dio_client/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlanRepository {
  late Dio dio;
  late SharedPreferences sharedPreferences;
  PlanRepository() {
    dio = DioClient().instance;
  }
 
 
  Future<AppResponse<dynamic>> findById(int id) async {
    final response = await dio.get('/plans/$id');

    return AppResponse<dynamic>.fromJson(
    response.data,
    (json) {
      if (json is Map<String, dynamic>) {
        return {
          'plan': Plan.fromJson(json['plan']),
          'materials': (json['materials'] as List<dynamic>)
              .map((e) => MaterialModel.fromJson(e))
              .toList(),
        };
      }
      return {};
    },
  );
  }
 
}
