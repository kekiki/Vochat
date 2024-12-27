//
//  ColiveFollowModel.dart
//
//
//  Created by JSONConverter on 2024/10/30.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

import 'colive_anchor_model.dart';

part 'colive_follower_model.g.dart';

@JsonSerializable()
class ColiveFollowerModel extends Object {
  @JsonKey(name: 'area')
  String? area;

  @JsonKey(name: 'avatar')
  String? avatar;

  @JsonKey(name: 'birthday')
  num? birthday;

  @JsonKey(name: 'conversation_price')
  num? conversationPrice;

  @JsonKey(name: 'country')
  String? country;

  @JsonKey(name: 'country_currency')
  String? countryCurrency;

  @JsonKey(name: 'country_icon')
  String? countryIcon;

  @JsonKey(name: 'create_time')
  num? createTime;

  @JsonKey(name: 'uid', defaultValue: 0)
  int uid;

  @JsonKey(name: 'gold')
  num? gold;

  @JsonKey(name: 'id')
  num? id;

  @JsonKey(name: 'nickname')
  String? nickname;

  @JsonKey(name: 'online')
  num? online;

  ColiveFollowerModel(
    this.area,
    this.avatar,
    this.birthday,
    this.conversationPrice,
    this.country,
    this.countryCurrency,
    this.countryIcon,
    this.createTime,
    this.uid,
    this.gold,
    this.id,
    this.nickname,
    this.online,
  );

  ColiveAnchorModel get toAnchorModel =>
      ColiveAnchorModel.fromJson({}).copyWith(
        id: uid,
        area: area,
        nickname: nickname,
        avatar: avatar,
        country: country,
        birthday: birthday?.toInt(),
        online: online?.toInt(),
        countryIcon: countryIcon,
        countryCurrency: countryCurrency,
        conversationPrice: conversationPrice.toString(),
      );

  factory ColiveFollowerModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ColiveFollowerModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColiveFollowerModelToJson(this);
}
