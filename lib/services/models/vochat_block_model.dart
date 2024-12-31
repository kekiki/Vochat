//
//  VochatBlockModel.dart
//
//
//  Created by JSONConverter on 2024/10/30.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

import 'vochat_anchor_model.dart';

part 'vochat_block_model.g.dart';

@JsonSerializable()
class VochatBlockModel extends Object {
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

  @JsonKey(name: 'block_id', defaultValue: 0)
  int blockId;

  @JsonKey(name: 'gold')
  num? gold;

  @JsonKey(name: 'id')
  num? id;

  @JsonKey(name: 'isRobot', defaultValue: 0)
  int robot;

  @JsonKey(name: 'nickname')
  String? nickname;

  @JsonKey(name: 'online')
  num? online;

  @JsonKey(name: 'robotArea')
  String? robotArea;

  @JsonKey(name: 'robotAvatar')
  String? robotAvatar;

  @JsonKey(name: 'robotBirthday')
  num? robotBirthday;

  @JsonKey(name: 'robotCountry')
  String? robotCountry;

  @JsonKey(name: 'robotNickname')
  String? robotNickname;

  @JsonKey(name: 'userArea')
  String? userArea;

  @JsonKey(name: 'userNickname')
  String? userNickname;

  VochatBlockModel(
    this.area,
    this.avatar,
    this.birthday,
    this.conversationPrice,
    this.country,
    this.countryCurrency,
    this.countryIcon,
    this.createTime,
    this.blockId,
    this.gold,
    this.id,
    this.robot,
    this.nickname,
    this.online,
    this.robotArea,
    this.robotAvatar,
    this.robotBirthday,
    this.robotCountry,
    this.robotNickname,
    this.userArea,
    this.userNickname,
  );

  bool get isRobot => robot == 1;

  VochatAnchorModel get toAnchorModel =>
      VochatAnchorModel.fromJson({}).copyWith(
        id: blockId,
        robot: robot,
        // area: isRobot ? robotArea : area,
        area: area,
        // nickname: isRobot ? robotNickname : nickname,
        nickname: nickname,
        // avatar: isRobot ? robotAvatar : avatar,
        avatar: avatar,
        // country: isRobot ? robotCountry : country,
        country: country,
        birthday: birthday?.toInt(),
        online: online?.toInt(),
        countryIcon: countryIcon,
        countryCurrency: countryCurrency,
        conversationPrice: conversationPrice.toString(),
      );

  factory VochatBlockModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VochatBlockModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VochatBlockModelToJson(this);
}
