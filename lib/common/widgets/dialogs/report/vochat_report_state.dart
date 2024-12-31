import 'package:get/get.dart';

import '../../../../services/models/vochat_anchor_model.dart';

class VochatReportState {
  late VochatAnchorModel anchorInfo;
  final selectedIndex = 0.obs;

  final dataList = [
    'vochat_religious_belief'.tr,
    'vochat_internet_violence'.tr,
    'vochat_minor'.tr,
    'vochat_fraud'.tr,
    'vochat_vulgar'.tr,
  ];
}
