// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vochat_login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VochatLoginModel _$VochatLoginModelFromJson(Map<String, dynamic> json) =>
    VochatLoginModel(
      (json['is_new'] as num?)?.toInt() ?? 0,
      json['token'] as String? ?? '',
      json['user'] == null
          ? null
          : VochatLoginModelUser.fromJson(json['user'] as Map<String, dynamic>),
      json['msg'] == null
          ? null
          : VochatBannedMsgModel.fromJson(json['msg'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VochatLoginModelToJson(VochatLoginModel instance) =>
    <String, dynamic>{
      'is_new': instance.isNew,
      'token': instance.token,
      'user': instance.user,
      'msg': instance.msg,
    };

VochatLoginModelUser _$VochatLoginModelUserFromJson(
        Map<String, dynamic> json) =>
    VochatLoginModelUser(
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
      json['custom_code'] as String? ?? '',
      json['device_id'] as String? ?? '',
      (json['diamonds'] as num?)?.toInt() ?? 0,
      json['disturb'] as String? ?? '',
      json['email'] as String? ?? '',
      json['facebook'] as String? ?? '',
      (json['fans'] as num?)?.toInt() ?? 0,
      json['first_pay'] as bool? ?? false,
      (json['follow'] as num?)?.toInt() ?? 0,
      json['gender'] as String? ?? '',
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
      (json['sourceType'] as num?)?.toInt() ?? 0,
      (json['status'] as num?)?.toInt() ?? 0,
      json['sys'] as String? ?? '',
      (json['turntable_num'] as num?)?.toInt() ?? 0,
      json['versionName'] as String? ?? '',
      (json['vip_date'] as num?)?.toInt() ?? 0,
      (json['watch_num'] as num?)?.toInt() ?? 0,
      (json['watch_total'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$VochatLoginModelUserToJson(
        VochatLoginModelUser instance) =>
    <String, dynamic>{
      'accrued_diamonds': instance.accruedDiamonds,
      'app': instance.app,
      'area': instance.area,
      'avatar': instance.avatar,
      'birthday': instance.birthday,
      'block': instance.block,
      'cardNum': instance.cardNum,
      'channel': instance.channel,
      'countdowns': instance.countdowns,
      'country': instance.country,
      'country_icon': instance.countryIcon,
      'country_name': instance.countryName,
      'create_time': instance.createTime,
      'custom_code': instance.customCode,
      'device_id': instance.deviceId,
      'diamonds': instance.diamonds,
      'disturb': instance.disturb,
      'email': instance.email,
      'facebook': instance.facebook,
      'fans': instance.fans,
      'first_pay': instance.firstPay,
      'follow': instance.follow,
      'gender': instance.gender,
      'google': instance.google,
      'id': instance.id,
      'identity': instance.identity,
      'is_member': instance.isMember,
      'isOnline': instance.isOnline,
      'isZego': instance.isZego,
      'match_all_num': instance.matchAllNum,
      'match_num': instance.matchNum,
      'nickname': instance.nickname,
      'password': instance.password,
      'showCanleMsg': instance.showCanleMsg,
      'signature': instance.signature,
      'sourceType': instance.sourceType,
      'status': instance.status,
      'sys': instance.sys,
      'turntable_num': instance.turntableNum,
      'versionName': instance.versionName,
      'vip_date': instance.vipDate,
      'watch_num': instance.watchNum,
      'watch_total': instance.watchTotal,
    };

VochatBannedMsgModel _$VochatBannedMsgModelFromJson(
        Map<String, dynamic> json) =>
    VochatBannedMsgModel(
      json['reason'] as String?,
      json['title'] as String?,
    );

Map<String, dynamic> _$VochatBannedMsgModelToJson(
        VochatBannedMsgModel instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'title': instance.title,
    };
