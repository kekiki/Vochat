//
//  VochatAnchorModel.dart
//
//
//  Created by JSONConverter on 2024/10/12.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:floor/floor.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/adapts/vochat_colors.dart';
import '../../common/database/converters/vochat_list_album_converter.dart';
import '../../common/database/converters/vochat_list_tag_converter.dart';
import '../../common/database/converters/vochat_list_video_converter.dart';

part 'vochat_anchor_model.g.dart';

@JsonSerializable()
class VochatAnchorDetailModel extends Object {
  @JsonKey(name: 'album', defaultValue: [])
  final List<VochatAnchorModelAlbum> album;

  @JsonKey(name: 'isGreet', defaultValue: 0)
  final int isGreet;

  @JsonKey(name: 'chat_num', defaultValue: 0)
  final int chatNum;

  @JsonKey(name: 'is_toblock', defaultValue: false)
  final bool isToBlock;

  @JsonKey(name: 'label', defaultValue: [])
  final List<VochatTagModel> label;

  @JsonKey(name: 'star', defaultValue: '0')
  final String star;

  @JsonKey(name: 'user')
  VochatAnchorModel user;

  VochatAnchorDetailModel(
    this.album,
    this.isGreet,
    this.label,
    this.star,
    this.user,
    this.chatNum,
    this.isToBlock,
  );

  VochatAnchorModel get toAnchorModel => user.copyWith(
        album: album,
        isGreet: isGreet,
        label: label,
        star: star,
        chatNum: chatNum,
        isToBlock: isToBlock,
      );

  factory VochatAnchorDetailModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VochatAnchorDetailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VochatAnchorDetailModelToJson(this);
}

@JsonSerializable()
@Entity(tableName: 'database_table_anchor_info')
@TypeConverters([
  VochatListTagConverter,
  VochatListAlbumConverter,
  VochatListVideoConverter,
])
class VochatAnchorModel extends Object {
  @primaryKey
  @JsonKey(name: 'id', defaultValue: 0)
  final int id;

  @JsonKey(name: 'nickname', defaultValue: '')
  final String nickname;

  @JsonKey(name: 'app', defaultValue: '')
  final String app;

  @JsonKey(name: 'area', defaultValue: '')
  final String area;

  @JsonKey(name: 'avatar', defaultValue: '')
  final String avatar;

  @JsonKey(name: 'birthday', defaultValue: 0)
  final int birthday;

  @JsonKey(name: 'channel', defaultValue: '')
  final String channel;

  @JsonKey(name: 'conversation_price', defaultValue: '')
  final String conversationPrice;

  @JsonKey(name: 'country', defaultValue: '')
  final String country;

  @JsonKey(name: 'country_currency', defaultValue: '')
  final String countryCurrency;

  @JsonKey(name: 'country_icon', defaultValue: '')
  final String countryIcon;

  @JsonKey(name: 'diamonds', defaultValue: '')
  final String diamonds;

  @JsonKey(name: 'disturb', defaultValue: '')
  final String disturb;

  @JsonKey(name: 'gender', defaultValue: '')
  final String gender;

  @JsonKey(name: 'gold', defaultValue: 0)
  final int gold;

  @JsonKey(name: 'isRobot', defaultValue: 0)
  final int robot;

  @JsonKey(name: 'lv', defaultValue: 0)
  final int lv;

  @JsonKey(name: 'online', defaultValue: 0)
  int online;

  @JsonKey(name: 'signature', defaultValue: '')
  final String signature;

  @JsonKey(name: 'sys', defaultValue: '')
  final String sys;

  @JsonKey(name: 'weight', defaultValue: 0)
  final int weight;

  @JsonKey(name: 'album', defaultValue: [])
  final List<VochatAnchorModelAlbum> album;

  @JsonKey(name: 'videos')
  List<VochatAnchorModelVideo> videos = [];

  @JsonKey(name: 'isGreet', defaultValue: 0)
  final int isGreet;

  @JsonKey(name: 'label', defaultValue: [])
  final List<VochatTagModel> label;

