import 'dart:async';

import 'package:get/get.dart';

import '../api/colive_api_client.dart';
import '../database/colive_database.dart';

class ColiveBaseController extends GetxController {
  final apiClient = Get.find<ColiveApiClient>();
  final database = Get.find<ColiveDatabase>();

  final List<StreamSubscription> subsriptions = [];

  @override
  void onInit() async {
    super.onInit();
    setupListener();
  }

  @override
  void onClose() {
    for (var stream in subsriptions) {
      stream.cancel();
    }
    subsriptions.clear();
    super.onClose();
  }

  void setupListener() {
    // Subclass implementation
  }
}
