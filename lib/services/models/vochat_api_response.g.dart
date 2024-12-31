// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vochat_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VochatApiResponse<T> _$VochatApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    VochatApiResponse<T>(
      code: (json['code'] as num?)?.toInt() ?? -1,
      msg: json['message'] as String? ?? '',
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$VochatApiResponseToJson<T>(
  VochatApiResponse<T> instance,
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
