// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colive_call_settlement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColiveCallSettlementModel _$ColiveCallSettlementModelFromJson(
        Map<String, dynamic> json) =>
    ColiveCallSettlementModel(
      (json['anchor_id'] as num?)?.toInt() ?? 0,
      json['avatar'] as String? ?? '',
      (json['cardNum'] as num?)?.toInt() ?? 0,
      (json['conversation_time'] as num?)?.toInt() ?? 0,
      json['country_currency'] as String? ?? '',
      json['diamonds'] as String? ?? '',
      (json['end_time'] as num?)?.toInt() ?? 0,
      json['gift'] as String? ?? '',
      json['nickname'] as String? ?? '',
      (json['start_time'] as num?)?.toInt() ?? 0,
      (json['total'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ColiveCallSettlementModelToJson(
        ColiveCallSettlementModel instance) =>
    <String, dynamic>{
      'anchor_id': instance.anchorId,
      'avatar': instance.avatar,
      'cardNum': instance.cardNum,
      'conversation_time': instance.conversationTime,
      'country_currency': instance.countryCurrency,
      'diamonds': instance.diamonds,
      'end_time': instance.endTime,
      'gift': instance.gift,
      'nickname': instance.nickname,
      'start_time': instance.startTime,
      'total': instance.total,
    };
