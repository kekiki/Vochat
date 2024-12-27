import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';

// class ColiveRefreshHeader extends TaurusHeader {

//   const ColiveRefreshHeader({
//     super.key,
//     super.triggerOffset = 88,
//     super.skyColor = const Color(0xFFB3E5FC),
//   });
// }

class ColiveRefreshHeader extends ClassicHeader {
  const ColiveRefreshHeader({
    super.key,
    super.triggerOffset = 44,
    super.clamping = false,
    super.position = IndicatorPosition.behind,
    super.processedDuration = const Duration(seconds: 1),
    super.spring,
    super.readySpringBuilder,
    super.springRebound = true,
    super.frictionFactor,
    super.safeArea = true,
    super.infiniteOffset,
    super.hitOver,
    super.infiniteHitOver,
    super.hapticFeedback = false,
    super.triggerWhenReach = false,
    super.triggerWhenRelease = false,
    super.maxOverOffset = double.infinity,
    super.showMessage = false,
    super.dragText,
    super.armedText,
    super.readyText,
    super.noMoreText,
    super.processingText,
    super.processedText,
    super.failedText,
  });

  factory ColiveRefreshHeader.classic() => ColiveRefreshHeader(
        dragText: 'colive_pull_refresh'.tr,
        armedText: 'colive_release_ready'.tr,
        readyText: 'colive_refreshing'.tr,
        processingText: 'colive_refreshing'.tr,
        processedText: 'colive_succeeded'.tr,
        noMoreText: 'colive_no_more_text'.tr,
        failedText: 'colive_failed'.tr,
      );
}
