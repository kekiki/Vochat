// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colive_moment_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColiveMomentItemModel _$ColiveMomentItemModelFromJson(
        Map<String, dynamic> json) =>
    ColiveMomentItemModel(
      json['area'] as String? ?? '',
      json['avatar'] as String? ?? '',
      (json['birthday'] as num?)?.toInt() ?? 0,
      json['content'] as String? ?? '',
      json['conversation_price'] as String? ?? '',
      json['country'] as String? ?? '',
      json['country_currency'] as String? ?? '',
      json['country_icon'] as String? ?? '',
      (json['create_time'] as num?)?.toInt() ?? 0,
      (json['id'] as num?)?.toInt() ?? 0,
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          [],
      (json['isRobot'] as num?)?.toInt() ?? 0,
      (json['like'] as num?)?.toInt() ?? 0,
      (json['likeNum'] as num?)?.toInt() ?? 0,
      json['nickname'] as String? ?? '',
      (json['online'] as num?)?.toInt() ?? 0,
      json['robotArea'] as String? ?? '',
      json['robotAvatar'] as String? ?? '',
      (json['robotBirthday'] as num?)?.toInt() ?? 0,
      json['robotCountry'] as String? ?? '',
      json['robotNickname'] as String? ?? '',
      json['status'] as String? ?? '',
      json['type'] as String? ?? '',
      (json['uid'] as num?)?.toInt() ?? 0,
      (json['update_time'] as num?)?.toInt() ?? 0,
      json['userArea'] as String? ?? '',
      json['isLike'] as bool? ?? false,
    );

Map<String, dynamic> _$ColiveMomentItemModelToJson(
        ColiveMomentItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'area': instance.area,
      'avatar': instance.avatar,
      'birthday': instance.birthday,
      'content': instance.content,
      'conversation_price': instance.conversationPrice,
      'country': instance.country,
      'country_currency': instance.countryCurrency,
      'country_icon': instance.countryIcon,
      'create_time': instance.createTime,
      'images': instance.images,
      'isRobot': instance.robot,
      'like': instance.like,
      'likeNum': instance.likeNum,
      'nickname': instance.nickname,
      'online': instance.online,
      'robotArea': instance.robotArea,
      'robotAvatar': instance.robotAvatar,
      'robotBirthday': instance.robotBirthday,
      'robotCountry': instance.robotCountry,
      'robotNickname': instance.robotNickname,
      'status': instance.status,
      'type': instance.type,
      'uid': instance.uid,
      'update_time': instance.updateTime,
      'userArea': instance.userArea,
      'isLike': instance.isLike,
    };
