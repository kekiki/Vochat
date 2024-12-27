import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';

import '../services/models/colive_anchor_model.dart';
import '../services/models/colive_login_model.dart';
import '../services/models/colive_moment_item_model.dart';

class ColiveAnchorDetailState {
  final headerVisibleExtent = 431.pt;
  final appBarAlphaObs = 0.0.obs;

  final anchorInfoObs = ColiveAnchorModel.fromJson({}).obs;
  final currentImageIndexObs = 0.obs;

  final momentListObs = <ColiveMomentItemModel>[].obs;
  final profileObs = ColiveLoginModelUser.fromJson({}).obs;

  final albumListObs = <ColiveAnchorModelAlbum>[].obs;
  final haveFreeCallCard = false.obs;
}
