import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:colive/common/event_bus/colive_event_bus.dart';
import 'package:colive/common/logger/colive_log_util.dart';
import 'package:colive/common/utils/colive_loading_util.dart';
import 'package:colive/home_chat/content/colive_chat_content_state.dart';
import 'package:colive/services/managers/colive_call_invitation_manager.dart';
import 'package:colive/services/managers/colive_chat_extension.dart';
import 'package:colive/services/managers/colive_chat_manager.dart';
import 'package:colive/services/managers/colive_event_bus_event.dart';
import 'package:colive/services/repositories/colive_anchor_repository.dart';
import 'package:colive/services/widgets/colive_base_controller.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../generated/assets.dart';
import '../../media/colive_media_model.dart';
import '../../services/widgets/dialogs/gift/colive_gift_dialog.dart';
import '../../services/widgets/dialogs/permission/colive_permission_dialog.dart';
import '../../services/managers/colive_profile_manager.dart';
import '../../services/models/colive_chat_block_model.dart';
import '../../services/models/colive_chat_message_model.dart';
import '../../services/routes/colive_routes.dart';
import '../../services/widgets/dialogs/colive_report_block_dialog.dart';

class ColiveChatContentController extends ColiveBaseController {
  final state = ColiveChatContentState();
  final editingController = TextEditingController();
  final editingNode = FocusNode();

  /// 消息列表滚动控制器
  final scrollController = ScrollController();
  bool get _isRobotSession => state.sessionId.contains('hichat_robot_');
  bool get _isChatLimited =>
      !state.profileObs.value.isVIP &&
      !state.isCustomerService.value &&
      state.blockModelObs.value.chatNum <= 0;

