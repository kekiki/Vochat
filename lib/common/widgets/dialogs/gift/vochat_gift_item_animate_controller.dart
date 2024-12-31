import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:vochat/services/models/vochat_gift_base_model.dart';

class VochatGiftItemAnimateController extends GetxController
    with GetTickerProviderStateMixin {
  final Rx<VochatGiftItemModel> gift = VochatGiftItemModel.fromJson({}).obs;
  final RxBool isAnimating = false.obs;
  final RxInt giftNum = 1.obs;
  final RxDouble offset = 0.0.obs;

  late AnimationController openController;
  late CurvedAnimation openCurved;
  late Animation<double> openAnimation;
  Timer? _closeTimer;

  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  @override
  void onInit() {
    openController = AnimationController(
      value: 1,
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    openCurved = CurvedAnimation(parent: openController, curve: Curves.linear);
    openAnimation = Tween(begin: 0.0, end: 1.0).animate(openController);
    openAnimation.addListener(_openAnimationListener);

    scaleController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);

    scaleAnimation = Tween(begin: 1.0, end: 1.3).animate(scaleController);
    scaleAnimation = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 1.3)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 50),
    ]).animate(scaleController);

    super.onInit();
  }

  @override
  void onClose() {
    openAnimation.removeListener(_openAnimationListener);
    openController.dispose();
    scaleController.dispose();
    super.onClose();
  }

  void _openAnimationListener() {
    offset.value = openCurved.value;
  }

  void addGift(VochatGiftItemModel newGift,
      Function(VochatGiftItemModel, bool) completion) {
    if (isAnimating.value && gift.value.id == newGift.id) {
      _closeTimer?.cancel();
      completion(gift.value, false);
      giftNum.value += 1;
      gift.value = newGift;
      _closeTimer = Timer(const Duration(seconds: 3), () {
        openController.forward().then((_) {
          isAnimating.value = false;
          completion(gift.value, true);
        });
      });
      showScaleAnimation();
      return;
    }
    if (!isAnimating.value) {
      completion(newGift, false);
      giftNum.value = 1;
      gift.value = newGift;
      isAnimating.value = true;
      openController.reverse().then((_) {
        _closeTimer?.cancel();
        _closeTimer = Timer(const Duration(seconds: 3), () {
          openController.forward().then((_) {
            isAnimating.value = false;
            completion(gift.value, true);
          });
        });
        showScaleAnimation();
      });
    }
  }

  void showScaleAnimation() {
    if (scaleAnimation.status == AnimationStatus.forward ||
        scaleAnimation.status == AnimationStatus.reverse) {
      return;
    }
    if (scaleAnimation.status == AnimationStatus.dismissed) {
      scaleController.forward();
    } else if (scaleAnimation.status == AnimationStatus.completed) {
      scaleController.reverse();
    }
  }
}
