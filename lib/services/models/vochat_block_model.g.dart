// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vochat_block_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VochatBlockModel _$VochatBlockModelFromJson(Map<String, dynamic> json) =>
    VochatBlockModel(
      json['area'] as String?,
      json['avatar'] as String?,
      json['birthday'] as num?,
      json['conversation_price'] as num?,
      json['country'] as String?,
      json['country_currency'] as String?,
      json['country_icon'] as String?,
      json['create_time'] as num?,
      (json['block_id'] as num?)?.toInt() ?? 0,
      json['gold'] as num?,
      json['id'] as num?,
      (json['isRobot'] as num?)?.toInt() ?? 0,
      json['nickname'] as String?,
      json['online'] as num?,
      json['robotArea'] as String?,
      json['robotAvatar'] as String?,
      json['robotBirthday'] as num?,
      json['robotCountry'] as String?,
      json['robotNickname'] as String?,
      json['userArea'] as String?,
      json['userNickname'] as String?,
    );

Map<String, dynamic> _$VochatBlockModelToJson(VochatBlockModel instance) =>
    <String, dynamic>{
      'area': instance.area,
      'avatar': instance.avatar,
      'birthday': instance.birthday,
      'conversation_price': instance.conversationPrice,
      'country': instance.country,
      'country_currency': instance.countryCurrency,
      'country_icon': instance.countryIcon,
      'create_time': instance.createTime,
      'block_id': instance.blockId,
      'gold': instance.gold,
      'id': instance.id,
      'isRobot': instance.robot,
      'nickname': instance.nickname,
      'online': instance.online,
      'robotArea': instance.robotArea,
      'robotAvatar': instance.robotAvatar,
      'robotBirthday': instance.robotBirthday,
      'robotCountry': instance.robotCountry,
      'robotNickname': instance.robotNickname,
      'userArea': instance.userArea,
      'userNickname': instance.userNickname,
    };
