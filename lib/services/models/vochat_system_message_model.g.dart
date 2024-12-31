// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vochat_system_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VochatSystemMessageModel _$VochatSystemMessageModelFromJson(
        Map<String, dynamic> json) =>
    VochatSystemMessageModel(
      json['content'] as String? ?? '',
      (json['create_time'] as num?)?.toInt() ?? 0,
      (json['id'] as num?)?.toInt() ?? 0,
      json['images'] as String? ?? '',
      json['link'] as String? ?? '',
      json['title'] as String? ?? '',
      (json['update_time'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$VochatSystemMessageModelToJson(
        VochatSystemMessageModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'create_time': instance.createTime,
      'id': instance.id,
      'images': instance.images,
      'link': instance.link,
      'title': instance.title,
      'update_time': instance.updateTime,
    };
