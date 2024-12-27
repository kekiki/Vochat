//
//  ColiveFollowModel.dart
//
//
//  Created by JSONConverter on 2024/10/30.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:colive/services/managers/colive_profile_manager.dart';

import '../database/converters/colive_list_string_converter.dart';
import 'colive_anchor_model.dart';

part 'colive_moment_item_model.g.dart';

@JsonSerializable()
@Entity(tableName: 'database_table_moment_info')
@TypeConverters([ColiveListStringConverter])
class ColiveMomentItemModel extends Object {
  @primaryKey
  @JsonKey(name: 'id', defaultValue: 0)
  final int id;

  @JsonKey(name: 'area', defaultValue: '')
  final String area;

  @JsonKey(name: 'avatar', defaultValue: '')
  final String avatar;

  @JsonKey(name: 'birthday', defaultValue: 0)
  final int birthday;

  @JsonKey(name: 'content', defaultValue: '')
  final String content;

  @JsonKey(name: 'conversation_price', defaultValue: '')
  final String conversationPrice;

  @JsonKey(name: 'country', defaultValue: '')
  final String country;

  @JsonKey(name: 'country_currency', defaultValue: '')
  final String countryCurrency;

  @JsonKey(name: 'country_icon', defaultValue: '')
  final String countryIcon;

  @JsonKey(name: 'create_time', defaultValue: 0)
  final int createTime;

  @JsonKey(name: 'images', defaultValue: [])
  final List<String> images;

  @JsonKey(name: 'isRobot', defaultValue: 0)
  final int robot;

  @JsonKey(name: 'like', defaultValue: 0)
  final int like;

  @JsonKey(name: 'likeNum', defaultValue: 0)
  final int likeNum;

  @JsonKey(name: 'nickname', defaultValue: '')
  final String nickname;

  @JsonKey(name: 'online', defaultValue: 0)
  final int online;

  @JsonKey(name: 'robotArea', defaultValue: '')
  final String robotArea;

  @JsonKey(name: 'robotAvatar', defaultValue: '')
  final String robotAvatar;

  @JsonKey(name: 'robotBirthday', defaultValue: 0)
  final int robotBirthday;

  @JsonKey(name: 'robotCountry', defaultValue: '')
  final String robotCountry;

  @JsonKey(name: 'robotNickname', defaultValue: '')
  final String robotNickname;

  @JsonKey(name: 'status', defaultValue: '')
  final String status;

  @JsonKey(name: 'type', defaultValue: '')
  final String type;

  @JsonKey(name: 'uid', defaultValue: 0)
  final int uid;

  @JsonKey(name: 'update_time', defaultValue: 0)
  final int updateTime;

  @JsonKey(name: 'userArea', defaultValue: '')
  final String userArea;

  @JsonKey(name: 'isLike', defaultValue: false)
  final bool isLike;

  bool get isMine => uid == ColiveProfileManager.instance.userInfo.id;

  ColiveMomentItemModel(
    this.area,
    this.avatar,
    this.birthday,
    this.content,
    this.conversationPrice,
    this.country,
    this.countryCurrency,
    this.countryIcon,
    this.createTime,
    this.id,
    this.images,
    this.robot,
    this.like,
    this.likeNum,
    this.nickname,
    this.online,
    this.robotArea,
    this.robotAvatar,
    this.robotBirthday,
    this.robotCountry,
    this.robotNickname,
    this.status,
    this.type,
    this.uid,
    this.updateTime,
    this.userArea,
    this.isLike,
  );

  ColiveMomentItemModel copyWith({
    String? area,
    String? avatar,
    int? birthday,
    String? content,
    String? conversationPrice,
    String? country,
    String? countryCurrency,
    String? countryIcon,
    int? createTime,
    int? id,
    List<String>? images,
    int? robot,
    int? like,
    int? likeNum,
    String? nickname,
    int? online,
    String? robotArea,
    String? robotAvatar,
    int? robotBirthday,
    String? robotCountry,
    String? robotNickname,
    String? status,
    String? type,
    int? uid,
    int? updateTime,
    String? userArea,
    bool? isLike,
  }) {
    return ColiveMomentItemModel(
      area ?? this.area,
      avatar ?? this.avatar,
      birthday ?? this.birthday,
      content ?? this.content,
      conversationPrice ?? this.conversationPrice,
      country ?? this.country,
      countryCurrency ?? this.countryCurrency,
      countryIcon ?? this.countryIcon,
      createTime ?? this.createTime,
      id ?? this.id,
      images ?? this.images,
      robot ?? this.robot,
      like ?? this.like,
      likeNum ?? this.likeNum,
      nickname ?? this.nickname,
      online ?? this.online,
      robotArea ?? this.robotArea,
      robotAvatar ?? this.robotAvatar,
      robotBirthday ?? this.robotBirthday,
      robotCountry ?? this.robotCountry,
      robotNickname ?? this.robotNickname,
      status ?? this.status,
      type ?? this.type,
      uid ?? this.uid,
      updateTime ?? this.updateTime,
      userArea ?? this.userArea,
      isLike ?? this.isLike,
    );
  }

  bool get isRobot => robot == 1;

  ColiveAnchorModel get toAnchorModel =>
      ColiveAnchorModel.fromJson({}).copyWith(
        id: uid,
        robot: robot,
        area: isRobot ? robotArea : area,
        nickname: isRobot ? robotNickname : nickname,
        avatar: isRobot ? robotAvatar : avatar,
        country: isRobot ? robotCountry : country,
        birthday: birthday,
        online: online,
        countryIcon: countryIcon,
        countryCurrency: countryCurrency,
        conversationPrice: conversationPrice.toString(),
      );

  factory ColiveMomentItemModel.fromJson(Map<String, dynamic> json) =>
      // _$ColiveMomentItemModelFromJson(srcJson);
      ColiveMomentItemModel(
        json['area'] as String? ?? '',
        json['avatar'] as String? ?? '',
        (json['birthday'] as num?)?.toInt() ?? 0,
        json['content'] as String? ?? '',
        (json['conversation_price'])?.toString() ?? '',
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

  Map<String, dynamic> toJson() => _$ColiveMomentItemModelToJson(this);
}
