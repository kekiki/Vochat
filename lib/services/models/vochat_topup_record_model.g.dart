// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vochat_topup_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VochatTopupRecordModel _$VochatTopupRecordModelFromJson(
        Map<String, dynamic> json) =>
    VochatTopupRecordModel(
      (json['create_time'] as num?)?.toInt() ?? 0,
      json['num'] as String? ?? '',
      (json['c_type'] as num?)?.toInt() ?? 0,
      (json['id'] as num?)?.toInt() ?? 0,
      (json['status'] as num?)?.toInt() ?? 0,
      json['channel'] as String? ?? '',
      json['price'] as String? ?? '',
      json['order_no'] as String? ?? '',
    );

Map<String, dynamic> _$VochatTopupRecordModelToJson(
        VochatTopupRecordModel instance) =>
    <String, dynamic>{
      'create_time': instance.createTime,
      'num': instance.num,
      'c_type': instance.cType,
      'id': instance.id,
      'status': instance.status,
      'channel': instance.channel,
      'price': instance.price,
      'order_no': instance.orderNo,
    };
