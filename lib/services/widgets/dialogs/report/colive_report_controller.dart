import 'dart:convert';

import 'package:get/get.dart';
import 'package:colive/common/utils/colive_loading_util.dart';
import 'package:colive/services/extensions/colive_api_response_ext.dart';
import 'package:colive/services/widgets/colive_base_controller.dart';

import 'colive_report_state.dart';

class ColiveReportController extends ColiveBaseController {
  final state = ColiveReportState();

  @override
  void onInit() {
    state.anchorInfo = Get.arguments;
    super.onInit();
  }

  Future<void> onTapConfirm() async {
    ColiveLoadingUtil.show();
    final content = state.dataList[state.selectedIndex.value];
    final images = jsonEncode([]);
    final result = await apiClient.feedback(content, images).response;
    ColiveLoadingUtil.dismiss();
    if (result.isSuccess) {
      ColiveLoadingUtil.showToast('colive_report_success'.tr);
      Get.back(result: false);
    } else {
      ColiveLoadingUtil.showToast(result.msg);
    }
  }
}
