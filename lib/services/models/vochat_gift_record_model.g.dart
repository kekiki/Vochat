// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vochat_gift_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VochatGiftRecordModel _$VochatGiftRecordModelFromJson(
        Map<String, dynamic> json) =>
    VochatGiftRecordModel(
      (json['anchor_id'] as num?)?.toInt() ?? 0,
      json['avatar'] as String? ?? '',
      (json['create_time'] as num?)?.toInt() ?? 0,
      (json['custom_id'] as num?)?.toInt() ?? 0,
      (json['diamonds'] as num?)?.toInt() ?? 0,
      (json['gift_id'] as num?)?.toInt() ?? 0,
      json['gift_name'] as String? ?? '',
      (json['gold'] as num?)?.toInt() ?? 0,
      (json['id'] as num?)?.toInt() ?? 0,
      json['nickname'] as String? ?? '',
      (json['num'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$VochatGiftRecordModelToJson(
        VochatGiftRecordModel instance) =>
    <String, dynamic>{
      'anchor_id': instance.anchorId,
      'avatar': instance.avatar,
      'create_time': instance.createTime,
      'custom_id': instance.customId,
      'diamonds': instance.diamonds,
      'gift_id': instance.giftId,
      'gift_name': instance.giftName,
      'gold': instance.gold,
      'id': instance.id,
      'nickname': instance.nickname,
      'num': instance.num,
    };
