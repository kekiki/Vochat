// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vochat_sys_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VochatSysRecordModel _$VochatSysRecordModelFromJson(
        Map<String, dynamic> json) =>
    VochatSysRecordModel(
      (json['create_time'] as num?)?.toInt() ?? 0,
      (json['diamonds'] as num?)?.toInt() ?? 0,
      json['e_type'] as String? ?? '',
      (json['id'] as num?)?.toInt() ?? 0,
      json['remarks'] as String? ?? '',
      json['sum'] as String? ?? '',
    );

Map<String, dynamic> _$VochatSysRecordModelToJson(
        VochatSysRecordModel instance) =>
    <String, dynamic>{
      'create_time': instance.createTime,
      'diamonds': instance.diamonds,
      'e_type': instance.eType,
      'id': instance.id,
      'remarks': instance.remarks,
      'sum': instance.sum,
    };
