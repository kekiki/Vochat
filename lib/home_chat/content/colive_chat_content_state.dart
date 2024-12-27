import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/services/managers/colive_profile_manager.dart';
import 'package:colive/services/models/colive_anchor_model.dart';

import '../../services/models/colive_chat_block_model.dart';
import '../../services/models/colive_chat_message_model.dart';

enum ColiveChatInputType { none, keyboard, gift, emoji }

class ColiveChatContentState {
  late String sessionId;
  late int anchorId;

  List<Map<String, dynamic>> emojiList = [];
  Offset tapDownPosition = Offset.zero;
  bool isMessageNoMore = false;

  final isCustomerService = false.obs;
  final isMessageLoading = false.obs;
  final inputTypeObs = ColiveChatInputType.none.obs;
  final enableSendObs = false.obs;
  final messageList = RxList<ColiveChatMessageModel>();
  final anchorInfoObs = Rxn<ColiveAnchorModel>();
  final profileObs = ColiveProfileManager.instance.userInfo.obs;
  // final giftModelObs = ColiveGiftManager.instance.giftBaseModel.obs;
  final blockModelObs = ColiveChatBlockModel.fromJson({}).obs;
  final showVipBannerObs = true.obs;
}
