// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colive_custom_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColiveCustomCodeModel _$ColiveCustomCodeModelFromJson(
        Map<String, dynamic> json) =>
    ColiveCustomCodeModel(
      json['custom_code'] as String? ?? '',
      json['password'] as String? ?? '',
      (json['type'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ColiveCustomCodeModelToJson(
        ColiveCustomCodeModel instance) =>
    <String, dynamic>{
      'custom_code': instance.customCode,
      'password': instance.password,
      'type': instance.type,
    };
