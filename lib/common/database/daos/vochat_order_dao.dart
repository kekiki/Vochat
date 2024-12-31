import 'package:floor/floor.dart';

import '../../../services/models/vochat_order_item_model.dart';

@dao
abstract class VochatOrderDao {
  @Query('SELECT * FROM database_table_order_info')
  Future<List<VochatOrderItemModel>> getAllAnchors();

  @Query('SELECT * FROM database_table_order_info WHERE productId=:productId')
  Future<VochatOrderItemModel?> findOrderByProductId(String productId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertOrder(VochatOrderItemModel orderInfo);

  @Query('DELETE FROM database_table_order_info WHERE productId=:productId')
  Future<void> deleteOrderByProductId(String productId);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateOrder(VochatOrderItemModel orderInfo);

  @Query('DELETE FROM database_table_order_info')
  Future<void> clear();
}
