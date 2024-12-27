//
//  ColiveTopupRecordModel.dart
//
//
//  Created by JSONConverter on 2024/11/14.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'colive_topup_record_model.g.dart';

@JsonSerializable()
class ColiveTopupRecordModel extends Object {
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
      return '${'colive_diamond_recharge'.tr}: $num';
    }
    return '${'colive_vip_recharge'.tr}: $num';
  }

  bool get isSuccess => status != 2;

  ColiveTopupRecordModel(
    this.createTime,
    this.num,
    this.cType,
    this.id,
    this.status,
    this.channel,
    this.price,
    this.orderNo,
  );

  factory ColiveTopupRecordModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ColiveTopupRecordModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColiveTopupRecordModelToJson(this);
}
