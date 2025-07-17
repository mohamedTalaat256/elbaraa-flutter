import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)


AppResponse<T> _$AppResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    AppResponse<T>(
      success: true,
      message: json['message'] as String,
     // statusCode: json['statusCode'] as int?,
     // statusMessage: json['statusMessage'] as String?,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$AppResponseToJson<T>(
  AppResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'statusCode': instance.statusCode,
      'statusMessage': instance.statusMessage,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

class AppResponse<T> extends Equatable {
  
  final bool success;
  final String message;
  final T? data;
  final int statusCode;
  final String statusMessage;

  const AppResponse ._({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.statusMessage,
    this.data,
  });


  factory AppResponse({
    required bool success,
    required String message,
    int? statusCode,
    String? statusMessage,
    T? data,
  }) {
    return AppResponse._(
      success: success,
      message: message,
      statusCode: statusCode ?? 200,
      statusMessage: statusMessage ?? "The request has succeeded.",
      data: data,
    );
  }



  @override
  List<Object> get props {
    return [
      success,
      message,
      data ?? ""
    ];
  }


  factory AppResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ){
    return _$AppResponseFromJson(json, fromJsonT);
  }
  Map<String, dynamic> toJson(
      Object? Function(T? value) toJsonT,
    ){
    return _$AppResponseToJson(this, toJsonT);
  }
@override
bool get stringify => true;
}