  @override
  void onInit() {
    super.onInit();
    state.sessionId = Get.arguments;
    state.isCustomerService.value =
        ColiveChatManager.isCustomerServiceId(state.sessionId);
    final uid = state.sessionId
        .replaceAll('hichat_robot_', '')
        .replaceAll('hichat_anchor_', '');
    state.anchorId = int.tryParse(uid) ?? 0;
    _setupListener();
    _initStates();
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrolllerListener);
    scrollController.dispose();
    editingController.removeListener(_editControllerListener);
    editingController.dispose();
    editingNode.removeListener(_editNodeListener);
    editingNode.dispose();
    super.onClose();
  }

  Future<void> _initStates() async {
    ColiveChatManager.instance.clearUnreadConversationWithId(state.sessionId);
    String emojiJson = await rootBundle.loadString(Assets.emojiEmojiList);
    state.emojiList = jsonDecode(emojiJson).cast<Map<String, dynamic>>();

    _fetchChatBlockInfo();
    await _fetchMessage();
    await _fetchAnchorInfo();

    // refresh gift list
    // await ColiveGiftManager.instance
    //     .fetchGiftList(listType: ColiveGiftListType.all);
    // state.giftModelObs.value = ColiveGiftManager.instance.giftBaseModel;
  }

  void _setupListener() {
    editingController.addListener(_editControllerListener);
    editingNode.addListener(_editNodeListener);
    scrollController.addListener(_scrolllerListener);

    subsriptions
        .add(ColiveProfileManager.instance.profileStream.listen((userinfo) {
      state.profileObs.value = userinfo;
    }));

    subsriptions.add(database.anchorDao
        .findAnchorByIdAsStream(state.anchorId)
        .listen((anchor) {
      if (anchor == null) return;
      state.anchorInfoObs.value = anchor;
      if (anchor.isRobot) {
        state.blockModelObs.value = ColiveChatBlockModel(
          anchor.area,
          anchor.chatNum,
          false,
          anchor.isToBlock,
        );
      }
    }));

    subsriptions.add(
        ColiveEventBus.instance.on<ColiveChatMessageEvent>().listen((event) {
      final message = event.data;
      if (message.sessionId != state.sessionId) {
        return;
      }
      if (state.messageList.isEmpty) {
        message.showTime = true;
      } else {
        final interval =
            (state.messageList.last.timestamp - message.timestamp).abs();
        if (interval / 1000 > ColiveChatManager.messageShowTimeInterval) {
          message.showTime = true;
        }
      }
      final index = state.messageList
          .indexWhere((element) => element.messageId == message.messageId);
      if (index >= 0) {
        if (index == 0) {
          message.showTime = true;
        }
        state.messageList[index] = message;
      } else {
        state.messageList.insert(0, message);
      }

      ColiveChatManager.instance.clearUnreadConversationWithId(state.sessionId);
    }));
  }

  void _editControllerListener() {
    state.enableSendObs.value = editingController.text.isNotEmpty;
  }

  void _editNodeListener() {
    if (editingNode.hasFocus) {
      state.inputTypeObs.value = ColiveChatInputType.keyboard;
    } else {
      if (state.inputTypeObs.value == ColiveChatInputType.keyboard) {
        state.inputTypeObs.value = ColiveChatInputType.none;
      }
    }
  }

  void _scrolllerListener() {
    if (!state.isMessageNoMore &&
        !state.isMessageLoading.value &&
        scrollController.position.pixels >=
            scrollController.position.maxScrollExtent) {
      _fetchMessage();
    }
  }

  Future<void> _fetchAnchorInfo() async {
    if (!state.isCustomerService.value) {
      final repository = Get.find<ColiveAnchorRepository>();
      repository.fetchAnchorInfo(
        isRobot: _isRobotSession,
        anchorId: state.anchorId,
        ignoreCache: true,
        fetchVideos: false,
      );
    }
  }

  Future<void> _fetchChatBlockInfo() async {
    if (!_isRobotSession && !state.isCustomerService.value) {
      final result = await apiClient.chatBlockInfo(state.anchorId.toString());
      if (result.isSuccess && result.data != null) {
        state.blockModelObs.value = result.data!;
      }
    }
  }

  Future<void> _fetchMessage() async {
    state.isMessageLoading.value = state.messageList.isNotEmpty;
    final messageList = await ColiveChatManager.instance.fetchMessageList(
      sessionId: state.sessionId,
      messageModel: state.messageList.lastOrNull,
    );
    state.messageList.addAll(messageList.reversed.toList());
    state.isMessageNoMore = messageList.isEmpty;
    await Future.delayed(const Duration(milliseconds: 1000));
    state.isMessageLoading.value = false;
  }

  Future<bool> _verifyMessage(int messageType, String content) async {
    String type = '0';
    if (messageType == ColiveChatMessageType.text) {
      type = '1';
    } else if (messageType == ColiveChatMessageType.image) {
      type = '2';
    } else if (messageType == ColiveChatMessageType.emoji) {
      type = '3';
    }
    final result = await apiClient.chatRecordInfo(
        state.anchorId.toString(), type, content);
    if (result.isSuccess && result.data != null) {
      final chatNum = result.data['chat_num'] ?? 0;
      final filter = result.data['is_filter'] ?? 0;
      state.blockModelObs.value = state.blockModelObs.value.copyWith(
        chatNum: chatNum,
      );
      return filter == 1;
    }
    return true;
  }

  void onLoadMore() async {
    _fetchMessage();
  }

  Future<void> onCloseKeyboard() async {
    if (editingNode.hasFocus) {
      editingNode.unfocus();
    } else {
      if (state.inputTypeObs.value != ColiveChatInputType.none) {
        await Future.delayed(const Duration(milliseconds: 100), () {
          state.inputTypeObs.value = ColiveChatInputType.none;
        });
      }
    }
  }

  void onTapMore() {
    if (state.anchorInfoObs.value == null) return;
    Get.bottomSheet(
      ColiveReportBlockDialog(
        anchor: state.anchorInfoObs.value!,
      ),
    );
  }

  void onTapVipBannerClose() {
    state.showVipBannerObs.value = false;
  }

  void onTapVipBanner() {
    Get.toNamed(ColiveRoutes.vip);
  }

  void onTapAnchorAvatar() {
    Get.toNamed(
      ColiveRoutes.anchorDetail,
      arguments: state.anchorInfoObs.value,
    );
  }

  void onTapUserAvatar() {
    // do nothing
  }

  void onTapMessage(ColiveChatMessageModel message) {
    if (message.isMedia) {
      final list = state.messageList.reversed.where((p) => p.isMedia).toList();
      final mediaList = list.map((e) {
        final path = e.customMessage.content;
        final type = e.isImage ? ColiveMediaType.photo : ColiveMediaType.video;
        return ColiveMediaModel(type: type, path: path);
      }).toList();

      final path = message.customMessage.content;
      final type =
          message.isImage ? ColiveMediaType.photo : ColiveMediaType.video;
      final media = ColiveMediaModel(type: type, path: path);

      final index =
          mediaList.indexWhere((element) => element.path == media.path);

      Get.toNamed(ColiveRoutes.media, arguments: {
        'index': index,
        'list': mediaList,
      });
    }
  }

  void onTapEmoji() async {
    if (state.inputTypeObs.value != ColiveChatInputType.emoji) {
      await onCloseKeyboard();
      Future.delayed(const Duration(milliseconds: 100), () {
        state.inputTypeObs.value = ColiveChatInputType.emoji;
      });
    }
  }

  void onTapGift() async {
    // if (state.inputTypeObs.value != ColiveChatInputType.gift) {
    //   await onCloseKeyboard();
    //   Future.delayed(const Duration(milliseconds: 100), () {
    //     state.inputTypeObs.value = ColiveChatInputType.gift;
    //   });
    // }

    onCloseKeyboard();
    Get.bottomSheet(
      ColiveGiftDialog(
        isCalling: false,
        anchorId: state.anchorId,
        sessionId: state.sessionId,
      ),
    );
  }

  void onTapTextField() {
    // if (_isChatLimited) {
    //   Get.toNamed(ColiveRoutes.vip);
    //   return;
    // } else {
    //   editingNode.requestFocus();
    // }
    editingNode.requestFocus();
  }

  void onTapSend() async {
    final message = editingController.text;
    if (message.isEmpty) return;

    if (_isChatLimited) {
      Get.toNamed(ColiveRoutes.vip);
      return;
    }

    if (state.blockModelObs.value.isToBlock) {
      ColiveLoadingUtil.showToast('colive_to_block_tips'.tr);
      return;
    }
    if (state.blockModelObs.value.isBeBlock) {
      ColiveLoadingUtil.showToast('colive_be_block_tips'.tr);
      return;
    }

    editingController.clear();

    if (state.isCustomerService.value) {
      ColiveChatManager.instance.sendTextMessage(
        sessionId: state.sessionId,
        text: message,
      );
      return;
    }

    try {
      ColiveLoadingUtil.show();
      final isFilter =
          await _verifyMessage(ColiveChatMessageType.text, message);
      if (isFilter) {
        await ColiveChatManager.instance.sendTextMessage(
          sessionId: state.sessionId,
          text: message,
        );
      } else {
        // await ColiveChatManager.instance.saveTextMessage(
        //   sessionId: state.sessionId,
        //   text: message,
        // );
        await ColiveChatManager.instance.sendTextMessage(
          sessionId: state.sessionId,
          text: '****',
        );
      }
      ColiveLoadingUtil.dismiss();
    } catch (e) {
      ColiveLoadingUtil.dismiss();
      ColiveLogUtil.e('ChatContent', e.toString());
    }
  }

  void onTapResend(ColiveChatMessageModel messageModel) {
    if (state.blockModelObs.value.isToBlock) {
      ColiveLoadingUtil.showToast('colive_to_block_tips'.tr);
      return;
    }
    if (state.blockModelObs.value.isBeBlock) {
      ColiveLoadingUtil.showToast('colive_be_block_tips'.tr);
      return;
    }
    ColiveChatManager.instance.resendMessage(messageModel);
  }

  void onTapImage() async {
    onCloseKeyboard();

    final status = await Permission.photos.request();
    if (status.isPermanentlyDenied) {
      await Get.dialog(
        const ColivePermissionDialog(
          permissionList: [Permission.photos],
        ),
      );
      return;
    }

    if (_isChatLimited) {
      Get.toNamed(ColiveRoutes.vip);
      return;
    }

    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    if (state.isCustomerService.value) {
      final imagePath = image.path;
      final fileSize = await image.length();
      await ColiveChatManager.instance.sendImageMessage(
        sessionId: state.sessionId,
        filePath: imagePath,
        fileSize: fileSize,
      );
      return;
    }

    if (state.blockModelObs.value.isToBlock) {
      ColiveLoadingUtil.showToast('colive_to_block_tips'.tr);
      return;
    }
    if (state.blockModelObs.value.isBeBlock) {
      ColiveLoadingUtil.showToast('colive_be_block_tips'.tr);
      return;
    }

    try {
      ColiveLoadingUtil.show();
      final imagePath = image.path;
      final fileSize = await image.length();
      List<int> imageBytes = await image.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      final content = 'data:image/jpg;base64,$base64Image';
      final isFilter =
          await _verifyMessage(ColiveChatMessageType.image, content);
      if (isFilter) {
        await ColiveChatManager.instance.sendImageMessage(
          sessionId: state.sessionId,
          filePath: imagePath,
          fileSize: fileSize,
        );
      } else {
        // await ColiveChatManager.instance.saveImageMessage(
        //   sessionId: state.sessionId,
        //   filePath: imagePath,
        //   fileSize: fileSize,
        // );
        await ColiveChatManager.instance.sendTextMessage(
          sessionId: state.sessionId,
          text: '****',
        );
      }
      ColiveLoadingUtil.dismiss();
    } catch (e) {
      ColiveLoadingUtil.dismiss();
      ColiveLogUtil.e('ChatContent', e.toString());
    }
  }

  void onTapCall() {
    onCloseKeyboard();

    if (state.anchorInfoObs.value != null) {
      ColiveCallInvitationManager.instance
          .sendCallInvitation(anchor: state.anchorInfoObs.value!);
    }
  }

  void onTapSendEmoji(Map<String, dynamic> emoji) async {
    if (emoji.keys.isEmpty || emoji.values.isEmpty) {
      return;
    }
    if (state.blockModelObs.value.isToBlock) {
      ColiveLoadingUtil.showToast('colive_to_block_tips'.tr);
      return;
    }
    if (state.blockModelObs.value.isBeBlock) {
      ColiveLoadingUtil.showToast('colive_be_block_tips'.tr);
      return;
    }

    if (_isChatLimited) {
      Get.toNamed(ColiveRoutes.vip);
      return;
    }

    if (state.isCustomerService.value) {
      await ColiveChatManager.instance.sendEmojiMessage(
        sessionId: state.sessionId,
        emojiMap: emoji,
      );
      return;
    }

    ColiveLoadingUtil.show();
    await _verifyMessage(ColiveChatMessageType.emoji, '');
    await ColiveChatManager.instance.sendEmojiMessage(
      sessionId: state.sessionId,
      emojiMap: emoji,
    );
    // final isFilter = await _verifyMessage(ColiveChatMessageType.emoji, '');
    // if (isFilter) {
    //   await ColiveChatManager.instance.sendEmojiMessage(
    //     sessionId: state.sessionId,
    //     emojiMap: emoji,
    //   );
    // } else {
    //   await ColiveChatManager.instance.saveEmojiMessage(
    //     sessionId: state.sessionId,
    //     emojiMap: emoji,
    //   );
    // }
    ColiveLoadingUtil.dismiss();
  }
}
