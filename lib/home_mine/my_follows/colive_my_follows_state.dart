import 'package:get/get.dart';

enum ColiveMyFollowsType {
  following,
  follower,
  blacklist,
  itemCount,
}

class ColiveMyFollowsState {
  final currentTypeObs = ColiveMyFollowsType.following.obs;
}
