//
//  VochatCardBaseModel.dart
//
//
//  Created by JSONConverter on 2024/11/13.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vochat_card_base_model.g.dart';

@JsonSerializable()
class VochatCardBaseModel extends Object {
  @JsonKey(name: 'discount_coupon', defaultValue: [])
  final List<VochatCardItemModel> discountCoupon;

  @JsonKey(name: 'video_coupon', defaultValue: [])
  final List<VochatCardItemModel> videoCoupon;

  VochatCardBaseModel(
    this.discountCoupon,
    this.videoCoupon,
  );

  factory VochatCardBaseModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VochatCardBaseModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VochatCardBaseModelToJson(this);
}

@Entity(tableName: "database_table_cards")
@JsonSerializable()
class VochatCardItemModel extends Object {
  @primaryKey
  @JsonKey(name: 'id', defaultValue: 0)
  final int id;

  @JsonKey(name: 'desc', defaultValue: '')
  final String desc;

  @JsonKey(name: 'expireTime', defaultValue: 0)
  final int expireTime;

  @JsonKey(name: 'ext', defaultValue: '')
  final String ext;

  @JsonKey(name: 'icon', defaultValue: '')
  final String icon;

  @JsonKey(name: 'img', defaultValue: '')
  final String img;

  @JsonKey(name: 'itemId', defaultValue: 0)
  final int itemId;

  // 1免费通话卡 2折扣券 3背包礼物
  @JsonKey(name: 'itemType', defaultValue: 0)
  final int itemType;

  @JsonKey(name: 'name', defaultValue: '')
  final String name;

  @JsonKey(name: 'num', defaultValue: 0)
  final int num;

  bool get isFreeCallCard => itemType == 1;
  bool get isDiscountCard => itemType == 2;
  bool get isFreeGift => itemType == 3;

  VochatCardItemModel(
    this.desc,
    this.expireTime,
    this.ext,
    this.icon,
    this.id,
    this.img,
    this.itemId,
    this.itemType,
    this.name,
    this.num,
  );

  factory VochatCardItemModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VochatCardItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VochatCardItemModelToJson(this);
}
