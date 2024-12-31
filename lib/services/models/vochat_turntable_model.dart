//
//  VochatTurntableModel.dart
//
//
//  Created by JSONConverter on 2024/11/16.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'vochat_turntable_model.g.dart';

@JsonSerializable()
class VochatTurntableModel extends Object {
  @JsonKey(name: 'reward_list', defaultValue: [])
  List<VochatTurntableRewardModel> rewardList;

  @JsonKey(name: 'turntable_num', defaultValue: 0)
  int turntableNum;

  VochatTurntableModel(
    this.rewardList,
    this.turntableNum,
  );

  factory VochatTurntableModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VochatTurntableModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VochatTurntableModelToJson(this);
}

@JsonSerializable()
class VochatLuskyDrawModel extends Object {
  @JsonKey(name: 'rewards', defaultValue: [])
  List<VochatTurntableRewardModel> rewards;

  @JsonKey(name: 'turntable_num', defaultValue: 0)
  int turntableNum;

  VochatLuskyDrawModel(
    this.rewards,
    this.turntableNum,
  );

  factory VochatLuskyDrawModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VochatLuskyDrawModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VochatLuskyDrawModelToJson(this);
}

@JsonSerializable()
class VochatTurntableRewardModel extends Object {
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

  VochatTurntableRewardModel(
    this.id,
    this.img,
    this.itemId,
    this.itemType,
    this.name,
    this.num,
  );

  factory VochatTurntableRewardModel.empty() =>
      VochatTurntableRewardModel.fromJson({});

  factory VochatTurntableRewardModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VochatTurntableRewardModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VochatTurntableRewardModelToJson(this);
}
