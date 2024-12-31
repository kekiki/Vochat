import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'vochat_media_state.dart';

class VochatMediaController extends GetxController {
  final state = VochatMediaState();
  final pageController = PageController();

  @override
  void onInit() {
    final arguments = Get.arguments as Map<String, dynamic>;
    final int index = arguments['index'];
    state.mediaList = arguments['list'];
    state.indexObs.value = min(max(0, index), state.mediaList.length);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    final index = state.indexObs.value;
    pageController.jumpToPage(index);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int index) {
    state.indexObs.value = index;
  }
}
