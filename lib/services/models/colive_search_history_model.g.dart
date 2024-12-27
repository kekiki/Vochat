// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colive_search_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColiveSearchHistoryModel _$ColiveSearchHistoryModelFromJson(
        Map<String, dynamic> json) =>
    ColiveSearchHistoryModel(
      json['history'] as String? ?? '',
      (json['time'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ColiveSearchHistoryModelToJson(
        ColiveSearchHistoryModel instance) =>
    <String, dynamic>{
      'history': instance.history,
      'time': instance.time,
    };
