import 'package:get/get.dart';
import 'package:colive/services/managers/colive_analytics_manager.dart';
import 'package:colive/services/repositories/colive_anchor_repository.dart';
import 'package:colive/services/widgets/colive_base_controller.dart';
import '../../services/routes/colive_routes.dart';
import '../../services/widgets/dialogs/colive_dialog_util.dart';
import '../../services/widgets/dialogs/report/colive_report_dialog.dart';
import 'colive_call_finished_state.dart';

class ColiveCallFinishedController extends ColiveBaseController {
  final state = ColiveCallFinishedState();
  final _anchorRepository = Get.find<ColiveAnchorRepository>();

  @override
  void onInit() {
    final arguments = Get.arguments;
    state.callModel = arguments['call_model'];
    state.callType = arguments['call_type'];
    state.settlementModel = arguments['settlement_model'];
    state.anchorInfoObs.value = state.anchorInfoObs.value.copyWith(
      id: state.callModel.anchorId,
      nickname: state.callModel.anchorNickname,
      avatar: state.callModel.anchorAvatar,
    );
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();

    ColiveAnalyticsManager.instance
        .logEvent(key: 'ConsumeDiamondVideo', value: {
      'consume_diamonds_count': state.settlementModel.diamonds,
    });

    final anchor = await _anchorRepository.fetchAnchorInfo(
      isRobot: false,
      anchorId: state.callModel.anchorId,
      ignoreCache: false,
      fetchVideos: false,
    );
    if (anchor != null) {
      state.anchorInfoObs.value = anchor;
    } else {
      final robotAnchor = await _anchorRepository.fetchAnchorInfo(
        isRobot: true,
        anchorId: state.callModel.anchorId,
        ignoreCache: false,
        fetchVideos: false,
      );
      if (robotAnchor != null) {
        state.anchorInfoObs.value = robotAnchor;
      }
    }
  }

  void onTapReport() {
    ColiveDialogUtil.showDialog(
      const ColiveReportDialog(),
      arguments: state.anchorInfoObs.value,
    );
  }

  Future<void> onTapFollow() async {
    final anchorInfo = await _anchorRepository.requestFollow(
        anchor: state.anchorInfoObs.value);
    if (anchorInfo != null) {
      state.anchorInfoObs.value = anchorInfo;
    }
  }

  void onTapDone() {
    Get.until((route) => route.settings.name != ColiveRoutes.callFinished);
  }
}
