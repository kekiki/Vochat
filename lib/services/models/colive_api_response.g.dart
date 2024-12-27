// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colive_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColiveApiResponse<T> _$ColiveApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ColiveApiResponse<T>(
      code: (json['code'] as num?)?.toInt() ?? -1,
      msg: json['message'] as String? ?? '',
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$ColiveApiResponseToJson<T>(
  ColiveApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.msg,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
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
