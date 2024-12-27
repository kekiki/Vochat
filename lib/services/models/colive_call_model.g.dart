// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colive_call_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColiveCallModel _$ColiveCallModelFromJson(Map<String, dynamic> json) =>
    ColiveCallModel(
      json['session_id'] as String? ?? '',
      (json['anchor_id'] as num?)?.toInt() ?? 0,
      json['anchor_avatar'] as String? ?? '',
      json['anchor_nickname'] as String? ?? '',
      (json['conversation_id'] as num?)?.toInt() ?? 0,
      json['conversation_price'] as String? ?? '60',
      json['country_currency'] as String? ?? '',
      json['country_icon'] as String? ?? '',
      json['country_name'] as String? ?? '',
      (json['is_mute'] as num?)?.toInt() ?? 0,
      json['url'] as String? ?? '',
      json['item_num'] as String? ?? '0',
      (json['item_call_time'] as num?)?.toInt() ?? 0,
      (json['status'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ColiveCallModelToJson(ColiveCallModel instance) =>
    <String, dynamic>{
      'session_id': instance.sessionId,
      'anchor_id': instance.anchorId,
      'anchor_avatar': instance.anchorAvatar,
      'anchor_nickname': instance.anchorNickname,
      'conversation_id': instance.conversationId,
      'conversation_price': instance.conversationPrice,
      'country_currency': instance.countryCurrency,
      'country_icon': instance.countryIcon,
      'country_name': instance.countryName,
      'is_mute': instance.mute,
      'url': instance.url,
      'item_num': instance.cardNum,
      'item_call_time': instance.cardCallTime,
      'status': instance.status,
    };
