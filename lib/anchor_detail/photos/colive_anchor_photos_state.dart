import 'package:get/get.dart';

import '../../services/models/colive_anchor_model.dart';
import '../../services/models/colive_login_model.dart';

class ColiveAnchorPhotosState {
  List<ColiveAnchorModelAlbum> photoList = [];
  final indexObs = 0.obs;
  final profileObs = ColiveLoginModelUser.fromJson({}).obs;
}
