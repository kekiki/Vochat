import 'package:get/get.dart';

enum ColiveHomeTabType {
  anchors,
  moment,
  chat,
  mine,
}

class ColiveHomeState {
  final selectedTabTypeObs = ColiveHomeTabType.anchors.obs;
  final unReadMessageCountObs = 0.obs;
}
