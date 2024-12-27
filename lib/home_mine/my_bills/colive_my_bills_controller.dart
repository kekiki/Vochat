import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colive_my_bills_state.dart';

class ColiveMyBillsController extends GetxController {
  final state = ColiveMyBillsState();

  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }
}
