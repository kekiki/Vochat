// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vochat_channel_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VochatChannelItemModel _$VochatChannelItemModelFromJson(
        Map<String, dynamic> json) =>
    VochatChannelItemModel(
      (json['channel_id'] as num?)?.toInt() ?? 0,
      json['channel_name'] as String? ?? '',
      json['currency'] as String? ?? '',
      (json['discount_coupon_num'] as num?)?.toInt() ?? 0,
      json['logo'] as String? ?? '',
      (json['price'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$VochatChannelItemModelToJson(
        VochatChannelItemModel instance) =>
    <String, dynamic>{
      'channel_id': instance.channelId,
      'channel_name': instance.channelName,
      'currency': instance.currency,
      'discount_coupon_num': instance.discountCouponNum,
      'logo': instance.logo,
      'price': instance.price,
    };
