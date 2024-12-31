import 'dart:convert';

import 'package:get/get.dart';
import 'package:vochat/common/extensions/vochat_api_response_ext.dart';
import 'package:vochat/common/utils/vochat_loading_util.dart';

import '../../vochat_base_controller.dart';
import 'vochat_report_state.dart';

class VochatReportController extends VochatBaseController {
  final state = VochatReportState();

  @override
  void onInit() {
    state.anchorInfo = Get.arguments;
    super.onInit();
  }

  Future<void> onTapConfirm() async {
    VochatLoadingUtil.show();
    final content = state.dataList[state.selectedIndex.value];
    final images = jsonEncode([]);
    final result = await apiClient.feedback(content, images).response;
    VochatLoadingUtil.dismiss();
    if (result.isSuccess) {
      VochatLoadingUtil.showToast('vochat_report_success'.tr);
      Get.back(result: false);
    } else {
      VochatLoadingUtil.showToast(result.msg);
    }
  }
}
