//
//  ColiveOrderItemModel.dart
//
//
//  Created by JSONConverter on 2024/11/05.
//  Copyright © 2024年 JSONConverter. All rights reserved.
//

import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'colive_order_item_model.g.dart';

@JsonSerializable()
@Entity(tableName: 'database_table_order_info')
class ColiveOrderItemModel extends Object {
  @JsonKey(name: 'app', defaultValue: '')
  final String app;

  @JsonKey(name: 'area', defaultValue: '')
  final String area;

  @JsonKey(name: 'c_type', defaultValue: 0)
  final int cType;

  @JsonKey(name: 'channel', defaultValue: '')
  final String channel;

  @JsonKey(name: 'channel_id', defaultValue: 0)
  final int channelId;

  @JsonKey(name: 'create_time', defaultValue: 0)
  final int createTime;

  @JsonKey(name: 'currency', defaultValue: '')
  final String currency;

  @JsonKey(name: 'extra_num', defaultValue: 0)
  final int extraNum;

  @JsonKey(name: 'extra_time', defaultValue: 0)
  final int extraTime;

  @JsonKey(name: 'goods_id', defaultValue: 0)
  final int goodsId;

  @primaryKey
  @JsonKey(name: 'google_id', defaultValue: '')
  final String productId;

  @JsonKey(name: 'id', defaultValue: 0)
  final int id;

  @JsonKey(name: 'local_price', defaultValue: '')
  final String localPrice;

  @JsonKey(name: 'num', defaultValue: 0)
  final int num;

  @JsonKey(name: 'order_no', defaultValue: '')
  final String orderNo;

  @JsonKey(name: 'p_type', defaultValue: 0)
  final int pType;

  @JsonKey(name: 'pay_country', defaultValue: '')
  final String payCountry;

  @JsonKey(name: 'price', defaultValue: '')
  final String price;

  @JsonKey(name: 'status', defaultValue: 0)
  final int status;

  @JsonKey(name: 'type', defaultValue: 0)
  final int type;

  @JsonKey(name: 'uid', defaultValue: 0)
  final int uid;

  @JsonKey(name: 'version', defaultValue: '')
  final String version;

  @JsonKey(name: 'url', defaultValue: '')
  final String url;

  bool get isNative => type == 1 || type == 3;

  ColiveOrderItemModel(
    this.app,
    this.area,
    this.cType,
    this.channel,
    this.channelId,
    this.createTime,
    this.currency,
    this.extraNum,
    this.extraTime,
    this.goodsId,
    this.productId,
    this.id,
    this.localPrice,
    this.num,
    this.orderNo,
    this.pType,
    this.payCountry,
    this.price,
    this.status,
    this.type,
    this.uid,
    this.version,
    this.url,
  );

  factory ColiveOrderItemModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ColiveOrderItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColiveOrderItemModelToJson(this);
}
