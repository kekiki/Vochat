import 'dart:io';

import 'package:get/get.dart';
import 'package:vochat/common/logger/vochat_log_util.dart';
import 'package:vochat/services/managers/vochat_download_manager.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

import '../../../../services/models/vochat_gift_base_model.dart';
import 'vochat_gift_item_animate_widget.dart';

class VochatGiftAnimateController extends GetxController
    with GetTickerProviderStateMixin {
  final giftList = <VochatGiftItemModel>[];
  final VochatGiftItemAnimateWidget topWidget =
      const VochatGiftItemAnimateWidget('top');
  final VochatGiftItemAnimateWidget bottomWidget =
      const VochatGiftItemAnimateWidget('bottom');

  late SVGAAnimationController animateController;
  final List<VochatGiftItemModel> animateGiftList = [];
  final isVisibleAnimate = false.obs;

  @override
  void onInit() {
    animateController = SVGAAnimationController(vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    animateController.dispose();
    super.onClose();
  }

  void addGift(VochatGiftItemModel newGift) {
    giftList.add(newGift);
    _startAnimation(newGift);

    animateGiftList.add(newGift);
    _startBigAnimation(newGift);
  }

  void _startAnimation(VochatGiftItemModel newGift) async {
    if (giftList.isEmpty) return;

    if (bottomWidget.controller.isAnimating.value &&
        bottomWidget.controller.gift.value.id == newGift.id) {
      bottomWidget.controller.addGift(newGift, (gift, next) {
        giftList.remove(gift);
        if (next && giftList.isNotEmpty) {
          _startAnimation(giftList[0]);
        }
      });
      return;
    }

    if (topWidget.controller.isAnimating.value &&
        topWidget.controller.gift.value.id == newGift.id) {
      topWidget.controller.addGift(newGift, (gift, next) {
        giftList.remove(gift);
        if (next && giftList.isNotEmpty) {
          _startAnimation(giftList[0]);
        }
      });
      return;
    }

    if (!bottomWidget.controller.isAnimating.value) {
      bottomWidget.controller.addGift(newGift, (gift, next) {
        giftList.remove(gift);
        if (next && giftList.isNotEmpty) {
          _startAnimation(giftList[0]);
        }
      });
      return;
    }

    if (!topWidget.controller.isAnimating.value) {
      topWidget.controller.addGift(newGift, (gift, next) {
        giftList.remove(gift);
        if (next && giftList.isNotEmpty) {
          _startAnimation(giftList[0]);
        }
      });
      return;
    }
  }

  void _startBigAnimation(VochatGiftItemModel newGift) async {
    if (animateGiftList.isEmpty || isVisibleAnimate.value) return;
    isVisibleAnimate.value = true;
    try {
      if (await VochatDownloadManager.instance
          .isDownloaded(newGift.cartoonUrl)) {
        final path = VochatDownloadManager.instance
            .downloadPathWithUrl(newGift.cartoonUrl);
        final bytes = await File(path).readAsBytes();
        var videoItem = await SVGAParser.shared.decodeFromBuffer(bytes);
        animateController.videoItem = videoItem;
      } else {
        var videoItem =
            await SVGAParser.shared.decodeFromURL(newGift.cartoonUrl);
        animateController.videoItem = videoItem;
      }

      animateController.forward().whenCompleteOrCancel(() {
        animateController.videoItem = null;
        isVisibleAnimate.value = false;
        if (animateGiftList.isNotEmpty) {
          animateGiftList.removeAt(0);
        }
        if (animateGiftList.isNotEmpty) {
          _startBigAnimation(animateGiftList.first);
        }
      });
    } catch (e) {
      VochatLogUtil.e('GiftAnimate', e.toString());
      animateController.videoItem = null;
      isVisibleAnimate.value = false;
      if (animateGiftList.isNotEmpty) {
        animateGiftList.removeAt(0);
      }
      if (animateGiftList.isNotEmpty) {
        _startBigAnimation(animateGiftList.first);
      }
    }
  }
}
