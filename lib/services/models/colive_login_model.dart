//
//  ColiveLoginModel.dart
//
//
//  Created by JSONConverter on 2024/10/12.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'colive_login_model.g.dart';

@JsonSerializable()
class ColiveLoginModel extends Object {
  @JsonKey(name: 'is_new', defaultValue: 0)
  final int isNew;

  @JsonKey(name: 'token', defaultValue: '')
  final String token;

  @JsonKey(name: 'user')
  final ColiveLoginModelUser? user;

  @JsonKey(name: 'msg')
  final ColiveBannedMsgModel? msg;

  bool get isNewUser => isNew != 2;

  ColiveLoginModel(
    this.isNew,
    this.token,
    this.user,
    this.msg,
  );

  factory ColiveLoginModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ColiveLoginModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColiveLoginModelToJson(this);
}

@JsonSerializable()
class ColiveLoginModelUser extends Object {
  @JsonKey(name: 'accrued_diamonds', defaultValue: 0)
  final int accruedDiamonds;

  @JsonKey(name: 'app', defaultValue: '')
  final String app;

  @JsonKey(name: 'area', defaultValue: '')
  final String area;

  @JsonKey(name: 'avatar', defaultValue: '')
  final String avatar;

  @JsonKey(name: 'birthday', defaultValue: 0)
  final int birthday;

  @JsonKey(name: 'block', defaultValue: 0)
  final int block;

  @JsonKey(name: 'cardNum', defaultValue: 0)
  final int cardNum;

  @JsonKey(name: 'channel', defaultValue: '')
  final String channel;

  @JsonKey(name: 'countdowns', defaultValue: 0)
  final int countdowns;

  @JsonKey(name: 'country', defaultValue: '')
  final String country;

  @JsonKey(name: 'country_icon', defaultValue: '')
  final String countryIcon;

  @JsonKey(name: 'country_name', defaultValue: '')
  final String countryName;

  @JsonKey(name: 'create_time', defaultValue: 0)
  final int createTime;

  @JsonKey(name: 'custom_code', defaultValue: '')
  final String customCode;

  @JsonKey(name: 'device_id', defaultValue: '')
  final String deviceId;

  @JsonKey(name: 'diamonds', defaultValue: 0)
  final int diamonds;

  @JsonKey(name: 'disturb', defaultValue: '')
  final String disturb;

  @JsonKey(name: 'email', defaultValue: '')
  final String email;

  @JsonKey(name: 'facebook', defaultValue: '')
  final String facebook;

  @JsonKey(name: 'fans', defaultValue: 0)
  final int fans;

  @JsonKey(name: 'first_pay', defaultValue: false)
  final bool firstPay;

  @JsonKey(name: 'follow', defaultValue: 0)
  final int follow;

  @JsonKey(name: 'gender', defaultValue: '')
  final String gender;

  @JsonKey(name: 'google', defaultValue: '')
  final String google;

  @JsonKey(name: 'id', defaultValue: 0)
  final int id;

  @JsonKey(name: 'identity', defaultValue: 0)
  final int identity;

  @JsonKey(name: 'is_member', defaultValue: 0)
  final int isMember;

  @JsonKey(name: 'isOnline', defaultValue: 0)
  final int isOnline;

  @JsonKey(name: 'isZego', defaultValue: 0)
  final int isZego;

  @JsonKey(name: 'match_all_num', defaultValue: 0)
  final int matchAllNum;

  @JsonKey(name: 'match_num', defaultValue: 0)
  final int matchNum;

  @JsonKey(name: 'nickname', defaultValue: '')
  final String nickname;

  @JsonKey(name: 'password', defaultValue: '')
  final String password;

  @JsonKey(name: 'showCanleMsg', defaultValue: 0)
  final int showCanleMsg;

  @JsonKey(name: 'signature', defaultValue: '')
  final String signature;

  @JsonKey(name: 'sourceType', defaultValue: 0)
  final int sourceType;

  @JsonKey(name: 'status', defaultValue: 0)
  final int status;

  @JsonKey(name: 'sys', defaultValue: '')
  final String sys;

  @JsonKey(name: 'turntable_num', defaultValue: 0)
  final int turntableNum;

  @JsonKey(name: 'versionName', defaultValue: '')
  final String versionName;

  @JsonKey(name: 'vip_date', defaultValue: 0)
  final int vipDate;

  @JsonKey(name: 'watch_num', defaultValue: 0)
  final int watchNum;

  @JsonKey(name: 'watch_total', defaultValue: 0)
  final int watchTotal;

  bool get isVIP => vipDate > 0;

  const ColiveLoginModelUser(
    this.accruedDiamonds,
    this.app,
    this.area,
    this.avatar,
    this.birthday,
    this.block,
    this.cardNum,
    this.channel,
    this.countdowns,
    this.country,
    this.countryIcon,
    this.countryName,
    this.createTime,
    this.customCode,
    this.deviceId,
    this.diamonds,
    this.disturb,
    this.email,
    this.facebook,
    this.fans,
    this.firstPay,
    this.follow,
    this.gender,
    this.google,
    this.id,
    this.identity,
    this.isMember,
    this.isOnline,
    this.isZego,
    this.matchAllNum,
    this.matchNum,
    this.nickname,
    this.password,
    this.showCanleMsg,
    this.signature,
    this.sourceType,
    this.status,
    this.sys,
    this.turntableNum,
    this.versionName,
    this.vipDate,
    this.watchNum,
    this.watchTotal,
  );

