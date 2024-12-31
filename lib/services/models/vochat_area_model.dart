//
//  VochatAreaModel.dart
//
//
//  Created by JSONConverter on 2024/10/12.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'vochat_area_model.g.dart';

@JsonSerializable()
class VochatAreaModel extends Object {
  @JsonKey(name: 'area', defaultValue: '')
  final String area;

  @JsonKey(name: 'status', defaultValue: 0)
  final int status;

  VochatAreaModel(
    this.area,
    this.status,
  );

  factory VochatAreaModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VochatAreaModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VochatAreaModelToJson(this);
}
