import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vochat/services/managers/vochat_chat_manager.dart';

part 'vochat_chat_conversation_model.g.dart';

@Entity(tableName: "database_table_chat_conversation")
@JsonSerializable()
class VochatChatConversationModel {
  ///唯一会话ID
  @primaryKey
  @JsonKey(name: "id", defaultValue: '')
  String id;

  ///用户头像
  @JsonKey(name: "avatar")
  String? avatar;

  ///用户昵称
  @JsonKey(name: "username")
  String? username;

  ///最后一条消息概括内容
  @JsonKey(name: "summary")
  String? summary;

  ///最后一条消息时间戳
  @JsonKey(name: "timestamp")
  int timestamp;

  ///未读数量
  @JsonKey(name: "unreadCount", defaultValue: 0)
  int unreadCount;

  ///排序
  @JsonKey(name: "orderBy")
  int orderBy;

  ///置顶
  @JsonKey(name: "pin")
  int pin;

  bool get isPin {
    return pin == 1;
  }

  bool get isRobot {
    return id.contains('hichat_robot_');
  }

  int get userId {
    final uid =
        id.replaceAll('hichat_robot_', '').replaceAll('hichat_anchor_', '');
    return int.tryParse(uid) ?? 0;
  }

  bool get isCustomerService {
    return VochatChatManager.isCustomerServiceId(id);
  }

  VochatChatConversationModel(
      {required this.id,
      required this.avatar,
      required this.username,
      required this.summary,
      required this.timestamp,
      required this.unreadCount,
      required this.orderBy,
      required this.pin});

  VochatChatConversationModel copyWith(
      {String? id,
      String? avatar,
      String? username,
      String? summary,
      int? timestamp,
      int? unreadCount,
      int? orderBy,
      int? pin}) {
    return VochatChatConversationModel(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        username: username ?? this.username,
        summary: summary ?? this.summary,
        timestamp: timestamp ?? this.timestamp,
        unreadCount: unreadCount ?? this.unreadCount,
        orderBy: orderBy ?? this.orderBy,
        pin: pin ?? this.pin);
  }

  static VochatChatConversationModel empty() {
    return VochatChatConversationModel(
      id: '',
      avatar: '',
      username: '',
      summary: '',
      timestamp: 0,
      unreadCount: 0,
      orderBy: 0,
      pin: 0,
    );
  }

  static VochatChatConversationModel createCustomerService(
      String id, int orderBy) {
    return VochatChatConversationModel(
      id: id,
      avatar: '',
      username: id.toString(),
      summary: '',
      timestamp: 0,
      unreadCount: 0,
      orderBy: orderBy,
      pin: 0,
    );
  }

  factory VochatChatConversationModel.fromJson(Map<String, dynamic> json) =>
      _$VochatChatConversationModelFromJson(json);

  Map<String, dynamic> toJson() => _$VochatChatConversationModelToJson(this);
}
