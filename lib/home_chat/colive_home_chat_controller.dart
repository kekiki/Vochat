import 'package:colive/services/extensions/colive_api_response_ext.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:colive/services/managers/colive_chat_manager.dart';
import 'package:colive/services/managers/colive_profile_manager.dart';

import '../services/models/colive_chat_conversation_model.dart';
import '../services/routes/colive_routes.dart';
import '../services/widgets/colive_base_controller.dart';
import 'colive_home_chat_more_dialog.dart';
import 'colive_home_chat_state.dart';
import 'system_message/colive_system_message_page.dart';

class ColiveHomeChatController extends ColiveBaseController {
  final state = ColiveHomeChatState();

  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
  );

  // @override
  // void onReady() {
  //   super.onReady();
  //   _fetchSystemMessage();
  // }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  @override
  void setupListener() {
    super.setupListener();

    subsriptions
        .add(database.chatConversationDao.getConversations().listen((list) {
      if (list == null) return;
      state.conversationList.value = list;
    }));
    subsriptions
        .add(ColiveProfileManager.instance.profileStream.listen((event) {
      _fetchSystemMessage();
    }));
  }

  Future<void> _fetchSystemMessage() async {
    final result = await apiClient.fetchSystemMessageList('1').response;
    if (result.isSuccess && result.data != null) {
      state.systemMessageModelObs.value = result.data?.firstOrNull;
    }
  }

  void onRefresh() async {
    await _fetchSystemMessage();
    final isSuccess = await ColiveChatManager.instance.fetchConversationList();
    refreshController.finishRefresh(
        isSuccess ? IndicatorResult.success : IndicatorResult.fail);
  }

  void onTapSystemMessage() {
    Get.to(() => const ColiveSystemMessagePage());
  }

  void onTapConversation(ColiveChatConversationModel conversationModel) {
    Get.toNamed(ColiveRoutes.chat, arguments: conversationModel.id);
  }

  void onTapPin(ColiveChatConversationModel conversationModel) async {
    if (conversationModel.pin == 1) {
      conversationModel.pin = 0;
    } else {
      conversationModel.pin = 1;
    }
    await ColiveChatManager.instance.saveLocalConversation(conversationModel);
  }

  void onTapDelete(ColiveChatConversationModel conversationModel) {
    state.conversationList
        .removeWhere((element) => element.id == conversationModel.id);
    ColiveChatManager.instance.deleteConversationWithId(conversationModel.id);
  }

  void onTapMore() {
    Get.bottomSheet(
      ColiveHomeChatMoreDialog(
        onTapIgnoreUnread: _onTapIgnoreUnread,
        onTapDeleteAll: _onTapDeleteAll,
      ),
    );
  }

  void _onTapIgnoreUnread() {
    ColiveChatManager.instance.clearUnreadConversationAll();
  }

  void _onTapDeleteAll() async {
    for (var element in state.conversationList) {
      if (!element.isCustomerService) {
        ColiveChatManager.instance.deleteConversationWithId(element.id);
      }
    }
  }
}
