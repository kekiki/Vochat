// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vochat_country_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VochatCountryItemModel _$VochatCountryItemModelFromJson(
        Map<String, dynamic> json) =>
    VochatCountryItemModel(
      json['code'] as String? ?? '',
      json['currency'] as String? ?? '',
      (json['currency_decimal_support'] as num?)?.toInt() ?? 0,
      json['logo'] as String? ?? '',
      json['rate'] as String? ?? '',
      json['show_name'] as String? ?? '',
      (json['status'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$VochatCountryItemModelToJson(
        VochatCountryItemModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'currency': instance.currency,
      'currency_decimal_support': instance.currencyDecimalSupport,
      'logo': instance.logo,
      'rate': instance.rate,
      'show_name': instance.showName,
      'status': instance.status,
    };
