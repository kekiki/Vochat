//
//  CochatUserModel.dart
//
//
//  Created by JSONConverter on 2024/12/28.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'cochat_user_model.g.dart';

@JsonSerializable()
class CochatUserModel extends Object {
  @JsonKey(name: 'channel', defaultValue: '')
  final String channel;

  @JsonKey(name: 'created_at', defaultValue: 0)
  final int createdAt;

  @JsonKey(name: 'createtime', defaultValue: 0)
  final int createTime;

  @JsonKey(name: 'expires_in', defaultValue: 0)
  final int expiresIn;

  @JsonKey(name: 'expiretime', defaultValue: 0)
  final int expiretime;

  @JsonKey(name: 'headimgurl', defaultValue: '')
  final String avatar;

  @JsonKey(name: 'id', defaultValue: 0)
  final int id;

  @JsonKey(name: 'isAnchor', defaultValue: 0)
  final int anchor;

  @JsonKey(name: 'isChild', defaultValue: 0)
  final int child;

  @JsonKey(name: 'isVideoAnchor', defaultValue: 0)
  final int videoAnchor;

  @JsonKey(name: 'login_ip', defaultValue: '')
  final String loginIp;

  @JsonKey(name: 'mizuan', defaultValue: 0)
  final int mizuan;

  @JsonKey(name: 'nickname', defaultValue: '')
  final String nickname;

  @JsonKey(name: 'only_code', defaultValue: '')
  final String onlyCode;

  @JsonKey(name: 'phone', defaultValue: '')
  final String phone;

  @JsonKey(name: 'status', defaultValue: 0)
  final int status;

  @JsonKey(name: 'status_login', defaultValue: 0)
  final int statusLogin;

  @JsonKey(name: 'title', defaultValue: '')
  final String title;

  @JsonKey(name: 'token', defaultValue: '')
  final String token;

  @JsonKey(name: 'xindong', defaultValue: 0)
  final int xindong;

  bool get isNoInformation => statusLogin == 2;

  CochatUserModel(
    this.channel,
    this.createdAt,
    this.createTime,
    this.expiresIn,
    this.expiretime,
    this.avatar,
    this.id,
    this.anchor,
    this.child,
    this.videoAnchor,
    this.loginIp,
    this.mizuan,
    this.nickname,
    this.onlyCode,
    this.phone,
    this.status,
    this.statusLogin,
    this.title,
    this.token,
    this.xindong,
  );

  factory CochatUserModel.fromJson(Map<dynamic, dynamic> json) =>
      // _$CochatUserModelFromJson(srcJson);
      CochatUserModel(
        json['channel'] as String? ?? '',
        (json['created_at'] as num?)?.toInt() ?? 0,
        (json['createtime'] as num?)?.toInt() ?? 0,
        (json['expires_in'] as num?)?.toInt() ?? 0,
        (json['expiretime'] as num?)?.toInt() ?? 0,
        json['headimgurl'] as String? ?? '',
        (json['id'] as num?)?.toInt() ?? 0,
        (json['isAnchor'] as num?)?.toInt() ?? 0,
        (json['isChild'] as num?)?.toInt() ?? 0,
        (json['isVideoAnchor'] as num?)?.toInt() ?? 0,
        json['login_ip'] as String? ?? '',
        (json['mizuan'] as num?)?.toInt() ?? 0,
        json['nickname'] as String? ?? '',
        json['only_code'] as String? ?? '',
        json['phone'] as String? ?? '',
        (json['status'] as num?)?.toInt() ?? 0,
        (json['status_login'] as num?)?.toInt() ?? 0,
        json['title'] as String? ?? '',
        json['token'] as String? ?? '',
        (json['xindong'] as num?)?.toInt() ?? 0,
      );

  Map<dynamic, dynamic> toJson() => _$CochatUserModelToJson(this);
}
