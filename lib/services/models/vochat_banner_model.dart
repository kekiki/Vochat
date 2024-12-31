//
//  VochatBannerModel.dart
//
//
//  Created by JSONConverter on 2024/10/28.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'vochat_banner_model.g.dart';

@JsonSerializable()
class VochatBannerModel extends Object {
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

  VochatBannerModel(
    this.images,
    this.lingValue,
    this.linkValue,
    this.payValue,
    this.link,
  );

  factory VochatBannerModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VochatBannerModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VochatBannerModelToJson(this);
}
