// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colive_chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColiveChatMessageModel _$ColiveChatMessageModelFromJson(
        Map<String, dynamic> json) =>
    ColiveChatMessageModel(
      messageId: json['messageId'] as String,
      messageType: (json['messageType'] as num).toInt(),
      status: (json['status'] as num).toInt(),
      isSelfSent: json['isSelfSent'] as bool,
      timestamp: (json['timestamp'] as num).toInt(),
      sessionId: json['sessionId'] as String,
      showTime: json['showTime'] as bool,
      customMessage: ColiveChatCustomMessage.fromJson(
          json['customMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ColiveChatMessageModelToJson(
        ColiveChatMessageModel instance) =>
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

ColiveChatCustomMessage _$ColiveChatCustomMessageFromJson(
        Map<String, dynamic> json) =>
    ColiveChatCustomMessage(
      (json['type'] as num).toInt(),
      json['content'] as String,
    );

Map<String, dynamic> _$ColiveChatCustomMessageToJson(
        ColiveChatCustomMessage instance) =>
    <String, dynamic>{
      'type': instance.type,
      'content': instance.content,
    };
