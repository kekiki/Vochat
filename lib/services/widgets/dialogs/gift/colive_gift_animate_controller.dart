import 'dart:io';

import 'package:get/get.dart';
import 'package:colive/common/logger/colive_log_util.dart';
import 'package:colive/services/managers/colive_download_manager.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

import '../../../models/colive_gift_base_model.dart';
import 'colive_gift_item_animate_widget.dart';

class ColiveGiftAnimateController extends GetxController
    with GetTickerProviderStateMixin {
  final giftList = <ColiveGiftItemModel>[];
  final ColiveGiftItemAnimateWidget topWidget =
      const ColiveGiftItemAnimateWidget('top');
  final ColiveGiftItemAnimateWidget bottomWidget =
      const ColiveGiftItemAnimateWidget('bottom');

  late SVGAAnimationController animateController;
  final List<ColiveGiftItemModel> animateGiftList = [];
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

  void addGift(ColiveGiftItemModel newGift) {
    giftList.add(newGift);
    _startAnimation(newGift);

    animateGiftList.add(newGift);
    _startBigAnimation(newGift);
  }

  void _startAnimation(ColiveGiftItemModel newGift) async {
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

  void _startBigAnimation(ColiveGiftItemModel newGift) async {
    if (animateGiftList.isEmpty || isVisibleAnimate.value) return;
    isVisibleAnimate.value = true;
    try {
      if (await ColiveDownloadManager.instance
          .isDownloaded(newGift.cartoonUrl)) {
        final path = ColiveDownloadManager.instance
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
      ColiveLogUtil.e('GiftAnimate', e.toString());
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
