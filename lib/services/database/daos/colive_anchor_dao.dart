import 'package:floor/floor.dart';

import '../../models/colive_anchor_model.dart';

@dao
abstract class ColiveAnchorDao {
  @Query('SELECT * FROM database_table_anchor_info')
  Future<List<ColiveAnchorModel>> getAllAnchors();

  @Query('SELECT * FROM database_table_anchor_info WHERE isLike=true')
  Stream<List<ColiveAnchorModel>> getFollowAnchorsAsStream();

  @Query('SELECT * FROM database_table_anchor_info WHERE id=:id')
  Future<ColiveAnchorModel?> findAnchorById(int id);

  @Query('SELECT * FROM database_table_anchor_info WHERE id=:id')
  Stream<ColiveAnchorModel?> findAnchorByIdAsStream(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAnchor(ColiveAnchorModel anchorInfo);

  // @Insert(onConflict: OnConflictStrategy.replace)
  // Future<void> insertAnchorList(List<ColiveAnchorModel> anchorList);

  @delete
  Future<void> deleteAnchor(ColiveAnchorModel anchorInfo);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateAnchor(ColiveAnchorModel anchorInfo);

  @Query('DELETE FROM database_table_anchor_info')
  Future<void> clear();
}
