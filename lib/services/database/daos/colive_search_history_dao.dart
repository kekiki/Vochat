import 'package:floor/floor.dart';
import 'package:colive/services/models/colive_search_history_model.dart';

@dao
abstract class SearchHistoryDao {
  @Query(
      'SELECT * FROM database_table_search_history ORDER BY time DESC LIMIT 10')
  Stream<List<ColiveSearchHistoryModel>?> getHistoryListByStream();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertHistory(ColiveSearchHistoryModel history);

  @Query('DELETE FROM database_table_search_history')
  Future<void> clear();
}
