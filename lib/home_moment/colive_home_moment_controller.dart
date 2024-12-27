import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/services/routes/colive_routes.dart';
import 'package:colive/services/widgets/colive_base_controller.dart';
import 'colive_home_moment_state.dart';

class ColiveHomeMomentController extends ColiveBaseController
    with GetSingleTickerProviderStateMixin {
  final state = ColiveHomeMomentState();
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_tabChanged);
  }

  @override
  void onClose() {
    tabController.removeListener(_tabChanged);
    tabController.dispose();
    super.onClose();
  }

  void _tabChanged() {
    state.isMineTabObs.value = tabController.index == 1;
  }

  void onTapPost() {
    Get.toNamed(ColiveRoutes.postMoment);
  }
}
