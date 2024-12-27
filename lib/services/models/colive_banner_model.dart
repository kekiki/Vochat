//
//  ColiveBannerModel.dart
//
//
//  Created by JSONConverter on 2024/10/28.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'colive_banner_model.g.dart';

@JsonSerializable()
class ColiveBannerModel extends Object {
  @JsonKey(name: 'images', defaultValue: '')
  final String images;

  @JsonKey(name: 'is_ling', defaultValue: 0)
  final int lingValue;

  @JsonKey(name: 'is_link', defaultValue: 0)
  final int linkValue;

  @JsonKey(name: 'is_pay', defaultValue: 0)
  final int payValue;

  @JsonKey(name: 'link', defaultValue: '')
  final String link;

  bool get isLink => linkValue == 1;
  bool get isPay => payValue == 1;

  ColiveBannerModel(
    this.images,
    this.lingValue,
    this.linkValue,
    this.payValue,
    this.link,
  );

  factory ColiveBannerModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ColiveBannerModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColiveBannerModelToJson(this);
}
