//
//  ColiveCardRecordModel.dart
//
//
//  Created by JSONConverter on 2024/11/14.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'colive_call_record_model.g.dart';

@JsonSerializable()
class ColiveCallRecordModel extends Object {
  @JsonKey(name: 'anchor_id', defaultValue: 0)
  final int anchorId;

  @JsonKey(name: 'avatar', defaultValue: '')
  final String avatar;

  @JsonKey(name: 'c_type', defaultValue: 0)
  final int cType;

  @JsonKey(name: 'conversation_time', defaultValue: 0)
  final int conversationTime;

  @JsonKey(name: 'custom_id', defaultValue: 0)
  final int customId;

  @JsonKey(name: 'diamonds', defaultValue: 0)
  final int diamonds;

  @JsonKey(name: 'end_time', defaultValue: 0)
  final int endTime;

  @JsonKey(name: 'gold', defaultValue: 0)
  final int gold;

  @JsonKey(name: 'id', defaultValue: 0)
  final int id;

  @JsonKey(name: 'nickname', defaultValue: '')
  final String nickname;

  ColiveCallRecordModel(
    this.anchorId,
    this.avatar,
    this.cType,
    this.conversationTime,
    this.customId,
    this.diamonds,
    this.endTime,
    this.gold,
    this.id,
    this.nickname,
  );

  factory ColiveCallRecordModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ColiveCallRecordModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColiveCallRecordModelToJson(this);
}
