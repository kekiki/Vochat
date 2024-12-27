import 'package:get/get.dart';
import 'package:colive/services/models/colive_anchor_model.dart';

import '../../services/managers/colive_call_invitation_manager.dart';
import '../../services/models/colive_call_model.dart';
import '../../services/models/colive_call_settlement_model.dart';

class ColiveCallFinishedState {
  late ColiveCallModel callModel;
  late ColiveCallType callType;
  late ColiveCallSettlementModel settlementModel;

  final anchorInfoObs = ColiveAnchorModel.fromJson({}).obs;
  double ratingScore = 0.0;
}
