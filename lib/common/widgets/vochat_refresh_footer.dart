import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';

// class VochatRefreshFooter extends TaurusFooter {
//   const VochatRefreshFooter({
//     super.key,
//     super.triggerOffset = 88,
//     super.skyColor = const Color(0xFFB3E5FC),
//   });
// }

class VochatRefreshFooter extends ClassicFooter {
  const VochatRefreshFooter({
    super.key,
    super.triggerOffset = 44,
    super.clamping = false,
    super.position,
    super.processedDuration = Duration.zero,
    super.spring,
    super.readySpringBuilder,
    super.springRebound,
    super.frictionFactor,
    super.safeArea,
    super.infiniteOffset = 44,
    super.hitOver,
    super.infiniteHitOver,
    super.hapticFeedback,
    super.triggerWhenReach,
    super.triggerWhenRelease,
    super.maxOverOffset,
    super.showMessage = false,
    super.dragText,
    super.armedText,
    super.readyText,
    super.noMoreText,
    super.processingText,
    super.processedText,
    super.failedText,
  });

  factory VochatRefreshFooter.classic() => VochatRefreshFooter(
        dragText: 'vochat_pull_load'.tr,
        armedText: 'vochat_release_ready'.tr,
        readyText: 'vochat_loading'.tr,
        processingText: 'vochat_loading'.tr,
        processedText: 'vochat_succeeded'.tr,
        noMoreText: 'vochat_no_more_text'.tr,
        failedText: 'vochat_failed'.tr,
      );
}
