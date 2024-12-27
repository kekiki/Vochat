// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colive_banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColiveBannerModel _$ColiveBannerModelFromJson(Map<String, dynamic> json) =>
    ColiveBannerModel(
      json['images'] as String? ?? '',
      (json['is_ling'] as num?)?.toInt() ?? 0,
      (json['is_link'] as num?)?.toInt() ?? 0,
      (json['is_pay'] as num?)?.toInt() ?? 0,
      json['link'] as String? ?? '',
    );

Map<String, dynamic> _$ColiveBannerModelToJson(ColiveBannerModel instance) =>
    <String, dynamic>{
      'images': instance.images,
      'is_ling': instance.lingValue,
      'is_link': instance.linkValue,
      'is_pay': instance.payValue,
      'link': instance.link,
    };
