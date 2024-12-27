import 'package:get/get.dart';

import '../../../models/colive_anchor_model.dart';

class ColiveReportState {
  late ColiveAnchorModel anchorInfo;
  final selectedIndex = 0.obs;

  final dataList = [
    'colive_religious_belief'.tr,
    'colive_internet_violence'.tr,
    'colive_minor'.tr,
    'colive_fraud'.tr,
    'colive_vulgar'.tr,
  ];
}
