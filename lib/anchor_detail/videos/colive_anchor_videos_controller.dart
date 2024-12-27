import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colive_anchor_videos_state.dart';

class ColiveAnchorVideosController extends GetxController {
  final state = ColiveAnchorVideosState();
  final pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    final int index = arguments['index'];
    state.videoList = arguments['list'];
    state.indexObs.value = min(max(0, index), state.videoList.length);
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
