import 'package:get/get.dart';

import '../../services/models/colive_turntable_model.dart';

class ColiveLuckyDrawState {
  final rewardListObs = [
    ColiveTurntableRewardModel.empty(),
    ColiveTurntableRewardModel.empty(),
    ColiveTurntableRewardModel.empty(),
    ColiveTurntableRewardModel.empty(),
    ColiveTurntableRewardModel.empty(),
    ColiveTurntableRewardModel.empty(),
  ].obs;
  final remainTimesObs = 0.obs;

  /// 是否正在抽奖
  bool isDrawing = false;

  /// 抽中的结果
  ColiveTurntableRewardModel? rewardResult;
}
