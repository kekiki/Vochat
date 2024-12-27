import 'package:get/get.dart';

import 'colive_my_cards_controller.dart';

class ColiveMyCardsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColiveMyCardsController());
  }
}
