// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vochat_follower_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VochatFollowerModel _$VochatFollowerModelFromJson(Map<String, dynamic> json) =>
    VochatFollowerModel(
      json['area'] as String?,
      json['avatar'] as String?,
      json['birthday'] as num?,
      json['conversation_price'] as num?,
      json['country'] as String?,
      json['country_currency'] as String?,
      json['country_icon'] as String?,
      json['create_time'] as num?,
      (json['uid'] as num?)?.toInt() ?? 0,
      json['gold'] as num?,
      json['id'] as num?,
      json['nickname'] as String?,
      json['online'] as num?,
    );

Map<String, dynamic> _$VochatFollowerModelToJson(
        VochatFollowerModel instance) =>
    <String, dynamic>{
      'area': instance.area,
      'avatar': instance.avatar,
      'birthday': instance.birthday,
      'conversation_price': instance.conversationPrice,
      'country': instance.country,
      'country_currency': instance.countryCurrency,
      'country_icon': instance.countryIcon,
      'create_time': instance.createTime,
      'uid': instance.uid,
      'gold': instance.gold,
      'id': instance.id,
      'nickname': instance.nickname,
      'online': instance.online,
    };
