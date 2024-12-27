// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colive_area_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColiveAreaModel _$ColiveAreaModelFromJson(Map<String, dynamic> json) =>
    ColiveAreaModel(
      json['area'] as String? ?? '',
      (json['status'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ColiveAreaModelToJson(ColiveAreaModel instance) =>
    <String, dynamic>{
      'area': instance.area,
      'status': instance.status,
    };
