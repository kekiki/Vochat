import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colive_my_follows_state.dart';

class ColiveMyFollowsController extends GetxController {
  final state = ColiveMyFollowsState();

  late PageController pageController;

  @override
  void onInit() {
    state.currentTypeObs.value = Get.arguments;
    pageController =
        PageController(initialPage: state.currentTypeObs.value.index);
    super.onInit();
  }
}
