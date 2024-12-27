// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colive_turntable_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColiveTurntableRecordModel _$ColiveTurntableRecordModelFromJson(
        Map<String, dynamic> json) =>
    ColiveTurntableRecordModel(
      json['img'] as String? ?? '',
      json['name'] as String? ?? '',
      (json['num'] as num?)?.toInt() ?? 0,
      json['time'] as String? ?? '',
    );

Map<String, dynamic> _$ColiveTurntableRecordModelToJson(
        ColiveTurntableRecordModel instance) =>
    <String, dynamic>{
      'img': instance.img,
      'name': instance.name,
      'num': instance.num,
      'time': instance.time,
    };