  @JsonKey(name: 'star', defaultValue: '0')
  final String star;

  @JsonKey(name: 'height', defaultValue: 0)
  final int height;

  @JsonKey(name: 'emotion', defaultValue: '')
  final String emotion;

  @JsonKey(name: 'like', defaultValue: 0)
  final int like;

  @JsonKey(name: 'is_like', defaultValue: false)
  final bool isLike;

  @JsonKey(name: 'chat_num', defaultValue: 0)
  final int chatNum;

  @JsonKey(name: 'is_toblock', defaultValue: false)
  final bool isToBlock;

  Color get statusColor {
    return online == 1
        ? VochatColors.onlineColor
        : online == 2
            ? VochatColors.busyColor
            : VochatColors.offlineColor;
  }

  String get statusText {
    return online == 1
        ? 'vochat_online'.tr
        : online == 2
            ? 'vochat_busy'.tr
            : 'vochat_offline'.tr;
  }

  bool get isOnline => online == 1;

  bool get isRobot => robot == 1;

  String get sessionId => isRobot ? 'hichat_robot_$id' : 'hichat_anchor_$id';

  int get age {
    DateTime currentDate = DateTime.now();
    DateTime birthDate = DateTime.fromMillisecondsSinceEpoch(birthday * 1000);
    Duration difference = currentDate.difference(birthDate);
    return (difference.inDays / 365).floor();
  }

  VochatAnchorModel(
    this.app,
    this.area,
    this.avatar,
    this.birthday,
    this.channel,
    this.conversationPrice,
    this.country,
    this.countryCurrency,
    this.countryIcon,
    this.diamonds,
    this.disturb,
    this.gender,
    this.gold,
    this.id,
    this.robot,
    this.lv,
    this.nickname,
    this.online,
    this.signature,
    this.sys,
    this.weight,
    this.album,
    this.videos,
    this.isGreet,
    this.label,
    this.star,
    this.height,
    this.emotion,
    this.like,
    this.isLike,
    this.chatNum,
    this.isToBlock,
  );

  VochatAnchorModel copyWith({
    String? app,
    String? area,
    String? avatar,
    int? birthday,
    String? channel,
    String? conversationPrice,
    String? country,
    String? countryCurrency,
    String? countryIcon,
    String? diamonds,
    String? disturb,
    String? gender,
    int? gold,
    int? id,
    int? robot,
    int? lv,
    String? nickname,
    int? online,
    String? signature,
    String? sys,
    int? weight,
    List<VochatAnchorModelAlbum>? album,
    List<VochatAnchorModelVideo>? videos,
    int? isGreet,
    List<VochatTagModel>? label,
    String? star,
    int? height,
    String? emotion,
    int? like,
    bool? isLike,
    bool? isBlock,
    int? chatNum,
    bool? isToBlock,
  }) {
    return VochatAnchorModel(
      app ?? this.app,
      area ?? this.area,
      avatar ?? this.avatar,
      birthday ?? this.birthday,
      channel ?? this.channel,
      conversationPrice ?? this.conversationPrice,
      country ?? this.country,
      countryCurrency ?? this.countryCurrency,
      countryIcon ?? this.countryIcon,
      diamonds ?? this.diamonds,
      disturb ?? this.disturb,
      gender ?? this.gender,
      gold ?? this.gold,
      id ?? this.id,
      robot ?? this.robot,
      lv ?? this.lv,
      nickname ?? this.nickname,
      online ?? this.online,
      signature ?? this.signature,
      sys ?? this.sys,
      weight ?? this.weight,
      album ?? this.album,
      videos ?? this.videos,
      isGreet ?? this.isGreet,
      label ?? this.label,
      star ?? this.star,
      height ?? this.height,
      emotion ?? this.emotion,
      like ?? this.like,
      isLike ?? this.isLike,
      chatNum ?? this.chatNum,
      isToBlock ?? this.isToBlock,
    );
  }

