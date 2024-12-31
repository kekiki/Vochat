// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vochat_search_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VochatSearchHistoryModel _$VochatSearchHistoryModelFromJson(
        Map<String, dynamic> json) =>
    VochatSearchHistoryModel(
      json['history'] as String? ?? '',
      (json['time'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$VochatSearchHistoryModelToJson(
        VochatSearchHistoryModel instance) =>
    <String, dynamic>{
      'history': instance.history,
      'time': instance.time,
    };
