import 'dart:async';

import 'package:get/get.dart';
import 'package:colive/common/utils/colive_loading_util.dart';
import 'package:colive/home_mine/lucky_draw/widgets/colive_lucky_draw_records_dialog.dart';
import 'package:colive/services/widgets/dialogs/colive_confirm_dialog.dart';
import 'package:colive/services/widgets/dialogs/colive_dialog_util.dart';
import 'package:colive/services/widgets/dialogs/colive_quick_recharge_dialog.dart';
import 'package:colive/services/extensions/colive_api_response_ext.dart';
import 'package:colive/services/extensions/colive_preference_ext.dart';
import 'package:colive/services/models/colive_turntable_model.dart';
import 'package:colive/services/widgets/colive_base_controller.dart';

import '../../services/managers/colive_profile_manager.dart';
import 'colive_lucky_draw_state.dart';
import 'widgets/colive_lucky_draw_result_dialog.dart';
import 'widgets/colive_lucky_draw_rule_dialog.dart';

class ColiveLuckyDrawController extends ColiveBaseController {
  final state = ColiveLuckyDrawState();
  StreamController<int> wheelController = StreamController<int>();

  @override
  void onInit() {
    super.onInit();
    _initState();
  }

  @override
  void dispose() {
    wheelController.close();
    super.dispose();
  }

  @override
  void setupListener() {
    subsriptions
        .add(ColiveProfileManager.instance.profileStream.listen((event) {
      _initState();
    }));
  }

  void _initState() async {
    final rewardModel =
        ColiveTurntableModel.fromJson(ColiveAppPreferenceExt.luckyDrawJson);
    if (rewardModel.rewardList.isNotEmpty) {
      state.rewardListObs.value = rewardModel.rewardList;
      state.remainTimesObs.value =
          ColiveProfileManager.instance.userInfo.turntableNum;
    }

    final result = await apiClient.fetchTurntableList().response;
    if (result.isSuccess && result.data != null) {
      final resultModel = result.data!;
      state.rewardListObs.value = resultModel.rewardList;
      state.remainTimesObs.value = resultModel.turntableNum;
      ColiveAppPreferenceExt.luckyDrawJson = resultModel.toJson();
    }
  }

  void onTapGo() async {
    if (state.remainTimesObs.value <= 0) {
      final message = 'colive_no_remain_times_tips'.tr;
      final result = await ColiveDialogUtil.showDialog(
          ColiveConfirmDialog(content: message));
      if (result == null || !result) {
        return;
      }
      ColiveDialogUtil.showDialog(
          const ColiveQuickRechargeDialog(isBalanceInsufficient: false));
      return;
    }
    if (state.isDrawing) {
      return;
    }
    ColiveLoadingUtil.show();
    final result = await apiClient.requestDrawTurntable().response;
    ColiveLoadingUtil.dismiss();
    final data = result.data;
    if (!result.isSuccess || data == null) {
      ColiveLoadingUtil.showToast(result.msg);
      return;
    }
    state.rewardResult = data.rewards.firstOrNull;
    state.remainTimesObs.value = data.turntableNum;
    final drawIndex = _findDrawResultIndex();
    if (drawIndex < 0) {
      ColiveLoadingUtil.showToast('colive_failed'.tr);
      return;
    }
    // 选中结果
    wheelController.add(drawIndex);
    ColiveProfileManager.instance.fetchProfile();
  }

  int _findDrawResultIndex() {
    for (int i = 0; i < state.rewardListObs.length; i++) {
      final reward = state.rewardListObs[i];
      if (reward.itemType == state.rewardResult?.itemType) {
        return i;
      }
    }
    return -1;
  }

  void onAnimationStart() {
    state.isDrawing = true;
  }

  void onAnimationEnd() {
    state.isDrawing = false;
    final drawResult = state.rewardResult;
    if (drawResult == null) {
      return;
    }

    Get.dialog(ColiveLuckyDrawResultDialog(
      reward: drawResult,
    ));
  }

  void onTapRule() {
    ColiveDialogUtil.showDialog(const ColiveLuckyDrawRuleDialog());
  }

  void onTapRecord() {
    ColiveDialogUtil.showDialog(const ColiveLuckyDrawRecordsDialog());
  }
}
