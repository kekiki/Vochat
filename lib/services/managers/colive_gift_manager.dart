import 'package:get/get.dart';
import 'package:colive/common/logger/colive_log_util.dart';
import 'package:colive/services/widgets/dialogs/colive_dialog_util.dart';
import 'package:colive/services/widgets/dialogs/colive_quick_recharge_dialog.dart';
import 'package:colive/services/models/colive_gift_base_model.dart';

import '../../common/utils/colive_loading_util.dart';
import '../api/colive_api_client.dart';
import '../widgets/dialogs/gift/colive_gift_animate_controller.dart';
import '../widgets/dialogs/gift/colive_gift_icon_controlller.dart';
import 'colive_download_manager.dart';
import '../extensions/colive_preference_ext.dart';
import 'colive_analytics_manager.dart';
import 'colive_chat_manager.dart';
import 'colive_profile_manager.dart';

enum ColiveGiftListType {
  all,
  normal,
  vip,
  backpack,
}

class ColiveGiftManager {
  ColiveGiftManager._internal();

  static ColiveGiftManager? _instance;

  static ColiveGiftManager get instance =>
      _instance ??= ColiveGiftManager._internal();

  ColiveGiftBaseModel _giftBaseModel =
      ColiveGiftBaseModel.fromJson(ColiveAppPreferenceExt.giftInfoJson);
  ColiveGiftBaseModel get giftBaseModel => _giftBaseModel;

  List<ColiveGiftItemModel> get backpackGiftList =>
      _giftBaseModel.backpackGiftList;
  List<ColiveGiftItemModel> get giftList => _giftBaseModel.giftList;
  List<ColiveGiftItemModel> get vipGiftList => _giftBaseModel.vipGiftList;

  static const _tag = "GiftManager";
  final ColiveApiClient _apiClient = Get.find<ColiveApiClient>();

  Future<void> init() async {
    await fetchGiftList(listType: ColiveGiftListType.all);
  }

  Future<void> fetchGiftList({required ColiveGiftListType listType}) async {
    final result = await _apiClient.fetchGiftList(listType.index.toString());
    if (result.isSuccess && result.data != null) {
      switch (listType) {
        case ColiveGiftListType.all:
          _giftBaseModel = result.data!;
          break;
        case ColiveGiftListType.normal:
          _giftBaseModel = _giftBaseModel.copyWith(
            giftList: result.data!.giftList,
          );
          break;
        case ColiveGiftListType.vip:
          _giftBaseModel = _giftBaseModel.copyWith(
            vipGiftList: result.data!.vipGiftList,
          );
          break;
        case ColiveGiftListType.backpack:
          _giftBaseModel = _giftBaseModel.copyWith(
            backpackGiftList: result.data!.backpackGiftList,
          );
          break;
      }
      _giftBaseModel.giftList.sort(((a, b) => a.sort.compareTo(b.sort)));
      _giftBaseModel.vipGiftList.sort(((a, b) => a.sort.compareTo(b.sort)));
      _giftBaseModel.backpackGiftList
          .sort(((a, b) => a.sort.compareTo(b.sort)));
      ColiveAppPreferenceExt.giftInfoJson = _giftBaseModel.toJson();

      _preloadGiftAnimates();
    } else {
      ColiveLogUtil.e(_tag, 'fetchGiftList failed: ${result.msg}');
    }
  }

  void _preloadGiftAnimates() {
    for (var element in giftList) {
      ColiveDownloadManager.instance.preload(element.cartoonUrl);
    }
  }

  Future<bool> sendGift({
    required ColiveGiftItemModel gift,
    required int anchorId,
    required String sessionId,
    bool isCalling = false,
    String conversationId = '',
    bool isBackpackGift = false,
  }) async {
    if (!isBackpackGift) {
      final userInfo = ColiveProfileManager.instance.userInfo;
      if (userInfo.diamonds < gift.price) {
        ColiveDialogUtil.showDialog(
          const ColiveQuickRechargeDialog(isBalanceInsufficient: true),
        );
        return false;
      }
    }

    ColiveLoadingUtil.show();
    final type = isCalling ? '2' : '1';
    final result = await _apiClient.sendGift(
      anchorId.toString(),
      gift.id.toString(),
      '1',
      type,
      conversationId,
      isBackpackGift ? '1' : '0',
    );
    if (!isBackpackGift) {
      ColiveLoadingUtil.dismiss();
    }
    if (!result.isSuccess || result.data == null) {
      ColiveLoadingUtil.dismiss();
      ColiveLoadingUtil.showToast(result.msg);
      return false;
    }

    // 1是余额不足 2是用户拉黑主播 3是主播拉黑用户 4是送出去了
    final status = result.data!['status'] ?? 0;
    if (status == 1) {
      //
      ColiveLoadingUtil.dismiss();
      ColiveDialogUtil.showDialog(
        const ColiveQuickRechargeDialog(isBalanceInsufficient: true),
      );
      return false;
    } else if (status == 2) {
      ColiveLoadingUtil.dismiss();
      ColiveLoadingUtil.showToast('colive_to_block_tips'.tr);
      return false;
    } else if (status == 3) {
      ColiveLoadingUtil.dismiss();
      ColiveLoadingUtil.showToast('colive_be_block_tips'.tr);
      return false;
    }

    if (Get.isRegistered<ColiveGiftIconController>(tag: gift.id.toString())) {
      Get.find<ColiveGiftIconController>(tag: gift.id.toString())
          .showAnimation();
    }
    if (Get.isRegistered<ColiveGiftAnimateController>()) {
      Get.find<ColiveGiftAnimateController>().addGift(gift);
    }
    ColiveChatManager.instance.sendGiftMessage(
      sessionId: sessionId,
      gift: gift,
    );

    ColiveAnalyticsManager.instance.logEvent(
      key: 'ConsumeDiamondGift',
      value: {'consume_gift_count': gift.price.toString()},
    );
    return true;
  }
}
