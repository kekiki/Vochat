import 'package:floor/floor.dart';

import '../../../services/models/vochat_card_base_model.dart';

@dao
abstract class VochatCardDao {
  /// 查询会话列表
  @Query("SELECT * FROM database_table_cards ORDER BY id DESC")
  Stream<List<VochatCardItemModel>?> getCardList();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAll(List<VochatCardItemModel> cards);

  @Query("DELETE FROM database_table_cards")
  Future<void> clear();
}
