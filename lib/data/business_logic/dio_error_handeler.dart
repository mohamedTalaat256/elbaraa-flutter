import 'dart:io';
import 'package:dio/dio.dart';

class DioErrorHandler {
  static String decodeErrorResponse(DioException e) {
    String message = '';

    if (e.type == DioExceptionType.badResponse) {
      final statusCode = e.response?.statusCode;
      final statusMessage = e.response?.statusMessage;
      message = 'Error $statusCode $statusMessage';
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      message = 'Error 408 Connection Timeout';
    } else if (e.error is SocketException) {
      message = "No Internet Connection!";
    } else {
      message = 'Unexpected error occurred';
    }

    return message;
  }

  DioErrorHandler(DioException e) {
    decodeErrorResponse(e);
  }
}
