// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colive_chat_conversation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColiveChatConversationModel _$ColiveChatConversationModelFromJson(
        Map<String, dynamic> json) =>
    ColiveChatConversationModel(
      id: json['id'] as String? ?? '',
      avatar: json['avatar'] as String?,
      username: json['username'] as String?,
      summary: json['summary'] as String?,
      timestamp: (json['timestamp'] as num).toInt(),
      unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
      orderBy: (json['orderBy'] as num).toInt(),
      pin: (json['pin'] as num).toInt(),
    );

Map<String, dynamic> _$ColiveChatConversationModelToJson(
        ColiveChatConversationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatar': instance.avatar,
      'username': instance.username,
      'summary': instance.summary,
      'timestamp': instance.timestamp,
      'unreadCount': instance.unreadCount,
      'orderBy': instance.orderBy,
      'pin': instance.pin,
    };
