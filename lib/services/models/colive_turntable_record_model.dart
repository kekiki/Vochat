//
//  ColiveTurntableRecordModel.dart
//
//
//  Created by JSONConverter on 2024/11/16.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'colive_turntable_record_model.g.dart';

@JsonSerializable()
class ColiveTurntableRecordModel extends Object {
  @JsonKey(name: 'img', defaultValue: '')
  final String img;

  @JsonKey(name: 'name', defaultValue: '')
  final String name;

  @JsonKey(name: 'num', defaultValue: 0)
  final int num;

  @JsonKey(name: 'time', defaultValue: '')
  final String time;

  ColiveTurntableRecordModel(
    this.img,
    this.name,
    this.num,
    this.time,
  );

  factory ColiveTurntableRecordModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ColiveTurntableRecordModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColiveTurntableRecordModelToJson(this);
}
