import 'package:floor/floor.dart';

import '../../models/colive_chat_conversation_model.dart';

@dao
abstract class ColiveChatConversationDao {
  /// 查询会话列表
  @Query(
      "SELECT * FROM database_table_chat_conversation ORDER BY orderBy DESC,pin DESC,timestamp DESC")
  Stream<List<ColiveChatConversationModel>?> getConversations();

  @Query("SELECT * FROM database_table_chat_conversation WHERE id = :id")
  Future<List<ColiveChatConversationModel>?> getConversationsWithId(
      String id);

  @Query("SELECT sum(unreadCount) FROM database_table_chat_conversation")
  Stream<int?> getAllConversationsUnreadCount();

  ///插入多条数据
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAll(List<ColiveChatConversationModel> conversations);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(ColiveChatConversationModel conversation);

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
