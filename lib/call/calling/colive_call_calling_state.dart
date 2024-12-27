import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/services/managers/colive_profile_manager.dart';

import '../../services/managers/colive_call_invitation_manager.dart';
import '../../services/models/colive_call_model.dart';

class ColiveCallCallingState {
  late ColiveCallModel callModel;
  late ColiveCallType callType;

  final profileObs = ColiveProfileManager.instance.userInfo.obs;
  final callingDurationObs = '00:00'.obs;

  bool isUseFrontCamera = true;
  final isCameraEnableObs = true.obs;
  final isVoiceEnableObs = true.obs;
  final isSpeakerObs = true.obs;

  final isLocalSmallPreviewObs = true.obs;
  bool isLocalSmallPreview = true;
  bool isAIAPlayFinished = false;

  final smallScreenEnd = 15.pt.obs;
  final smallScreenTop = (82.pt + ColiveScreenAdapt.statusBarHeight).obs;
  final smallScreenWidth = 135.pt;
  final smallScreenHeight = 180.pt;
}
