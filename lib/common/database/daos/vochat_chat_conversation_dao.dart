import 'package:floor/floor.dart';

import '../../../services/models/vochat_chat_conversation_model.dart';

@dao
abstract class VochatChatConversationDao {
  /// 查询会话列表
  @Query(
      "SELECT * FROM database_table_chat_conversation ORDER BY orderBy DESC,pin DESC,timestamp DESC")
  Stream<List<VochatChatConversationModel>?> getConversations();

  @Query("SELECT * FROM database_table_chat_conversation WHERE id = :id")
  Future<List<VochatChatConversationModel>?> getConversationsWithId(String id);

  @Query("SELECT sum(unreadCount) FROM database_table_chat_conversation")
  Stream<int?> getAllConversationsUnreadCount();

  ///插入多条数据
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAll(List<VochatChatConversationModel> conversations);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(VochatChatConversationModel conversation);

  ///清空单个会话消息未读数
  @Query(
      "UPDATE database_table_chat_conversation SET unreadCount = 0 WHERE id = :id")
  Future<void> clearConversationUnreadCount(String id);

  ///清空所有会话消息未读数
  @Query("UPDATE database_table_chat_conversation SET unreadCount = 0")
  Future<void> clearAllUnread();

  @Query("DELETE FROM database_table_chat_conversation WHERE id = :id")
  Future<void> deleteConversationsWithId(String id);

  @Query("DELETE FROM database_table_chat_conversation")
  Future<void> clear();
}
