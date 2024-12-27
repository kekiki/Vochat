import 'package:get/get.dart';

import '../../services/models/colive_card_base_model.dart';

class ColiveMyCardsState {
  final dataListObs = <ColiveCardItemModel>[].obs;
  final isLoadFailedObs = false.obs;
  final isNoDataObs = false.obs;
}
