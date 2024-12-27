// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colive_anchor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColiveAnchorDetailModel _$ColiveAnchorDetailModelFromJson(
        Map<String, dynamic> json) =>
    ColiveAnchorDetailModel(
      (json['album'] as List<dynamic>?)
              ?.map((e) =>
                  ColiveAnchorModelAlbum.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      (json['isGreet'] as num?)?.toInt() ?? 0,
      (json['label'] as List<dynamic>?)
              ?.map((e) => ColiveTagModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      json['star'] as String? ?? '0',
      ColiveAnchorModel.fromJson(json['user'] as Map<String, dynamic>),
      (json['chat_num'] as num?)?.toInt() ?? 0,
      json['is_toblock'] as bool? ?? false,
    );

Map<String, dynamic> _$ColiveAnchorDetailModelToJson(
        ColiveAnchorDetailModel instance) =>
    <String, dynamic>{
      'album': instance.album,
      'isGreet': instance.isGreet,
      'chat_num': instance.chatNum,
      'is_toblock': instance.isToBlock,
      'label': instance.label,
      'star': instance.star,
      'user': instance.user,
    };

ColiveAnchorModel _$ColiveAnchorModelFromJson(Map<String, dynamic> json) =>
    ColiveAnchorModel(
      json['app'] as String? ?? '',
      json['area'] as String? ?? '',
      json['avatar'] as String? ?? '',
      (json['birthday'] as num?)?.toInt() ?? 0,
      json['channel'] as String? ?? '',
      json['conversation_price'] as String? ?? '',
      json['country'] as String? ?? '',
      json['country_currency'] as String? ?? '',
      json['country_icon'] as String? ?? '',
      json['diamonds'] as String? ?? '',
      json['disturb'] as String? ?? '',
      json['gender'] as String? ?? '',
      (json['gold'] as num?)?.toInt() ?? 0,
      (json['id'] as num?)?.toInt() ?? 0,
      (json['isRobot'] as num?)?.toInt() ?? 0,
      (json['lv'] as num?)?.toInt() ?? 0,
      json['nickname'] as String? ?? '',
      (json['online'] as num?)?.toInt() ?? 0,
      json['signature'] as String? ?? '',
      json['sys'] as String? ?? '',
      (json['weight'] as num?)?.toInt() ?? 0,
      (json['album'] as List<dynamic>?)
              ?.map((e) =>
                  ColiveAnchorModelAlbum.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      (json['videos'] as List<dynamic>)
          .map(
              (e) => ColiveAnchorModelVideo.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['isGreet'] as num?)?.toInt() ?? 0,
      (json['label'] as List<dynamic>?)
              ?.map((e) => ColiveTagModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      json['star'] as String? ?? '0',
      (json['height'] as num?)?.toInt() ?? 0,
      json['emotion'] as String? ?? '',
      (json['like'] as num?)?.toInt() ?? 0,
      json['is_like'] as bool? ?? false,
      (json['chat_num'] as num?)?.toInt() ?? 0,
      json['is_toblock'] as bool? ?? false,
    );

Map<String, dynamic> _$ColiveAnchorModelToJson(ColiveAnchorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'app': instance.app,
      'area': instance.area,
      'avatar': instance.avatar,
      'birthday': instance.birthday,
      'channel': instance.channel,
      'conversation_price': instance.conversationPrice,
      'country': instance.country,
      'country_currency': instance.countryCurrency,
      'country_icon': instance.countryIcon,
      'diamonds': instance.diamonds,
      'disturb': instance.disturb,
      'gender': instance.gender,
      'gold': instance.gold,
      'isRobot': instance.robot,
      'lv': instance.lv,
      'online': instance.online,
      'signature': instance.signature,
      'sys': instance.sys,
      'weight': instance.weight,
      'album': instance.album,
      'videos': instance.videos,
      'isGreet': instance.isGreet,
      'label': instance.label,
      'star': instance.star,
      'height': instance.height,
      'emotion': instance.emotion,
      'like': instance.like,
      'is_like': instance.isLike,
      'chat_num': instance.chatNum,
      'is_toblock': instance.isToBlock,
    };

ColiveAnchorModelAlbum _$ColiveAnchorModelAlbumFromJson(
        Map<String, dynamic> json) =>
    ColiveAnchorModelAlbum(
      json['area'] as String? ?? '',
      json['channel'] as String? ?? '',
      json['country'] as String? ?? '',
      (json['create_time'] as num?)?.toInt() ?? 0,
      (json['id'] as num?)?.toInt() ?? 0,
      json['images'] as String? ?? '',
      (json['is_vip'] as num?)?.toInt() ?? 0,
      json['sys'] as String? ?? '',
    );

Map<String, dynamic> _$ColiveAnchorModelAlbumToJson(
        ColiveAnchorModelAlbum instance) =>
    <String, dynamic>{
      'area': instance.area,
      'channel': instance.channel,
      'country': instance.country,
      'create_time': instance.createTime,
      'id': instance.id,
      'images': instance.images,
      'is_vip': instance.isVip,
      'sys': instance.sys,
    };

ColiveAnchorModelVideo _$ColiveAnchorModelVideoFromJson(
        Map<String, dynamic> json) =>
    ColiveAnchorModelVideo(
      json['area'] as String? ?? '',
      json['channel'] as String? ?? '',
      json['country'] as String? ?? '',
      (json['create_time'] as num?)?.toInt() ?? 0,
      (json['id'] as num?)?.toInt() ?? 0,
      (json['duration'] as num?)?.toInt() ?? 0,
      json['video'] as String? ?? '',
      (json['is_vip'] as num?)?.toInt() ?? 0,
      json['sys'] as String? ?? '',
    );

Map<String, dynamic> _$ColiveAnchorModelVideoToJson(
        ColiveAnchorModelVideo instance) =>
    <String, dynamic>{
      'area': instance.area,
      'channel': instance.channel,
      'country': instance.country,
      'create_time': instance.createTime,
      'id': instance.id,
      'duration': instance.duration,
      'video': instance.video,
      'is_vip': instance.isVip,
      'sys': instance.sys,
    };

ColiveTagModel _$ColiveTagModelFromJson(Map<String, dynamic> json) =>
    ColiveTagModel(
      json['bg_color'] as String? ?? '',
      (json['id'] as num?)?.toInt() ?? 0,
      (json['num'] as num?)?.toInt() ?? 0,
      json['wd_color'] as String? ?? '',
      json['word'] as String? ?? '',
    );

Map<String, dynamic> _$ColiveTagModelToJson(ColiveTagModel instance) =>
    <String, dynamic>{
      'bg_color': instance.bgColor,
      'id': instance.id,
      'num': instance.num,
      'wd_color': instance.wdColor,
      'word': instance.word,
    };