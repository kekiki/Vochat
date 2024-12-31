import 'package:get/get.dart';
import 'package:vochat/common/extensions/vochat_api_response_ext.dart';
import 'package:vochat/services/models/vochat_card_base_model.dart';

import '../../common/api/vochat_api_client.dart';
import '../../common/database/vochat_database.dart';
import '../../common/logger/vochat_log_util.dart';

class VochatCardRepository {
  static const _tag = "CardRepository";
  final VochatApiClient _apiClient = Get.find<VochatApiClient>();
  final VochatDatabase _database = Get.find<VochatDatabase>();

  Future<List<VochatCardItemModel>?> fetchCardList() async {
    final result = await _apiClient.fetchBackpackInfo().response;
    final data = result.data;
    if (!result.isSuccess || data == null) {
      VochatLogUtil.e(_tag, result.msg);
      return null;
    }
    final cardList = data.videoCoupon + data.discountCoupon;
    await _database.cardDao.clear();
    _database.cardDao.insertAll(cardList);
    return cardList;
  }

  Stream<List<VochatCardItemModel>?> getCardList() {
    return _database.cardDao.getCardList();
  }
}
