import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:advertising_id/advertising_id.dart';
import 'package:colive/common/event_bus/colive_event_bus.dart';
import 'package:colive/common/logger/colive_log_util.dart';
import 'package:colive/services/extensions/colive_preference_ext.dart';
import 'package:colive/services/managers/colive_gift_manager.dart';

import '../services/managers/colive_chat_manager.dart';
import '../services/managers/colive_event_bus_event.dart';
import '../services/managers/colive_event_logger.dart';
import '../services/managers/colive_profile_manager.dart';
import '../services/managers/colive_socket_manager.dart';
import '../services/topup/colive_topup_service.dart';
import '../services/widgets/colive_base_controller.dart';
import 'colive_home_state.dart';

class ColiveHomeController extends ColiveBaseController {
  final state = ColiveHomeState();

  @override
  void onInit() {
    super.onInit();

    ColiveEventLogger.instance.login();
    ColiveChatManager.instance.init();
    ColiveSocketManager.instance.init();
  }

  @override
  void onReady() {
    super.onReady();

    _setupService();
  }

  @override
  void onClose() {
    ColiveEventLogger.instance.logout();
    ColiveChatManager.instance.release();
    ColiveSocketManager.instance.release();
    super.onClose();
  }

  void _setupService() async {
    await _fetchDeviceAdid();
    await ColiveProfileManager.instance.fetchProfile();
    await ColiveTopupService.instance.init();
    await ColiveGiftManager.instance.init();
  }

  @override
  void setupListener() {
    subsriptions.add(
      _getConversationsUnreadCount().listen((count) {
        state.unReadMessageCountObs.value = count ?? 0;
      }),
    );
  }

  Stream<int?> _getConversationsUnreadCount() {
    try {
      return database.chatConversationDao.getAllConversationsUnreadCount();
    } catch (e) {
      return Stream.value(null);
    }
  }

  void onBack() {
    // Bring app to home screen when back button is pressed
    if (GetPlatform.isAndroid) {
      SystemChannels.platform.invokeMethod('android.back.pressed');
    }
  }

  void onTapTabItem(ColiveHomeTabType tabType) async {
    state.selectedTabTypeObs.value = tabType;
    if (tabType == ColiveHomeTabType.anchors) {
      ColiveEventBus.instance.fire(ColiveAnchorsRefreshEvent());
    }
  }

  Future<void> _fetchDeviceAdid() async {
    // Show tracking authorization dialog and ask for permission
    try {
      if (GetPlatform.isIOS) {
        final status =
            await AppTrackingTransparency.requestTrackingAuthorization();
        if (status == TrackingStatus.authorized) {
          final adid = await AppTrackingTransparency.getAdvertisingIdentifier();
          ColiveAppPreferenceExt.adid = adid;
        }
      } else {
        final adid = await AdvertisingId.id(true);
        ColiveAppPreferenceExt.adid = adid ?? '';
      }
    } catch (e) {
      ColiveLogUtil.e('Fetch adid', e.toString());
    }
  }
}
