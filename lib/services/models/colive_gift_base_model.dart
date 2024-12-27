//
//  ColiveGiftBaseModel.dart
//
//
//  Created by JSONConverter on 2024/11/02.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'colive_gift_base_model.g.dart';

@JsonSerializable()
class ColiveGiftBaseModel extends Object {
  @JsonKey(name: 'backpack_gift_list', defaultValue: [])
  final List<ColiveGiftItemModel> backpackGiftList;

  @JsonKey(name: 'gift_list', defaultValue: [])
  final List<ColiveGiftItemModel> giftList;

  @JsonKey(name: 'vip_gift_list', defaultValue: [])
  final List<ColiveGiftItemModel> vipGiftList;

  ColiveGiftBaseModel(
    this.backpackGiftList,
    this.giftList,
    this.vipGiftList,
  );

  ColiveGiftBaseModel copyWith({
    List<ColiveGiftItemModel>? backpackGiftList,
    List<ColiveGiftItemModel>? giftList,
    List<ColiveGiftItemModel>? vipGiftList,
  }) =>
      ColiveGiftBaseModel(
        backpackGiftList ?? this.backpackGiftList,
        giftList ?? this.giftList,
        vipGiftList ?? this.vipGiftList,
      );

  factory ColiveGiftBaseModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ColiveGiftBaseModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColiveGiftBaseModelToJson(this);
}

@JsonSerializable()
class ColiveGiftItemModel extends Object {
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

  ColiveGiftItemModel(
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

  factory ColiveGiftItemModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ColiveGiftItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColiveGiftItemModelToJson(this);
}
