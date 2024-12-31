// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vochat_custom_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VochatCustomCodeModel _$VochatCustomCodeModelFromJson(
        Map<String, dynamic> json) =>
    VochatCustomCodeModel(
      json['custom_code'] as String? ?? '',
      json['password'] as String? ?? '',
      (json['type'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$VochatCustomCodeModelToJson(
        VochatCustomCodeModel instance) =>
    <String, dynamic>{
      'custom_code': instance.customCode,
      'password': instance.password,
      'type': instance.type,
    };
