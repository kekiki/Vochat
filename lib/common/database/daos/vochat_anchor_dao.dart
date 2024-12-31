import 'package:floor/floor.dart';

import '../../../services/models/vochat_anchor_model.dart';

@dao
abstract class VochatAnchorDao {
  @Query('SELECT * FROM database_table_anchor_info')
  Future<List<VochatAnchorModel>> getAllAnchors();

  @Query('SELECT * FROM database_table_anchor_info WHERE isLike=true')
  Stream<List<VochatAnchorModel>> getFollowAnchorsAsStream();

  @Query('SELECT * FROM database_table_anchor_info WHERE id=:id')
  Future<VochatAnchorModel?> findAnchorById(int id);

  @Query('SELECT * FROM database_table_anchor_info WHERE id=:id')
  Stream<VochatAnchorModel?> findAnchorByIdAsStream(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAnchor(VochatAnchorModel anchorInfo);

  // @Insert(onConflict: OnConflictStrategy.replace)
  // Future<void> insertAnchorList(List<VochatAnchorModel> anchorList);

  @delete
  Future<void> deleteAnchor(VochatAnchorModel anchorInfo);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateAnchor(VochatAnchorModel anchorInfo);

  @Query('DELETE FROM database_table_anchor_info')
  Future<void> clear();
}
