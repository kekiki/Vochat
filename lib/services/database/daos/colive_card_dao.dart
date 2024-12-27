import 'package:floor/floor.dart';

import '../../models/colive_card_base_model.dart';

@dao
abstract class ColiveCardDao {
  /// 查询会话列表
  @Query("SELECT * FROM database_table_cards ORDER BY id DESC")
  Stream<List<ColiveCardItemModel>?> getCardList();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAll(List<ColiveCardItemModel> cards);

  @Query("DELETE FROM database_table_cards")
  Future<void> clear();
}
