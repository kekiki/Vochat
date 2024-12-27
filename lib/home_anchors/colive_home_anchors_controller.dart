import 'package:colive/services/extensions/colive_preference_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/services/extensions/colive_api_response_ext.dart';
import 'package:colive/services/managers/colive_profile_manager.dart';
import 'package:colive/services/topup/colive_topup_service.dart';
import '../common/event_bus/colive_event_bus.dart';
import '../services/managers/colive_event_bus_event.dart';
import '../services/widgets/dialogs/colive_dialog_util.dart';
import '../services/widgets/dialogs/colive_first_recharge_dialog.dart';
import '../services/widgets/dialogs/colive_quick_recharge_dialog.dart';
import '../services/widgets/colive_base_controller.dart';
import 'colive_home_anchors_state.dart';
import 'widgets/colive_filter_area_dialog.dart';

class ColiveHomeAnchorsController extends ColiveBaseController
    with GetSingleTickerProviderStateMixin {
  final state = ColiveHomeAnchorsState();
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    if (ColiveAppPreferenceExt.currentArea.isNotEmpty) {
      state.currentAreaObs.value = ColiveAppPreferenceExt.currentArea;
    }
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_tabChanged);
    ColiveTopupService.instance
        .addPromotionCountdownAction(_promotionProductCountdown);
    _fetchNewUserReward();
  }

  @override
  void onClose() {
    tabController.removeListener(_tabChanged);
    tabController.dispose();
    ColiveTopupService.instance
        .removePromotionCountdownAction(_promotionProductCountdown);
    super.onClose();
  }

  void _tabChanged() {
    state.isPopularTabObs.value = tabController.index == 0;
  }

  void onTapFilter() async {
    final list = ColiveAppPreferenceExt.areList;
    if (list.isNotEmpty) {
      final result = await Get.dialog(ColiveFilterAreaDialog(
        currentArea: state.currentAreaObs.value,
        areaList: list,
      ));
      if (result != null && result != state.currentAreaObs.value) {
        state.currentAreaObs.value = result;
        ColiveAppPreferenceExt.currentArea = result;
        ColiveEventBus.instance.fire(ColiveCurrentAreaChangedEvent());
      }
    }
  }

  void _promotionProductCountdown(int seconds) {
    state.floatingSecondsObs.value = seconds;
  }

  void _fetchNewUserReward() async {
    final result = await apiClient.fetchActivityStatus().response;
    if (!result.isSuccess || result.data == null) {
      return;
    }
    final status = result.data!['status'] ?? 0;
    final countdown = result.data!['countdown'] ?? 0;
    if (status == 1) {
      await Future.delayed(Duration(seconds: countdown));
      await apiClient.fetchNewUserReward();
      ColiveProfileManager.instance.fetchProfile();
    }
  }

  void onTapFloating() {
    final product = ColiveTopupService.instance.firstRechargeProduct;
    if (product != null && state.floatingSecondsObs.value > 0) {
      ColiveDialogUtil.showDialog(
        ColiveFirstRechargeDialog(product: product),
      );
    } else {
      ColiveDialogUtil.showDialog(
        const ColiveQuickRechargeDialog(isBalanceInsufficient: false),
      );
    }
  }
}
