//
//  ColiveCardRecordModel.dart
//
//
//  Created by JSONConverter on 2024/11/14.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'colive_gift_record_model.g.dart';

@JsonSerializable()
class ColiveGiftRecordModel extends Object {
  @JsonKey(name: 'anchor_id', defaultValue: 0)
  final int anchorId;

  @JsonKey(name: 'avatar', defaultValue: '')
  final String avatar;

  @JsonKey(name: 'create_time', defaultValue: 0)
  final int createTime;

  @JsonKey(name: 'custom_id', defaultValue: 0)
  final int customId;

  @JsonKey(name: 'diamonds', defaultValue: 0)
  final int diamonds;

  @JsonKey(name: 'gift_id', defaultValue: 0)
  final int giftId;

  @JsonKey(name: 'gift_name', defaultValue: '')
  final String giftName;

  @JsonKey(name: 'gold', defaultValue: 0)
  final int gold;

  @JsonKey(name: 'id', defaultValue: 0)
  final int id;

  @JsonKey(name: 'nickname', defaultValue: '')
  final String nickname;

  @JsonKey(name: 'num', defaultValue: 0)
  final int num;

  ColiveGiftRecordModel(
    this.anchorId,
    this.avatar,
    this.createTime,
    this.customId,
    this.diamonds,
    this.giftId,
    this.giftName,
    this.gold,
    this.id,
    this.nickname,
    this.num,
  );

  factory ColiveGiftRecordModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ColiveGiftRecordModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColiveGiftRecordModelToJson(this);
}
