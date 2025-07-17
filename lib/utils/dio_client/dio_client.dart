import 'package:elbaraa/constants/strings.dart';
import 'package:elbaraa/utils/dio_client/app_interceptors.dart';
import 'package:dio/dio.dart';

class DioClient {
  static DioClient? _singleton;
  static late Dio _dio;

  DioClient._() {
    _dio = createDioClient();
  }

  factory DioClient() {
    return _singleton ??= DioClient._();
  }

  Dio get instance => _dio;

  Dio createDioClient() {
    print(baseUrl);
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveTimeout: const Duration(milliseconds: 15000) , // 15 seconds
        connectTimeout: const Duration(milliseconds: 15000),
        sendTimeout: const Duration(milliseconds: 15000),
        headers: {
          Headers.acceptHeader: ' application/json',
          Headers.contentTypeHeader: ' application/json',
        },
      ), // BaseOptions
    );

    dio.interceptors.addAll([
      AppInterceptors(),
    ]); 
    return dio;
  }
}
