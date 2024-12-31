//
//  VochatCustomCodeModel.dart
//
//
//  Created by JSONConverter on 2024/10/12.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'vochat_custom_code_model.g.dart';

@JsonSerializable()
class VochatCustomCodeModel extends Object {
  @JsonKey(name: 'custom_code', defaultValue: '')
  final String customCode;

  @JsonKey(name: 'password', defaultValue: '')
  final String password;

  @JsonKey(name: 'type', defaultValue: 0)
  final int type;

  VochatCustomCodeModel(
    this.customCode,
    this.password,
    this.type,
  );

  factory VochatCustomCodeModel.fromJson(Map<String, dynamic> json) =>
      // _$VochatCustomCodeModelFromJson(srcJson);
      VochatCustomCodeModel(
        (json['custom_code'])?.toString() ?? '',
        json['password'] as String? ?? '',
        (json['type'] as num?)?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson() => _$VochatCustomCodeModelToJson(this);
}
