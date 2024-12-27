//
//  ColiveTurntableModel.dart
//
//
//  Created by JSONConverter on 2024/11/16.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'colive_turntable_model.g.dart';

@JsonSerializable()
class ColiveTurntableModel extends Object {
  @JsonKey(name: 'reward_list', defaultValue: [])
  List<ColiveTurntableRewardModel> rewardList;

  @JsonKey(name: 'turntable_num', defaultValue: 0)
  int turntableNum;

  ColiveTurntableModel(
    this.rewardList,
    this.turntableNum,
  );

  factory ColiveTurntableModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ColiveTurntableModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColiveTurntableModelToJson(this);
}

@JsonSerializable()
class ColiveLuskyDrawModel extends Object {
  @JsonKey(name: 'rewards', defaultValue: [])
  List<ColiveTurntableRewardModel> rewards;

  @JsonKey(name: 'turntable_num', defaultValue: 0)
  int turntableNum;

  ColiveLuskyDrawModel(
    this.rewards,
    this.turntableNum,
  );

  factory ColiveLuskyDrawModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ColiveLuskyDrawModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColiveLuskyDrawModelToJson(this);
}

@JsonSerializable()
class ColiveTurntableRewardModel extends Object {
  @JsonKey(name: 'id', defaultValue: 0)
  final int id;

  @JsonKey(name: 'img', defaultValue: '')
  final String img;

  @JsonKey(name: 'itemId', defaultValue: 0)
  final int itemId;

  @JsonKey(name: 'itemType', defaultValue: 0)
  final int itemType;

  @JsonKey(name: 'name', defaultValue: '')
  final String name;

  @JsonKey(name: 'num', defaultValue: 0)
  final int num;

  ColiveTurntableRewardModel(
    this.id,
    this.img,
    this.itemId,
    this.itemType,
    this.name,
    this.num,
  );

  factory ColiveTurntableRewardModel.empty() =>
      ColiveTurntableRewardModel.fromJson({});

  factory ColiveTurntableRewardModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ColiveTurntableRewardModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColiveTurntableRewardModelToJson(this);
}
