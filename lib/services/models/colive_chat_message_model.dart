import 'package:json_annotation/json_annotation.dart';
import 'package:colive/common/utils/colive_format_util.dart';

import '../managers/colive_chat_extension.dart';

part 'colive_chat_message_model.g.dart';

@JsonSerializable()
class ColiveChatMessageModel {
  // 对方用户ID
  final String sessionId;

  /// 消息ID,唯一标识
  final String messageId;

  /// 消息类型
  final int messageType;

  //status= 0草稿，1发送中，2发送成功，3发送失败，4消息已读， 5消息未读
  int status = 0;

  // 是否自己发送的消息
  final bool isSelfSent;

  // 消息发送时间
  final int timestamp;

  // 是否显示时间
  bool showTime = false;

  final ColiveChatCustomMessage customMessage;

  bool get isMedia => isImage || isVideo;

  bool get isImage => messageType == ColiveChatMessageType.image;

  bool get isVideo => messageType == ColiveChatMessageType.video;

  ColiveChatMessageModel({
    required this.messageId,
    required this.messageType,
    required this.status,
    required this.isSelfSent,
    required this.timestamp,
    required this.sessionId,
    required this.showTime,
    required this.customMessage,
  });

  String get userId {
    return sessionId
        .replaceAll('hichat_robot_', '')
        .replaceAll('hichat_anchor_', '');
  }

  String get sentTime => ColiveFormatUtil.millisecondsToTime(timestamp);

  factory ColiveChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ColiveChatMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ColiveChatMessageModelToJson(this);

  ColiveChatMessageModel copyWith({
    String? messageId,
    int? messageType,
    int? status,
    bool? isSelfSent,
    int? timestamp,
    String? sessionId,
    bool? showTime,
    ColiveChatCustomMessage? customMessage,
  }) {
    return ColiveChatMessageModel(
      messageId: messageId ?? this.messageId,
      messageType: messageType ?? this.messageType,
      status: status ?? this.status,
      isSelfSent: isSelfSent ?? this.isSelfSent,
      timestamp: timestamp ?? this.timestamp,
      sessionId: sessionId ?? this.sessionId,
      showTime: showTime ?? this.showTime,
      customMessage: customMessage ?? this.customMessage,
    );
  }
}

@JsonSerializable()
class ColiveChatCustomMessage {
  final int type;
  String content;

  ColiveChatCustomMessage(this.type, this.content);

  factory ColiveChatCustomMessage.fromJson(Map<String, dynamic> json) =>
      _$ColiveChatCustomMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ColiveChatCustomMessageToJson(this);

  factory ColiveChatCustomMessage.empty() =>
      ColiveChatCustomMessage(-1, '');
}
