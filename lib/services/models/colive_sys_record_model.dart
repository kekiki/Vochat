//
//  ColiveSysRecordModel.dart
//
//
//  Created by JSONConverter on 2024/11/14.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'colive_sys_record_model.g.dart';

@JsonSerializable()
class ColiveSysRecordModel extends Object {
  @JsonKey(name: 'create_time', defaultValue: 0)
  int createTime;

  @JsonKey(name: 'diamonds', defaultValue: 0)
  int diamonds;

  @JsonKey(name: 'e_type', defaultValue: '')
  String eType;

  @JsonKey(name: 'id', defaultValue: 0)
  int id;

  @JsonKey(name: 'remarks', defaultValue: '')
  String remarks;

  @JsonKey(name: 'sum', defaultValue: '')
  String sum;

  String get name {
    if (eType == '6') {
      return 'colive_vip_recharge'.tr;
    } else if (eType == '7') {
      return 'colive_diamond_recharge'.tr;
    } else if (eType == '8') {
      return 'colive_vip_recharge_rewards'.tr;
    } else if (eType == '9') {
      return 'colive_diamond_recharge_rewards'.tr;
    }
    return 'colive_system'.tr;
  }

  ColiveSysRecordModel(
    this.createTime,
    this.diamonds,
    this.eType,
    this.id,
    this.remarks,
    this.sum,
  );

  factory ColiveSysRecordModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ColiveSysRecordModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColiveSysRecordModelToJson(this);
}
