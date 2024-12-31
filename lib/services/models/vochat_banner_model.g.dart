// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vochat_banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VochatBannerModel _$VochatBannerModelFromJson(Map<String, dynamic> json) =>
    VochatBannerModel(
      json['images'] as String? ?? '',
      (json['is_ling'] as num?)?.toInt() ?? 0,
      (json['is_link'] as num?)?.toInt() ?? 0,
      (json['is_pay'] as num?)?.toInt() ?? 0,
      json['link'] as String? ?? '',
    );

Map<String, dynamic> _$VochatBannerModelToJson(VochatBannerModel instance) =>
    <String, dynamic>{
      'images': instance.images,
      'is_ling': instance.lingValue,
      'is_link': instance.linkValue,
      'is_pay': instance.payValue,
      'link': instance.link,
    };
