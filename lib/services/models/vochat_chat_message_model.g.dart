// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vochat_chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VochatChatMessageModel _$VochatChatMessageModelFromJson(
        Map<String, dynamic> json) =>
    VochatChatMessageModel(
      messageId: json['messageId'] as String,
      messageType: (json['messageType'] as num).toInt(),
      status: (json['status'] as num).toInt(),
      isSelfSent: json['isSelfSent'] as bool,
      timestamp: (json['timestamp'] as num).toInt(),
      sessionId: json['sessionId'] as String,
      showTime: json['showTime'] as bool,
      customMessage: VochatChatCustomMessage.fromJson(
          json['customMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VochatChatMessageModelToJson(
        VochatChatMessageModel instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'messageId': instance.messageId,
      'messageType': instance.messageType,
      'status': instance.status,
      'isSelfSent': instance.isSelfSent,
      'timestamp': instance.timestamp,
      'showTime': instance.showTime,
      'customMessage': instance.customMessage,
    };

VochatChatCustomMessage _$VochatChatCustomMessageFromJson(
        Map<String, dynamic> json) =>
    VochatChatCustomMessage(
      (json['type'] as num).toInt(),
      json['content'] as String,
    );

Map<String, dynamic> _$VochatChatCustomMessageToJson(
        VochatChatCustomMessage instance) =>
    <String, dynamic>{
      'type': instance.type,
      'content': instance.content,
    };
