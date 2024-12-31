// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cochat_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CochatUserModel _$CochatUserModelFromJson(Map<String, dynamic> json) =>
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

Map<String, dynamic> _$CochatUserModelToJson(CochatUserModel instance) =>
    <String, dynamic>{
      'channel': instance.channel,
      'created_at': instance.createdAt,
      'createtime': instance.createTime,
      'expires_in': instance.expiresIn,
      'expiretime': instance.expiretime,
      'headimgurl': instance.avatar,
      'id': instance.id,
      'isAnchor': instance.anchor,
      'isChild': instance.child,
      'isVideoAnchor': instance.videoAnchor,
      'login_ip': instance.loginIp,
      'mizuan': instance.mizuan,
      'nickname': instance.nickname,
      'only_code': instance.onlyCode,
      'phone': instance.phone,
      'status': instance.status,
      'status_login': instance.statusLogin,
      'title': instance.title,
      'token': instance.token,
      'xindong': instance.xindong,
    };
