//
//  ColiveCallModel.dart
//
//
//  Created by JSONConverter on 2024/10/23.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'colive_call_model.g.dart';

@JsonSerializable()
class ColiveCallModel extends Object {
  @JsonKey(name: 'session_id', defaultValue: '')
  final String sessionId;

  @JsonKey(name: 'anchor_id', defaultValue: 0)
  final int anchorId;

  @JsonKey(name: 'anchor_avatar', defaultValue: '')
  final String anchorAvatar;

  @JsonKey(name: 'anchor_nickname', defaultValue: '')
  final String anchorNickname;

  @JsonKey(name: 'conversation_id', defaultValue: 0)
  final int conversationId;

  @JsonKey(name: 'conversation_price', defaultValue: '60')
  final String conversationPrice;

  @JsonKey(name: 'country_currency', defaultValue: '')
  final String countryCurrency;

  @JsonKey(name: 'country_icon', defaultValue: '')
  final String countryIcon;

  @JsonKey(name: 'country_name', defaultValue: '')
  final String countryName;

  @JsonKey(name: 'is_mute', defaultValue: 0)
  final int mute;

  @JsonKey(name: 'url', defaultValue: '')
  final String url;

  @JsonKey(name: 'item_num', defaultValue: '0')
  final String cardNum;

  @JsonKey(name: 'item_call_time', defaultValue: 0)
  final int cardCallTime;

  @JsonKey(name: 'status', defaultValue: 0)
  final int status;

  bool get isVideoMute => mute == 1;
  bool get isAnchorBusy => status == 2;
  bool get isAnchorOffline => status == 3;
  bool get isNotEnoughDiamonds => status == 4;

  ColiveCallModel(
    this.sessionId,
    this.anchorId,
    this.anchorAvatar,
    this.anchorNickname,
    this.conversationId,
    this.conversationPrice,
    this.countryCurrency,
    this.countryIcon,
    this.countryName,
    this.mute,
    this.url,
    this.cardNum,
    this.cardCallTime,
    this.status,
  );

  ColiveCallModel copyWith({
    String? sessionId,
    int? anchorId,
    String? anchorAvatar,
    String? anchorNickname,
    int? conversationId,
    String? conversationPrice,
    String? countryCurrency,
    String? countryIcon,
    String? countryName,
    int? mute,
    String? url,
    String? cardNum,
    int? cardCallTime,
    int? status,
  }) =>
      ColiveCallModel(
        sessionId ?? this.sessionId,
        anchorId ?? this.anchorId,
        anchorAvatar ?? this.anchorAvatar,
        anchorNickname ?? this.anchorNickname,
        conversationId ?? this.conversationId,
        conversationPrice ?? this.conversationPrice,
        countryCurrency ?? this.countryCurrency,
        countryIcon ?? this.countryIcon,
        countryName ?? this.countryName,
        mute ?? this.mute,
        url ?? this.url,
        cardNum ?? this.cardNum,
        cardCallTime ?? this.cardCallTime,
        status ?? this.status,
      );

  factory ColiveCallModel.fromJson(Map<String, dynamic> json) =>
      // _$ColiveCallModelFromJson(srcJson);
      ColiveCallModel(
        json['session_id'] as String? ?? '',
        int.tryParse(json['anchor_id'].toString()) ?? 0,
        json['anchor_avatar'] as String? ?? '',
        json['anchor_nickname'] as String? ?? '',
        (json['conversation_id'] as num?)?.toInt() ?? 0,
        json['conversation_price']?.toString() ?? '60',
        json['country_currency'] as String? ?? '',
        json['country_icon'] as String? ?? '',
        json['country_name'] as String? ?? '',
        (json['is_mute'] as num?)?.toInt() ?? 0,
        json['url'] as String? ?? '',
        json['item_num'] as String? ?? '0',
        (json['item_call_time'] as num?)?.toInt() ?? 0,
        (json['status'] as num?)?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson() => _$ColiveCallModelToJson(this);
}
