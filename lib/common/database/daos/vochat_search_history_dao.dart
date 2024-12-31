import 'package:floor/floor.dart';
import 'package:vochat/services/models/vochat_search_history_model.dart';

@dao
abstract class SearchHistoryDao {
  @Query(
      'SELECT * FROM database_table_search_history ORDER BY time DESC LIMIT 10')
  Stream<List<VochatSearchHistoryModel>?> getHistoryListByStream();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertHistory(VochatSearchHistoryModel history);

  @Query('DELETE FROM database_table_search_history')
  Future<void> clear();
}
