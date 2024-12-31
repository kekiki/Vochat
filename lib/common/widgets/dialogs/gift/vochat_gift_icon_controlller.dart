import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class VochatGiftIconController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> iconAnimation;

  @override
  void onInit() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);

    iconAnimation = Tween(begin: 1.0, end: 1.3).animate(animationController);
    iconAnimation = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 1.3)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 50),
    ]).animate(animationController);
    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void showAnimation() {
    if (iconAnimation.status == AnimationStatus.forward ||
        iconAnimation.status == AnimationStatus.reverse) {
      return;
    }
    if (iconAnimation.status == AnimationStatus.dismissed) {
      animationController.forward();
    } else if (iconAnimation.status == AnimationStatus.completed) {
      animationController.reverse();
    }
  }
}
