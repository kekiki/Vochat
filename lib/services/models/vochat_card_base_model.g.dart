// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vochat_card_base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VochatCardBaseModel _$VochatCardBaseModelFromJson(Map<String, dynamic> json) =>
    VochatCardBaseModel(
      (json['discount_coupon'] as List<dynamic>?)
              ?.map((e) =>
                  VochatCardItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      (json['video_coupon'] as List<dynamic>?)
              ?.map((e) =>
                  VochatCardItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$VochatCardBaseModelToJson(
        VochatCardBaseModel instance) =>
    <String, dynamic>{
      'discount_coupon': instance.discountCoupon,
      'video_coupon': instance.videoCoupon,
    };

VochatCardItemModel _$VochatCardItemModelFromJson(Map<String, dynamic> json) =>
    VochatCardItemModel(
      json['desc'] as String? ?? '',
      (json['expireTime'] as num?)?.toInt() ?? 0,
      json['ext'] as String? ?? '',
      json['icon'] as String? ?? '',
      (json['id'] as num?)?.toInt() ?? 0,
      json['img'] as String? ?? '',
      (json['itemId'] as num?)?.toInt() ?? 0,
      (json['itemType'] as num?)?.toInt() ?? 0,
      json['name'] as String? ?? '',
      (json['num'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$VochatCardItemModelToJson(
        VochatCardItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'desc': instance.desc,
      'expireTime': instance.expireTime,
      'ext': instance.ext,
      'icon': instance.icon,
      'img': instance.img,
      'itemId': instance.itemId,
      'itemType': instance.itemType,
      'name': instance.name,
      'num': instance.num,
    };
