//
//  VochatGiftBaseModel.dart
//
//
//  Created by JSONConverter on 2024/11/02.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'vochat_gift_base_model.g.dart';

@JsonSerializable()
class VochatGiftBaseModel extends Object {
  @JsonKey(name: 'backpack_gift_list', defaultValue: [])
  final List<VochatGiftItemModel> backpackGiftList;

  @JsonKey(name: 'gift_list', defaultValue: [])
  final List<VochatGiftItemModel> giftList;

  @JsonKey(name: 'vip_gift_list', defaultValue: [])
  final List<VochatGiftItemModel> vipGiftList;

  VochatGiftBaseModel(
    this.backpackGiftList,
    this.giftList,
    this.vipGiftList,
  );

  VochatGiftBaseModel copyWith({
    List<VochatGiftItemModel>? backpackGiftList,
    List<VochatGiftItemModel>? giftList,
    List<VochatGiftItemModel>? vipGiftList,
  }) =>
      VochatGiftBaseModel(
        backpackGiftList ?? this.backpackGiftList,
        giftList ?? this.giftList,
        vipGiftList ?? this.vipGiftList,
      );

  factory VochatGiftBaseModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VochatGiftBaseModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VochatGiftBaseModelToJson(this);
}

@JsonSerializable()
class VochatGiftItemModel extends Object {
  @JsonKey(name: 'area', defaultValue: '')
  final String area;

  @JsonKey(name: 'back_name', defaultValue: '')
  final String backName;

  @JsonKey(name: 'cartoon_name', defaultValue: '')
  final String cartoonName;

  @JsonKey(name: 'cartoon_url', defaultValue: '')
  final String cartoonUrl;

  @JsonKey(name: 'id', defaultValue: 0)
  final int id;

  @JsonKey(name: 'logo', defaultValue: '')
  final String logo;

  @JsonKey(name: 'name', defaultValue: '')
  final String name;

  @JsonKey(name: 'price', defaultValue: 0)
  final int price;

  @JsonKey(name: 'sku', defaultValue: '')
  final String sku;

  @JsonKey(name: 'sort', defaultValue: 0)
  final int sort;

  @JsonKey(name: 'status', defaultValue: '')
  final String status;

  VochatGiftItemModel(
    this.area,
    this.backName,
    this.cartoonName,
    this.cartoonUrl,
    this.id,
    this.logo,
    this.name,
    this.price,
    this.sku,
    this.sort,
    this.status,
  );

  factory VochatGiftItemModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VochatGiftItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VochatGiftItemModelToJson(this);
}
