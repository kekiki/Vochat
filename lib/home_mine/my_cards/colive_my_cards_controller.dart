import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:colive/services/managers/colive_profile_manager.dart';

import 'package:colive/services/widgets/colive_base_controller.dart';

import '../../services/repositories/colive_card_repository.dart';
import 'colive_my_cards_state.dart';

class ColiveMyCardsController extends ColiveBaseController {
  final state = ColiveMyCardsState();
  final _cardRepository = Get.find<ColiveCardRepository>();

  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
  );

  @override
  void onInit() {
    state.dataListObs.value = ColiveProfileManager.instance.cardList;
    super.onInit();
  }

  void onRefresh() async {
    try {
      final cardList = await _cardRepository.fetchCardList();
      if (cardList == null) {
        state.isLoadFailedObs.value = state.dataListObs.isEmpty;
        refreshController.finishRefresh(IndicatorResult.fail);
        return;
      }
      state.dataListObs.value = cardList;
      state.isNoDataObs.value = state.dataListObs.isEmpty;
      state.isLoadFailedObs.value = false;
      refreshController.finishRefresh(IndicatorResult.success);
    } catch (e) {
      state.isLoadFailedObs.value = state.dataListObs.isEmpty;
      refreshController.finishRefresh(IndicatorResult.fail);
    }
  }
}
