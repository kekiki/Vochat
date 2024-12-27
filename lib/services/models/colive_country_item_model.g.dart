// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colive_country_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColiveCountryItemModel _$ColiveCountryItemModelFromJson(
        Map<String, dynamic> json) =>
    ColiveCountryItemModel(
      json['code'] as String? ?? '',
      json['currency'] as String? ?? '',
      (json['currency_decimal_support'] as num?)?.toInt() ?? 0,
      json['logo'] as String? ?? '',
      json['rate'] as String? ?? '',
      json['show_name'] as String? ?? '',
      (json['status'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ColiveCountryItemModelToJson(
        ColiveCountryItemModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'currency': instance.currency,
      'currency_decimal_support': instance.currencyDecimalSupport,
      'logo': instance.logo,
      'rate': instance.rate,
      'show_name': instance.showName,
      'status': instance.status,
    };
