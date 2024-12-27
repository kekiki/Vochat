import 'package:floor/floor.dart';

import '../../models/colive_order_item_model.dart';

@dao
abstract class ColiveOrderDao {
  @Query('SELECT * FROM database_table_order_info')
  Future<List<ColiveOrderItemModel>> getAllAnchors();

  @Query('SELECT * FROM database_table_order_info WHERE productId=:productId')
  Future<ColiveOrderItemModel?> findOrderByProductId(String productId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertOrder(ColiveOrderItemModel orderInfo);

  @Query('DELETE FROM database_table_order_info WHERE productId=:productId')
  Future<void> deleteOrderByProductId(String productId);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateOrder(ColiveOrderItemModel orderInfo);

  @Query('DELETE FROM database_table_order_info')
  Future<void> clear();
}
