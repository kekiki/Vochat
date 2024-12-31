import 'package:get/get.dart';
import 'package:vochat/common/logger/vochat_log_util.dart';
import 'package:vochat/services/models/vochat_gift_base_model.dart';

import '../../login/managers/vochat_profile_manager.dart';
import '../../common/api/vochat_api_client.dart';
import '../../common/preference/vochat_preference.dart';
import '../../common/utils/vochat_loading_util.dart';
import '../../common/widgets/dialogs/gift/vochat_gift_animate_controller.dart';
import '../../common/widgets/dialogs/gift/vochat_gift_icon_controlller.dart';
import '../../common/widgets/dialogs/vochat_dialog_util.dart';
import '../../common/widgets/dialogs/vochat_quick_recharge_dialog.dart';
import 'vochat_download_manager.dart';
import 'vochat_analytics_manager.dart';
import 'vochat_chat_manager.dart';

enum VochatGiftListType {
  all,
  normal,
  vip,
  backpack,
}

class VochatGiftManager {
  VochatGiftManager._internal();

  static VochatGiftManager? _instance;

  static VochatGiftManager get instance =>
      _instance ??= VochatGiftManager._internal();

  VochatGiftBaseModel _giftBaseModel =
      VochatGiftBaseModel.fromJson(VochatPreference.giftInfoJson);
  VochatGiftBaseModel get giftBaseModel => _giftBaseModel;

  List<VochatGiftItemModel> get backpackGiftList =>
      _giftBaseModel.backpackGiftList;
  List<VochatGiftItemModel> get giftList => _giftBaseModel.giftList;
  List<VochatGiftItemModel> get vipGiftList => _giftBaseModel.vipGiftList;

  static const _tag = "GiftManager";
  final VochatApiClient _apiClient = Get.find<VochatApiClient>();

  Future<void> init() async {
    await fetchGiftList(listType: VochatGiftListType.all);
  }

  Future<void> fetchGiftList({required VochatGiftListType listType}) async {
    final result = await _apiClient.fetchGiftList(listType.index.toString());
    if (result.isSuccess && result.data != null) {
      switch (listType) {
        case VochatGiftListType.all:
          _giftBaseModel = result.data!;
          break;
        case VochatGiftListType.normal:
          _giftBaseModel = _giftBaseModel.copyWith(
            giftList: result.data!.giftList,
          );
          break;
        case VochatGiftListType.vip:
          _giftBaseModel = _giftBaseModel.copyWith(
            vipGiftList: result.data!.vipGiftList,
          );
          break;
        case VochatGiftListType.backpack:
          _giftBaseModel = _giftBaseModel.copyWith(
            backpackGiftList: result.data!.backpackGiftList,
          );
          break;
      }
      _giftBaseModel.giftList.sort(((a, b) => a.sort.compareTo(b.sort)));
      _giftBaseModel.vipGiftList.sort(((a, b) => a.sort.compareTo(b.sort)));
      _giftBaseModel.backpackGiftList
          .sort(((a, b) => a.sort.compareTo(b.sort)));
      VochatPreference.giftInfoJson = _giftBaseModel.toJson();

      _preloadGiftAnimates();
    } else {
      VochatLogUtil.e(_tag, 'fetchGiftList failed: ${result.msg}');
    }
  }

  void _preloadGiftAnimates() {
    for (var element in giftList) {
      VochatDownloadManager.instance.preload(element.cartoonUrl);
    }
  }

  Future<bool> sendGift({
    required VochatGiftItemModel gift,
    required int anchorId,
    required String sessionId,
    bool isCalling = false,
    String conversationId = '',
    bool isBackpackGift = false,
  }) async {
    if (!isBackpackGift) {
      final userInfo = VochatProfileManager.instance.userInfo;
      if (userInfo.mizuan < gift.price) {
        VochatDialogUtil.showDialog(
          const VochatQuickRechargeDialog(isBalanceInsufficient: true),
        );
        return false;
      }
    }

    VochatLoadingUtil.show();
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
      VochatLoadingUtil.dismiss();
    }
    if (!result.isSuccess || result.data == null) {
      VochatLoadingUtil.dismiss();
      VochatLoadingUtil.showToast(result.msg);
      return false;
    }

    // 1是余额不足 2是用户拉黑主播 3是主播拉黑用户 4是送出去了
    final status = result.data!['status'] ?? 0;
    if (status == 1) {
      //
      VochatLoadingUtil.dismiss();
      VochatDialogUtil.showDialog(
        const VochatQuickRechargeDialog(isBalanceInsufficient: true),
      );
      return false;
    } else if (status == 2) {
      VochatLoadingUtil.dismiss();
      VochatLoadingUtil.showToast('vochat_to_block_tips'.tr);
      return false;
    } else if (status == 3) {
      VochatLoadingUtil.dismiss();
      VochatLoadingUtil.showToast('vochat_be_block_tips'.tr);
      return false;
    }

    if (Get.isRegistered<VochatGiftIconController>(tag: gift.id.toString())) {
      Get.find<VochatGiftIconController>(tag: gift.id.toString())
          .showAnimation();
    }
    if (Get.isRegistered<VochatGiftAnimateController>()) {
      Get.find<VochatGiftAnimateController>().addGift(gift);
    }
    VochatChatManager.instance.sendGiftMessage(
      sessionId: sessionId,
      gift: gift,
    );

    return true;
  }
}
