import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';

// class VochatRefreshHeader extends TaurusHeader {

//   const VochatRefreshHeader({
//     super.key,
//     super.triggerOffset = 88,
//     super.skyColor = const Color(0xFFB3E5FC),
//   });
// }

class VochatRefreshHeader extends ClassicHeader {
  const VochatRefreshHeader({
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

  factory VochatRefreshHeader.classic() => VochatRefreshHeader(
        dragText: 'vochat_pull_refresh'.tr,
        armedText: 'vochat_release_ready'.tr,
        readyText: 'vochat_refreshing'.tr,
        processingText: 'vochat_refreshing'.tr,
        processedText: 'vochat_succeeded'.tr,
        noMoreText: 'vochat_no_more_text'.tr,
        failedText: 'vochat_failed'.tr,
      );
}
