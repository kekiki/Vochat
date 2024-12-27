// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colive_turntable_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColiveTurntableModel _$ColiveTurntableModelFromJson(
        Map<String, dynamic> json) =>
    ColiveTurntableModel(
      (json['reward_list'] as List<dynamic>?)
              ?.map((e) => ColiveTurntableRewardModel.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      (json['turntable_num'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ColiveTurntableModelToJson(
        ColiveTurntableModel instance) =>
    <String, dynamic>{
      'reward_list': instance.rewardList,
      'turntable_num': instance.turntableNum,
    };

ColiveLuskyDrawModel _$ColiveLuskyDrawModelFromJson(
        Map<String, dynamic> json) =>
    ColiveLuskyDrawModel(
      (json['rewards'] as List<dynamic>?)
              ?.map((e) => ColiveTurntableRewardModel.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      (json['turntable_num'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ColiveLuskyDrawModelToJson(
        ColiveLuskyDrawModel instance) =>
    <String, dynamic>{
      'rewards': instance.rewards,
      'turntable_num': instance.turntableNum,
    };

ColiveTurntableRewardModel _$ColiveTurntableRewardModelFromJson(
        Map<String, dynamic> json) =>
    ColiveTurntableRewardModel(
      (json['id'] as num?)?.toInt() ?? 0,
      json['img'] as String? ?? '',
      (json['itemId'] as num?)?.toInt() ?? 0,
      (json['itemType'] as num?)?.toInt() ?? 0,
      json['name'] as String? ?? '',
      (json['num'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ColiveTurntableRewardModelToJson(
        ColiveTurntableRewardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'img': instance.img,
      'itemId': instance.itemId,
      'itemType': instance.itemType,
      'name': instance.name,
      'num': instance.num,
    };
