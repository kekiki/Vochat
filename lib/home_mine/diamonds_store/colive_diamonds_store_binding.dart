import 'package:get/get.dart';

import 'colive_diamonds_store_controller.dart';

class ColiveDiamondsStoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveDiamondsStoreController());
  }
}
