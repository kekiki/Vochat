// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vochat_area_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VochatAreaModel _$VochatAreaModelFromJson(Map<String, dynamic> json) =>
    VochatAreaModel(
      json['area'] as String? ?? '',
      (json['status'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$VochatAreaModelToJson(VochatAreaModel instance) =>
    <String, dynamic>{
      'area': instance.area,
      'status': instance.status,
    };
