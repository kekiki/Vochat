// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vochat_product_base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VochatProductBaseModel _$VochatProductBaseModelFromJson(
        Map<String, dynamic> json) =>
    VochatProductBaseModel(
      json['channel_country'] as String? ?? '',
      (json['countdowns'] as num?)?.toInt() ?? 0,
      json['first_recharge_info'] == null
          ? null
          : VochatProductItemModel.fromJson(
              json['first_recharge_info'] as Map<String, dynamic>),
      (json['country_list'] as List<dynamic>?)
              ?.map((e) =>
                  VochatCountryItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      (json['list'] as List<dynamic>?)
              ?.map((e) =>
                  VochatProductItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$VochatProductBaseModelToJson(
        VochatProductBaseModel instance) =>
    <String, dynamic>{
      'channel_country': instance.channelCountry,
      'countdowns': instance.countdowns,
      'first_recharge_info': instance.firstRechargeInfo,
      'country_list': instance.countryList,
      'list': instance.list,
    };

VochatProductItemModel _$VochatProductItemModelFromJson(
        Map<String, dynamic> json) =>
    VochatProductItemModel(
      (json['channel'] as List<dynamic>?)
              ?.map((e) =>
                  VochatChannelItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      json['currency'] as String? ?? '',
      (json['d_discount'] as num?)?.toInt() ?? 0,
      (json['d_give_vip_day'] as num?)?.toInt() ?? 0,
      (json['d_vip_user_extra_diamond_num'] as num?)?.toInt() ?? 0,
      (json['discount_coupon_num'] as num?)?.toInt() ?? 0,
      (json['extra_diamond_num'] as num?)?.toInt() ?? 0,
      (json['give_num'] as num?)?.toInt() ?? 0,
      json['googel_id'] as String? ?? '',
      (json['id'] as num?)?.toInt() ?? 0,
      (json['is_first_recharge'] as num?)?.toInt() ?? 0,
      (json['num'] as num?)?.toInt() ?? 0,
      (json['original_price'] as num?)?.toDouble() ?? 0,
      (json['price'] as num?)?.toDouble() ?? 0,
      (json['type'] as num?)?.toInt() ?? 0,
      (json['v_extra_item_count'] as num?)?.toInt() ?? 0,
      (json['v_extra_item_id'] as num?)?.toInt() ?? 0,
      (json['vip_date'] as num?)?.toInt() ?? 0,
      (json['vip_user_give_num'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$VochatProductItemModelToJson(
        VochatProductItemModel instance) =>
    <String, dynamic>{
      'channel': instance.channelList,
      'currency': instance.currency,
      'd_discount': instance.discount,
      'd_give_vip_day': instance.giveVipDay,
      'd_vip_user_extra_diamond_num': instance.vipUserExtraDiamondNum,
      'discount_coupon_num': instance.discountCouponNum,
      'extra_diamond_num': instance.extraDiamondNum,
      'give_num': instance.giveNum,
      'googel_id': instance.productId,
      'id': instance.id,
      'is_first_recharge': instance.firstRecharge,
      'num': instance.num,
      'original_price': instance.originalPrice,
      'price': instance.price,
      'type': instance.type,
      'v_extra_item_count': instance.extraItemCount,
      'v_extra_item_id': instance.extraItemId,
      'vip_date': instance.vipDate,
      'vip_user_give_num': instance.vipUserGiveNum,
    };
