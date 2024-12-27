// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colive_gift_base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColiveGiftBaseModel _$ColiveGiftBaseModelFromJson(Map<String, dynamic> json) =>
    ColiveGiftBaseModel(
      (json['backpack_gift_list'] as List<dynamic>?)
              ?.map((e) =>
                  ColiveGiftItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      (json['gift_list'] as List<dynamic>?)
              ?.map((e) =>
                  ColiveGiftItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      (json['vip_gift_list'] as List<dynamic>?)
              ?.map((e) =>
                  ColiveGiftItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ColiveGiftBaseModelToJson(
        ColiveGiftBaseModel instance) =>
    <String, dynamic>{
      'backpack_gift_list': instance.backpackGiftList,
      'gift_list': instance.giftList,
      'vip_gift_list': instance.vipGiftList,
    };

ColiveGiftItemModel _$ColiveGiftItemModelFromJson(Map<String, dynamic> json) =>
    ColiveGiftItemModel(
      json['area'] as String? ?? '',
      json['back_name'] as String? ?? '',
      json['cartoon_name'] as String? ?? '',
      json['cartoon_url'] as String? ?? '',
      (json['id'] as num?)?.toInt() ?? 0,
      json['logo'] as String? ?? '',
      json['name'] as String? ?? '',
      (json['price'] as num?)?.toInt() ?? 0,
      json['sku'] as String? ?? '',
      (json['sort'] as num?)?.toInt() ?? 0,
      json['status'] as String? ?? '',
    );

Map<String, dynamic> _$ColiveGiftItemModelToJson(
        ColiveGiftItemModel instance) =>
    <String, dynamic>{
      'area': instance.area,
      'back_name': instance.backName,
      'cartoon_name': instance.cartoonName,
      'cartoon_url': instance.cartoonUrl,
      'id': instance.id,
      'logo': instance.logo,
      'name': instance.name,
      'price': instance.price,
      'sku': instance.sku,
      'sort': instance.sort,
      'status': instance.status,
    };
