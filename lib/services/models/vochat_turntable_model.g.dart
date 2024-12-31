// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vochat_turntable_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VochatTurntableModel _$VochatTurntableModelFromJson(
        Map<String, dynamic> json) =>
    VochatTurntableModel(
      (json['reward_list'] as List<dynamic>?)
              ?.map((e) => VochatTurntableRewardModel.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      (json['turntable_num'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$VochatTurntableModelToJson(
        VochatTurntableModel instance) =>
    <String, dynamic>{
      'reward_list': instance.rewardList,
      'turntable_num': instance.turntableNum,
    };

VochatLuskyDrawModel _$VochatLuskyDrawModelFromJson(
        Map<String, dynamic> json) =>
    VochatLuskyDrawModel(
      (json['rewards'] as List<dynamic>?)
              ?.map((e) => VochatTurntableRewardModel.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      (json['turntable_num'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$VochatLuskyDrawModelToJson(
        VochatLuskyDrawModel instance) =>
    <String, dynamic>{
      'rewards': instance.rewards,
      'turntable_num': instance.turntableNum,
    };

VochatTurntableRewardModel _$VochatTurntableRewardModelFromJson(
        Map<String, dynamic> json) =>
    VochatTurntableRewardModel(
      (json['id'] as num?)?.toInt() ?? 0,
      json['img'] as String? ?? '',
      (json['itemId'] as num?)?.toInt() ?? 0,
      (json['itemType'] as num?)?.toInt() ?? 0,
      json['name'] as String? ?? '',
      (json['num'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$VochatTurntableRewardModelToJson(
        VochatTurntableRewardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'img': instance.img,
      'itemId': instance.itemId,
      'itemType': instance.itemType,
      'name': instance.name,
      'num': instance.num,
    };
