import 'package:get/get.dart';

enum VochatBottomTabType {
  home,
  community,
  message,
  me,
}

class VochatBottomTabState {
  final selectedTabTypeObs = VochatBottomTabType.home.obs;
  final unReadMessageCountObs = 0.obs;
}
