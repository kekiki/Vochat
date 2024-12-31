//
//  VochatCallSettlementModel.dart
//
//
//  Created by JSONConverter on 2024/10/31.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'vochat_call_settlement_model.g.dart';

@JsonSerializable()
class VochatCallSettlementModel extends Object {
  @JsonKey(name: 'anchor_id', defaultValue: 0)
  final int anchorId;

  @JsonKey(name: 'avatar', defaultValue: '')
  final String avatar;

  @JsonKey(name: 'cardNum', defaultValue: 0)
  final int cardNum;

  @JsonKey(name: 'conversation_time', defaultValue: 0)
  final int conversationTime;

  @JsonKey(name: 'country_currency', defaultValue: '')
  final String countryCurrency;

  @JsonKey(name: 'diamonds', defaultValue: '')
  final String diamonds;

  @JsonKey(name: 'end_time', defaultValue: 0)
  final int endTime;

  @JsonKey(name: 'gift', defaultValue: '')
  final String gift;

  @JsonKey(name: 'nickname', defaultValue: '')
  final String nickname;

  @JsonKey(name: 'start_time', defaultValue: 0)
  final int startTime;

  @JsonKey(name: 'total', defaultValue: 0)
  final int total;

  VochatCallSettlementModel(
    this.anchorId,
    this.avatar,
    this.cardNum,
    this.conversationTime,
    this.countryCurrency,
    this.diamonds,
    this.endTime,
    this.gift,
    this.nickname,
    this.startTime,
    this.total,
  );

  factory VochatCallSettlementModel.fromJson(Map<String, dynamic> json) =>
      // _$VochatCallSettlementModelFromJson(srcJson);
      VochatCallSettlementModel(
        (json['anchor_id'] as num?)?.toInt() ?? 0,
        json['avatar'] as String? ?? '',
        (json['cardNum'] as num?)?.toInt() ?? 0,
        (json['conversation_time'] as num?)?.toInt() ?? 0,
        json['country_currency'] as String? ?? '',
        json['diamonds']?.toString() ?? '',
        (json['end_time'] as num?)?.toInt() ?? 0,
        json['gift'] as String? ?? '',
        json['nickname'] as String? ?? '',
        (json['start_time'] as num?)?.toInt() ?? 0,
        (json['total'] as num?)?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson() => _$VochatCallSettlementModelToJson(this);
}
