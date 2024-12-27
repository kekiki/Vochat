import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';

// class ColiveRefreshFooter extends TaurusFooter {
//   const ColiveRefreshFooter({
//     super.key,
//     super.triggerOffset = 88,
//     super.skyColor = const Color(0xFFB3E5FC),
//   });
// }

class ColiveRefreshFooter extends ClassicFooter {
  const ColiveRefreshFooter({
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

  factory ColiveRefreshFooter.classic() => ColiveRefreshFooter(
        dragText: 'colive_pull_load'.tr,
        armedText: 'colive_release_ready'.tr,
        readyText: 'colive_loading'.tr,
        processingText: 'colive_loading'.tr,
        processedText: 'colive_succeeded'.tr,
        noMoreText: 'colive_no_more_text'.tr,
        failedText: 'colive_failed'.tr,
      );
}
