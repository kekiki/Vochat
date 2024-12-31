import 'package:get/get.dart';
// import 'package:sqflite/sqflite.dart' as sqflite;

import 'vochat_database.dart';

class VochatDatabaseService extends GetxService {
  Future<VochatDatabase> init() async {
    final database = await $FloorVochatDatabase
        .databaseBuilder('database.db')
        .addMigrations(
      [
        // Migration(1, 2, (database) async {
        //   await migration1to2(database);
        // }),
      ],
    ).build();
    return database;
  }

  // Future<void> migration1to2(sqflite.Database database) async {
  //   await database.execute('DROP TABLE IF EXISTS `tbProductInfo`');
  //   await database.execute(
  //       'CREATE TABLE IF NOT EXISTS `tbProductInfo` (`appId` INTEGER NOT NULL, `coins` INTEGER NOT NULL, `discount` REAL NOT NULL, `price` REAL NOT NULL, `productId` TEXT NOT NULL, `rewardCoins` INTEGER NOT NULL, `status` INTEGER NOT NULL, `title` TEXT NOT NULL, `type` INTEGER NOT NULL, `priceText` TEXT NOT NULL, `mostSelected` TEXT NOT NULL, `currency` TEXT NOT NULL, `rewardDurationCard` INTEGER NOT NULL, PRIMARY KEY (`productId`))');
  // }
}
