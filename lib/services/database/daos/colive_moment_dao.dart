import 'package:floor/floor.dart';

import '../../models/colive_moment_item_model.dart';

@dao
abstract class ColiveMomentDao {
  @Query(
      'SELECT * FROM database_table_moment_info WHERE uid=:anchorId ORDER BY createTime DESC')
  Future<List<ColiveMomentItemModel>> findMomentListByAnchorId(int anchorId);

  @Query('SELECT * FROM database_table_moment_info WHERE id=:id')
  Future<ColiveMomentItemModel?> findMomentById(int id);

  @Query('SELECT * FROM database_table_moment_info WHERE id=:id')
  Stream<ColiveMomentItemModel?> findMomentByIdAsStream(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMoment(ColiveMomentItemModel moment);

  @Query('DELETE FROM database_table_moment_info')
  Future<void> clear();
}
