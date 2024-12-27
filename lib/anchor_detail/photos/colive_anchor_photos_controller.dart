import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/services/widgets/colive_base_controller.dart';

import '../../services/managers/colive_profile_manager.dart';
import '../../services/routes/colive_routes.dart';
import 'colive_anchor_photos_state.dart';

class ColiveAnchorPhotosController extends ColiveBaseController {
  final state = ColiveAnchorPhotosState();
  late PageController pageController;

  @override
  void onInit() {
    final arguments = Get.arguments as Map<String, dynamic>;
    final int index = arguments['index'];
    pageController = PageController(initialPage: index);
    state.photoList = arguments['list'];
    state.indexObs.value = min(max(0, index), state.photoList.length);
    state.profileObs.value = ColiveProfileManager.instance.userInfo;
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

  @override
  void setupListener() {
    subsriptions
        .add(ColiveProfileManager.instance.profileStream.listen((user) {
      state.profileObs.value = user;
    }));
  }

  void onPageChanged(int index) {
    state.indexObs.value = index;
  }

  void onTapBecomeVIP() {
    Get.toNamed(ColiveRoutes.vip);
  }
}
