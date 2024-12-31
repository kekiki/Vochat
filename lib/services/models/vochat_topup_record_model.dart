//
//  VochatTopupRecordModel.dart
//
//
//  Created by JSONConverter on 2024/11/14.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vochat_topup_record_model.g.dart';

@JsonSerializable()
class VochatTopupRecordModel extends Object {
  @JsonKey(name: 'create_time', defaultValue: 0)
  int createTime;

  @JsonKey(name: 'num', defaultValue: '')
  String num;

  @JsonKey(name: 'c_type', defaultValue: 0)
  int cType;

  @JsonKey(name: 'id', defaultValue: 0)
  int id;

  @JsonKey(name: 'status', defaultValue: 0)
  int status;

  @JsonKey(name: 'channel', defaultValue: '')
  String channel;

  @JsonKey(name: 'price', defaultValue: '')
  String price;

  @JsonKey(name: 'order_no', defaultValue: '')
  String orderNo;

  String get name {
    if (cType == 1) {
      return '${'vochat_diamond_recharge'.tr}: $num';
    }
    return '${'vochat_vip_recharge'.tr}: $num';
  }

  bool get isSuccess => status != 2;

  VochatTopupRecordModel(
    this.createTime,
    this.num,
    this.cType,
    this.id,
    this.status,
    this.channel,
    this.price,
    this.orderNo,
  );

  factory VochatTopupRecordModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VochatTopupRecordModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VochatTopupRecordModelToJson(this);
}
