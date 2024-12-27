// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colive_chat_block_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColiveChatBlockModel _$ColiveChatBlockModelFromJson(
        Map<String, dynamic> json) =>
    ColiveChatBlockModel(
      json['area'] as String? ?? '',
      (json['chat_num'] as num?)?.toInt() ?? 0,
      json['is_block'] as bool? ?? false,
      json['is_toblock'] as bool? ?? false,
    );

Map<String, dynamic> _$ColiveChatBlockModelToJson(
        ColiveChatBlockModel instance) =>
    <String, dynamic>{
      'area': instance.area,
      'chat_num': instance.chatNum,
      'is_block': instance.isBeBlock,
      'is_toblock': instance.isToBlock,
    };
