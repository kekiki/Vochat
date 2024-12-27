// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colive_call_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColiveCallRecordModel _$ColiveCallRecordModelFromJson(
        Map<String, dynamic> json) =>
    ColiveCallRecordModel(
      (json['anchor_id'] as num?)?.toInt() ?? 0,
      json['avatar'] as String? ?? '',
      (json['c_type'] as num?)?.toInt() ?? 0,
      (json['conversation_time'] as num?)?.toInt() ?? 0,
      (json['custom_id'] as num?)?.toInt() ?? 0,
      (json['diamonds'] as num?)?.toInt() ?? 0,
      (json['end_time'] as num?)?.toInt() ?? 0,
      (json['gold'] as num?)?.toInt() ?? 0,
      (json['id'] as num?)?.toInt() ?? 0,
      json['nickname'] as String? ?? '',
    );

Map<String, dynamic> _$ColiveCallRecordModelToJson(
        ColiveCallRecordModel instance) =>
    <String, dynamic>{
      'anchor_id': instance.anchorId,
      'avatar': instance.avatar,
      'c_type': instance.cType,
      'conversation_time': instance.conversationTime,
      'custom_id': instance.customId,
      'diamonds': instance.diamonds,
      'end_time': instance.endTime,
      'gold': instance.gold,
      'id': instance.id,
      'nickname': instance.nickname,
    };
