//
//  VochatProductBaseModel.dart
//
//
//  Created by JSONConverter on 2024/11/02.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';
import 'package:vochat/services/models/vochat_channel_item_model.dart';

import 'vochat_country_item_model.dart';

part 'vochat_product_base_model.g.dart';

@JsonSerializable()
class VochatProductBaseModel extends Object {
  @JsonKey(name: 'channel_country', defaultValue: '')
  final String channelCountry;

  @JsonKey(name: 'countdowns', defaultValue: 0)
  final int countdowns;

  @JsonKey(name: 'first_recharge_info', defaultValue: null)
  final VochatProductItemModel? firstRechargeInfo;

  @JsonKey(name: 'country_list', defaultValue: [])
  List<VochatCountryItemModel> countryList;

  @JsonKey(name: 'list', defaultValue: [])
  final List<VochatProductItemModel> list;

  VochatProductBaseModel(
    this.channelCountry,
    this.countdowns,
    this.firstRechargeInfo,
    this.countryList,
    this.list,
  );

  factory VochatProductBaseModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VochatProductBaseModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VochatProductBaseModelToJson(this);
}

@JsonSerializable()
class VochatProductItemModel extends Object {
  @JsonKey(name: 'channel', defaultValue: [])
  final List<VochatChannelItemModel> channelList;

  @JsonKey(name: 'currency', defaultValue: '')
  final String currency;

  @JsonKey(name: 'd_discount', defaultValue: 0)
  final int discount;

  @JsonKey(name: 'd_give_vip_day', defaultValue: 0)
  final int giveVipDay;

  @JsonKey(name: 'd_vip_user_extra_diamond_num', defaultValue: 0)
  final int vipUserExtraDiamondNum;

  @JsonKey(name: 'discount_coupon_num', defaultValue: 0)
  final int discountCouponNum;

  @JsonKey(name: 'extra_diamond_num', defaultValue: 0)
  final int extraDiamondNum;

  @JsonKey(name: 'give_num', defaultValue: 0)
  final int giveNum;

  @JsonKey(name: 'googel_id', defaultValue: '')
  final String productId;

  @JsonKey(name: 'id', defaultValue: 0)
  final int id;

  @JsonKey(name: 'is_first_recharge', defaultValue: 0)
  final int firstRecharge;

  @JsonKey(name: 'num', defaultValue: 0)
  final int num;

  @JsonKey(name: 'original_price', defaultValue: 0)
  final double originalPrice;

  @JsonKey(name: 'price', defaultValue: 0)
  final double price;

  @JsonKey(name: 'type', defaultValue: 0)
  final int type;

  @JsonKey(name: 'v_extra_item_count', defaultValue: 0)
  final int extraItemCount;

  @JsonKey(name: 'v_extra_item_id', defaultValue: 0)
  final int extraItemId;

  @JsonKey(name: 'vip_date', defaultValue: 0)
  final int vipDate;

  @JsonKey(name: 'vip_user_give_num', defaultValue: 0)
  final int vipUserGiveNum;

  bool get isFirstRecharge => firstRecharge == 1;
  bool get isDiamondProduct => type == 1;

  VochatProductItemModel(
    this.channelList,
    this.currency,
    this.discount,
    this.giveVipDay,
    this.vipUserExtraDiamondNum,
    this.discountCouponNum,
    this.extraDiamondNum,
    this.giveNum,
    this.productId,
    this.id,
    this.firstRecharge,
    this.num,
    this.originalPrice,
    this.price,
    this.type,
    this.extraItemCount,
    this.extraItemId,
    this.vipDate,
    this.vipUserGiveNum,
  );

  factory VochatProductItemModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VochatProductItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VochatProductItemModelToJson(this);
}