  factory VochatAnchorModel.fromJson(Map<String, dynamic> json) =>
      VochatAnchorModel(
        json['app'] as String? ?? '',
        json['area'] as String? ?? '',
        json['avatar'] as String? ?? '',
        (json['birthday'] as num?)?.toInt() ?? 0,
        json['channel'] as String? ?? '',
        (json['conversation_price'])?.toString() ?? '0',
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
                    VochatAnchorModelAlbum.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        (json['videos'] as List<dynamic>?)
                ?.map((e) =>
                    VochatAnchorModelVideo.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        (json['online'] as num?)?.toInt() ?? 0,
        (json['label'] as List<dynamic>?)
                ?.map((e) => VochatTagModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        json['star'] as String? ?? '0',
        (json['height'] as num?)?.toInt() ?? 0,
        json['emotion'] as String? ?? '',
        (json['like'] as num?)?.toInt() ?? 0,
        (json['is_like'] as bool?) ?? false,
        (json['chat_num'] as num?)?.toInt() ?? 0,
        (json['is_toblock'] as bool?) ?? false,
      );

  Map<String, dynamic> toJson() => _$VochatAnchorModelToJson(this);
}

@JsonSerializable()
class VochatAnchorModelAlbum extends Object {
  @JsonKey(name: 'area', defaultValue: '')
  final String area;

  @JsonKey(name: 'channel', defaultValue: '')
  final String channel;

  @JsonKey(name: 'country', defaultValue: '')
  final String country;

  @JsonKey(name: 'create_time', defaultValue: 0)
  final int createTime;

  @JsonKey(name: 'id', defaultValue: 0)
  final int id;

  @JsonKey(name: 'images', defaultValue: '')
  final String images;

  @JsonKey(name: 'is_vip', defaultValue: 0)
  final int isVip;

  @JsonKey(name: 'sys', defaultValue: '')
  final String sys;

  VochatAnchorModelAlbum(
    this.area,
    this.channel,
    this.country,
    this.createTime,
    this.id,
    this.images,
    this.isVip,
    this.sys,
  );

  factory VochatAnchorModelAlbum.fromJson(Map<String, dynamic> srcJson) =>
      _$VochatAnchorModelAlbumFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VochatAnchorModelAlbumToJson(this);
}

@JsonSerializable()
class VochatAnchorModelVideo extends Object {
  @JsonKey(name: 'area', defaultValue: '')
  final String area;

  @JsonKey(name: 'channel', defaultValue: '')
  final String channel;

  @JsonKey(name: 'country', defaultValue: '')
  final String country;

  @JsonKey(name: 'create_time', defaultValue: 0)
  final int createTime;

  @JsonKey(name: 'id', defaultValue: 0)
  final int id;

  @JsonKey(name: 'duration', defaultValue: 0)
  final int duration;

  @JsonKey(name: 'video', defaultValue: '')
  final String video;

  @JsonKey(name: 'is_vip', defaultValue: 0)
  final int isVip;

  @JsonKey(name: 'sys', defaultValue: '')
  final String sys;

  VochatAnchorModelVideo(
    this.area,
    this.channel,
    this.country,
    this.createTime,
    this.id,
    this.duration,
    this.video,
    this.isVip,
    this.sys,
  );

  factory VochatAnchorModelVideo.fromJson(Map<String, dynamic> srcJson) =>
      _$VochatAnchorModelVideoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VochatAnchorModelVideoToJson(this);
}

@JsonSerializable()
class VochatTagModel extends Object {
  @JsonKey(name: 'bg_color', defaultValue: '')
  final String bgColor;

  @JsonKey(name: 'id', defaultValue: 0)
  final int id;

  @JsonKey(name: 'num', defaultValue: 0)
  final int num;

  @JsonKey(name: 'wd_color', defaultValue: '')
  final String wdColor;

  @JsonKey(name: 'word', defaultValue: '')
  final String word;

  VochatTagModel(
    this.bgColor,
    this.id,
    this.num,
    this.wdColor,
    this.word,
  );

  factory VochatTagModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VochatTagModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VochatTagModelToJson(this);
}