  ColiveLoginModelUser copyWith({
    int? accruedDiamonds,
    String? app,
    String? area,
    String? avatar,
    int? birthday,
    int? block,
    int? cardNum,
    String? channel,
    int? countdowns,
    String? country,
    String? countryIcon,
    String? countryName,
    int? createTime,
    String? customCode,
    String? deviceId,
    int? diamonds,
    String? disturb,
    String? email,
    String? facebook,
    int? fans,
    bool? firstPay,
    int? follow,
    String? gender,
    String? google,
    int? id,
    int? identity,
    int? isMember,
    int? isOnline,
    int? isZego,
    int? matchAllNum,
    int? matchNum,
    String? nickname,
    String? password,
    int? showCanleMsg,
    String? signature,
    int? sourceType,
    int? status,
    String? sys,
    int? turntableNum,
    String? versionName,
    int? vipDate,
    int? watchNum,
    int? watchTotal,
  }) {
    return ColiveLoginModelUser(
      accruedDiamonds ?? this.accruedDiamonds,
      app ?? this.app,
      area ?? this.area,
      avatar ?? this.avatar,
      birthday ?? this.birthday,
      block ?? this.block,
      cardNum ?? this.cardNum,
      channel ?? this.channel,
      countdowns ?? this.countdowns,
      country ?? this.country,
      countryIcon ?? this.countryIcon,
      countryName ?? this.countryName,
      createTime ?? this.createTime,
      customCode ?? this.customCode,
      deviceId ?? this.deviceId,
      diamonds ?? this.diamonds,
      disturb ?? this.disturb,
      email ?? this.email,
      facebook ?? this.facebook,
      fans ?? this.fans,
      firstPay ?? this.firstPay,
      follow ?? this.follow,
      gender ?? this.gender,
      google ?? this.google,
      id ?? this.id,
      identity ?? this.identity,
      isMember ?? this.isMember,
      isOnline ?? this.isOnline,
      isZego ?? this.isZego,
      matchAllNum ?? this.matchAllNum,
      matchNum ?? this.matchNum,
      nickname ?? this.nickname,
      password ?? this.password,
      showCanleMsg ?? this.showCanleMsg,
      signature ?? this.signature,
      sourceType ?? this.sourceType,
      status ?? this.status,
      sys ?? this.sys,
      turntableNum ?? this.turntableNum,
      versionName ?? this.versionName,
      vipDate ?? this.vipDate,
      watchNum ?? this.watchNum,
      watchTotal ?? this.watchTotal,
    );
  }

  factory ColiveLoginModelUser.fromJson(Map<String, dynamic> json) =>
      // _$ColiveLoginModelUserFromJson(json);
      ColiveLoginModelUser(
        (json['accrued_diamonds'] as num?)?.toInt() ?? 0,
        json['app'] as String? ?? '',
        json['area'] as String? ?? '',
        json['avatar'] as String? ?? '',
        (json['birthday'] as num?)?.toInt() ?? 0,
        (json['block'] as num?)?.toInt() ?? 0,
        (json['cardNum'] as num?)?.toInt() ?? 0,
        json['channel'] as String? ?? '',
        (json['countdowns'] as num?)?.toInt() ?? 0,
        json['country'] as String? ?? '',
        json['country_icon'] as String? ?? '',
        json['country_name'] as String? ?? '',
        (json['create_time'] as num?)?.toInt() ?? 0,
        json['custom_code']?.toString() ?? '',
        json['device_id'] as String? ?? '',
        (json['diamonds'] as num?)?.toInt() ?? 0,
        json['disturb'] as String? ?? '',
        json['email'] as String? ?? '',
        json['facebook'] as String? ?? '',
        (json['fans'] as num?)?.toInt() ?? 0,
        json['first_pay'] as bool? ?? false,
        (json['follow'] as num?)?.toInt() ?? 0,
        json['gender']?.toString() ?? '',
        json['google'] as String? ?? '',
        (json['id'] as num?)?.toInt() ?? 0,
        (json['identity'] as num?)?.toInt() ?? 0,
        (json['is_member'] as num?)?.toInt() ?? 0,
        (json['isOnline'] as num?)?.toInt() ?? 0,
        (json['isZego'] as num?)?.toInt() ?? 0,
        (json['match_all_num'] as num?)?.toInt() ?? 0,
        (json['match_num'] as num?)?.toInt() ?? 0,
        json['nickname'] as String? ?? '',
        json['password'] as String? ?? '',
        (json['showCanleMsg'] as num?)?.toInt() ?? 0,
        json['signature'] as String? ?? '',
        int.tryParse((json['sourceType'].toString())) ?? 0,
        (json['status'] as num?)?.toInt() ?? 0,
        json['sys'] as String? ?? '',
        (json['turntable_num'] as num?)?.toInt() ?? 0,
        json['versionName'] as String? ?? '',
        (json['vip_date'] as num?)?.toInt() ?? 0,
        (json['watch_num'] as num?)?.toInt() ?? 0,
        (json['watch_total'] as num?)?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson() => _$ColiveLoginModelUserToJson(this);
}

@JsonSerializable()
class ColiveBannedMsgModel extends Object {
  @JsonKey(name: 'reason')
  String? reason;

  @JsonKey(name: 'title')
  String? title;

  ColiveBannedMsgModel(
    this.reason,
    this.title,
  );

  factory ColiveBannedMsgModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ColiveBannedMsgModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColiveBannedMsgModelToJson(this);
}
