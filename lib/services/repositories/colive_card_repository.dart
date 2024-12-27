import 'package:get/get.dart';
import 'package:colive/services/extensions/colive_api_response_ext.dart';
import 'package:colive/services/models/colive_card_base_model.dart';

import '../../common/logger/colive_log_util.dart';
import '../api/colive_api_client.dart';
import '../database/colive_database.dart';

class ColiveCardRepository {
  static const _tag = "CardRepository";
  final ColiveApiClient _apiClient = Get.find<ColiveApiClient>();
  final ColiveDatabase _database = Get.find<ColiveDatabase>();

  Future<List<ColiveCardItemModel>?> fetchCardList() async {
    final result = await _apiClient.fetchBackpackInfo().response;
    final data = result.data;
    if (!result.isSuccess || data == null) {
      ColiveLogUtil.e(_tag, result.msg);
      return null;
    }
    final cardList = data.videoCoupon + data.discountCoupon;
    await _database.cardDao.clear();
    _database.cardDao.insertAll(cardList);
    return cardList;
  }

  Stream<List<ColiveCardItemModel>?> getCardList() {
    return _database.cardDao.getCardList();
  }
}
