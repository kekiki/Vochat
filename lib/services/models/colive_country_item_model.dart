//
//  ColiveCountryItemModel.dart
//
//
//  Created by JSONConverter on 2024/11/20.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'colive_country_item_model.g.dart';

@JsonSerializable()
class ColiveCountryItemModel extends Object {
  @JsonKey(name: 'code', defaultValue: '')
  final String code;

  @JsonKey(name: 'currency', defaultValue: '')
  final String currency;

  @JsonKey(name: 'currency_decimal_support', defaultValue: 0)
  final int currencyDecimalSupport;

  @JsonKey(name: 'logo', defaultValue: '')
  final String logo;

  @JsonKey(name: 'rate', defaultValue: '')
  final String rate;

  @JsonKey(name: 'show_name', defaultValue: '')
  final String showName;

  @JsonKey(name: 'status', defaultValue: 0)
  final int status;

  ColiveCountryItemModel(
    this.code,
    this.currency,
    this.currencyDecimalSupport,
    this.logo,
    this.rate,
    this.showName,
    this.status,
  );

  factory ColiveCountryItemModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ColiveCountryItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColiveCountryItemModelToJson(this);
}