import 'dart:async';

import 'package:get/get.dart';

import '../../common/api/vochat_api_client.dart';
import '../database/vochat_database.dart';

class VochatBaseController extends GetxController {
  final apiClient = Get.find<VochatApiClient>();
  final database = Get.find<VochatDatabase>();

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
