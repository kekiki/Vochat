import 'package:get/get.dart';

import '../../services/managers/colive_call_invitation_manager.dart';
import '../../services/models/colive_call_model.dart';

class ColiveCallWaitingState {
  late ColiveCallModel callModel;
  late ColiveCallType callType;

  static const int connectSeconds = 30;
  final isAIBConnecting = false.obs;
}
