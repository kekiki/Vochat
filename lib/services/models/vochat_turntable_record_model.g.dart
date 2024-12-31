// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vochat_turntable_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VochatTurntableRecordModel _$VochatTurntableRecordModelFromJson(
        Map<String, dynamic> json) =>
    VochatTurntableRecordModel(
      json['img'] as String? ?? '',
      json['name'] as String? ?? '',
      (json['num'] as num?)?.toInt() ?? 0,
      json['time'] as String? ?? '',
    );

Map<String, dynamic> _$VochatTurntableRecordModelToJson(
        VochatTurntableRecordModel instance) =>
    <String, dynamic>{
      'img': instance.img,
      'name': instance.name,
      'num': instance.num,
      'time': instance.time,
    };
