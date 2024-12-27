//
//  ColiveAreaModel.dart
//
//
//  Created by JSONConverter on 2024/10/12.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'colive_area_model.g.dart';

@JsonSerializable()
class ColiveAreaModel extends Object {
  @JsonKey(name: 'area', defaultValue: '')
  final String area;

  @JsonKey(name: 'status', defaultValue: 0)
  final int status;

  ColiveAreaModel(
    this.area,
    this.status,
  );

  factory ColiveAreaModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ColiveAreaModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColiveAreaModelToJson(this);
}
