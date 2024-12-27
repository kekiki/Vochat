import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:colive/common/utils/colive_format_util.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/extensions/colive_preference_ext.dart';
import 'package:colive/services/managers/colive_profile_manager.dart';
import 'package:colive/services/widgets/dialogs/colive_confirm_dialog.dart';
import 'package:colive/services/widgets/dialogs/colive_dialog_util.dart';

import '../services/repositories/colive_card_repository.dart';
import '../services/routes/colive_routes.dart';
import '../services/widgets/colive_base_controller.dart';
import 'colive_home_mine_state.dart';
import 'my_follows/colive_my_follows_state.dart';

class ColiveHomeMineController extends ColiveBaseController {
  final state = ColiveHomeMineState();

  final _cardRepository = Get.find<ColiveCardRepository>();
  final _cardNum = 0.obs;

  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
  );

  @override
  void onInit() {
    state.profileObs.value = ColiveProfileManager.instance.userInfo;
    state.isNoDisturbModeObs.value = ColiveAppPreferenceExt.isNoDisturbMode;
    super.onInit();
    reloadData();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  @override
  void setupListener() {
    subsriptions.add(ColiveProfileManager.instance.profileStream.listen((user) {
      state.profileObs.value = user;
      reloadData();
    }));
    subsriptions.add(_cardRepository.getCardList().listen((list) {
      if (list == null) return;
      int cardNum = 0;
      for (var element in list) {
        cardNum += element.num;
      }
      _cardNum.value = cardNum;
      reloadData();
    }));
  }

  void reloadData() {
    state.dataListObs.value = [
      ColiveMineListItem(
        icon: Assets.imagesColiveMineVip,
        title: 'colive_vip',
        subTitle: state.profileObs.value.isVIP
            ? ColiveFormatUtil.millisecondsToDate(
                state.profileObs.value.vipDate * 1000)
            : '',
        onTap: () {
          Get.toNamed(ColiveRoutes.vip);
        },
      ),
      ColiveMineListItem(
        icon: Assets.imagesColiveMineLottery,
        title: 'colive_lottery',
        onTap: () {
          Get.toNamed(ColiveRoutes.luckyDraw);
        },
      ),
      ColiveMineListItem(
        icon: Assets.imagesColiveMineCard,
        title: 'colive_cards',
        subTitle: _cardNum.value > 0 ? 'x${_cardNum.value}' : '',
        onTap: () {
          Get.toNamed(ColiveRoutes.myCards);
        },
      ),
      ColiveMineListItem(
        icon: Assets.imagesColiveMineBills,
        title: 'colive_bills',
        onTap: () {
          Get.toNamed(ColiveRoutes.myBills);
        },
      ),
      ColiveMineListItem(
        icon: Assets.imagesColiveMineNoDisturb,
        title: 'colive_no_disturb',
        onTap: () async {
          if (!state.isNoDisturbModeObs.value) {
            final isOpend = await ColiveDialogUtil.showDialog(
              ColiveConfirmDialog(content: 'colive_no_disturb_tips'.tr),
            );
            if (isOpend == null || !isOpend) return;
          }
          state.isNoDisturbModeObs.value = !state.isNoDisturbModeObs.value;
          ColiveAppPreferenceExt.isNoDisturbMode =
              state.isNoDisturbModeObs.value;
        },
      ),
      ColiveMineListItem(
        icon: Assets.imagesColiveMineSettings,
        title: 'colive_settings',
        onTap: () {
          Get.toNamed(ColiveRoutes.settings);
        },
      ),
    ];
  }

  void onRefresh() async {
    final result = await ColiveProfileManager.instance.fetchProfile();
    refreshController.finishRefresh(
        result.isSuccess ? IndicatorResult.success : IndicatorResult.fail);
  }

  void onTapFollows(ColiveMyFollowsType followsType) {
    Get.toNamed(ColiveRoutes.myFollows, arguments: followsType);
  }

  void onTapStore() {
    Get.toNamed(ColiveRoutes.store);
  }

  void onTapEditProfile() {
    Get.toNamed(ColiveRoutes.editProfile);
  }

  void onTapCustomService() {
    if (ColiveAppPreferenceExt.customerServiceId.isNotEmpty) {
      Get.toNamed(
        ColiveRoutes.chat,
        arguments: ColiveAppPreferenceExt.customerServiceId,
      );
    }
  }
}
