//
//  ColiveChannelItemModel.dart
//
//
//  Created by JSONConverter on 2024/11/05.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'colive_channel_item_model.g.dart';

@JsonSerializable()
class ColiveChannelItemModel extends Object {
  @JsonKey(name: 'channel_id', defaultValue: 0)
  final int channelId;

  @JsonKey(name: 'channel_name', defaultValue: '')
  final String channelName;

  @JsonKey(name: 'currency', defaultValue: '')
  final String currency;

  @JsonKey(name: 'discount_coupon_num', defaultValue: 0)
  final int discountCouponNum;

  @JsonKey(name: 'logo', defaultValue: '')
  final String logo;

  @JsonKey(name: 'price', defaultValue: 0)
  final double price;

  ColiveChannelItemModel(
    this.channelId,
    this.channelName,
    this.currency,
    this.discountCouponNum,
    this.logo,
    this.price,
  );

  factory ColiveChannelItemModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ColiveChannelItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColiveChannelItemModelToJson(this);
}
