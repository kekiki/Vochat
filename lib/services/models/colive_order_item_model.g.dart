// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colive_order_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColiveOrderItemModel _$ColiveOrderItemModelFromJson(
        Map<String, dynamic> json) =>
    ColiveOrderItemModel(
      json['app'] as String? ?? '',
      json['area'] as String? ?? '',
      (json['c_type'] as num?)?.toInt() ?? 0,
      json['channel'] as String? ?? '',
      (json['channel_id'] as num?)?.toInt() ?? 0,
      (json['create_time'] as num?)?.toInt() ?? 0,
      json['currency'] as String? ?? '',
      (json['extra_num'] as num?)?.toInt() ?? 0,
      (json['extra_time'] as num?)?.toInt() ?? 0,
      (json['goods_id'] as num?)?.toInt() ?? 0,
      json['google_id'] as String? ?? '',
      (json['id'] as num?)?.toInt() ?? 0,
      json['local_price'] as String? ?? '',
      (json['num'] as num?)?.toInt() ?? 0,
      json['order_no'] as String? ?? '',
      (json['p_type'] as num?)?.toInt() ?? 0,
      json['pay_country'] as String? ?? '',
      json['price'] as String? ?? '',
      (json['status'] as num?)?.toInt() ?? 0,
      (json['type'] as num?)?.toInt() ?? 0,
      (json['uid'] as num?)?.toInt() ?? 0,
      json['version'] as String? ?? '',
      json['url'] as String? ?? '',
    );

Map<String, dynamic> _$ColiveOrderItemModelToJson(
        ColiveOrderItemModel instance) =>
    <String, dynamic>{
      'app': instance.app,
      'area': instance.area,
      'c_type': instance.cType,
      'channel': instance.channel,
      'channel_id': instance.channelId,
      'create_time': instance.createTime,
      'currency': instance.currency,
      'extra_num': instance.extraNum,
      'extra_time': instance.extraTime,
      'goods_id': instance.goodsId,
      'google_id': instance.productId,
      'id': instance.id,
      'local_price': instance.localPrice,
      'num': instance.num,
      'order_no': instance.orderNo,
      'p_type': instance.pType,
      'pay_country': instance.payCountry,
      'price': instance.price,
      'status': instance.status,
      'type': instance.type,
      'uid': instance.uid,
      'version': instance.version,
      'url': instance.url,
    };
