import 'package:get/get.dart';

import '../services/models/colive_anchor_model.dart';

enum ColiveSearchStatus { init, list, empty, failed }

class ColiveSearchState {
  final statusObs = ColiveSearchStatus.init.obs;
  final historyListObs = <String>[].obs;
  final anchorListObs = <ColiveAnchorModel>[].obs;
}
