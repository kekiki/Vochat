import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/services/extensions/colive_widget_ext.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../common/widgets/colive_round_image_widget.dart';
import '../../generated/assets.dart';
import '../../services/models/colive_anchor_model.dart';
import '../../services/static/colive_colors.dart';
import '../../services/static/colive_styles.dart';
import 'colive_anchor_photos_controller.dart';
import 'colive_anchor_photos_state.dart';

class ColiveAnchorPhotosPage extends GetView<ColiveAnchorPhotosController> {
  const ColiveAnchorPhotosPage({super.key});

  ColiveAnchorPhotosState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: Get.back,
          icon: Container(
            width: 28.pt,
            height: 28.pt,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: rgba(0, 0, 0, 0.5),
              borderRadius: BorderRadius.circular(14.pt),
            ),
            child: Image.asset(
              Assets.imagesColiveAppbarBack,
              width: 24.pt,
              height: 24.pt,
              color: Colors.white,
            ).rtl,
          ),
        ),
        centerTitle: true,
        title: Obx(() {
          return Visibility(
            visible: state.photoList.length > 1,
            child: Text(
              '${state.indexObs.value + 1}/${state.photoList.length}',
              style: ColiveStyles.title18w700.copyWith(
                color: Colors.white,
              ),
            ),
          );
        }),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        color: Colors.black,
        child: PhotoViewGallery.builder(
          pageController: controller.pageController,
          itemCount: state.photoList.length,
          onPageChanged: controller.onPageChanged,
          loadingBuilder: (context, event) {
            return Center(
              child: SizedBox(
                width: 50.pt,
                height: 50.pt,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  value: event == null || event.expectedTotalBytes == null
                      ? 0
                      : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                ),
              ),
            );
          },
          builder: (context, index) {
            final photo = state.photoList[index];
            return PhotoViewGalleryPageOptions.customChild(
              child: _photoItemWidget(photo),
              heroAttributes: PhotoViewHeroAttributes(tag: index.toString()),
              initialScale: PhotoViewComputedScale.contained,
              minScale: PhotoViewComputedScale.contained * 1.0,
              maxScale: PhotoViewComputedScale.contained * 2.0,
            );
          },
        ),
      ),
    );
  }

  Widget _photoItemWidget(ColiveAnchorModelAlbum photo) {
    return Obx(() {
      final isUserVip = state.profileObs.value.isVIP;
      final isNeedVip = photo.isVip == 1;
      final showVIP = isNeedVip && !isUserVip;
      return Stack(
        children: [
          ColiveRoundImageWidget(
            photo.images,
            width: ColiveScreenAdapt.screenWidth,
            height: ColiveScreenAdapt.screenHeight,
            isLocalImage: !photo.images.isURL,
            fit: BoxFit.contain,
            placeholderWidget: Center(
              child: SizedBox(
                width: 50.pt,
                height: 50.pt,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Visibility(
              visible: showVIP,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Center(
                  child: Image.asset(
                    Assets.imagesColiveVipMedia,
                    width: 60.pt,
                    height: 60.pt,
                  ),
                ),
              ),
            ),
          ),
          PositionedDirectional(
            start: 0,
            bottom: 0,
            end: 0,
            child: Visibility(
              visible: showVIP,
              child: SafeArea(
                child: InkWell(
                  onTap: controller.onTapBecomeVIP,
                  child: Container(
                    height: 52.pt,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                        vertical: 24.pt, horizontal: 30.pt),
                    decoration: BoxDecoration(
                      gradient: ColiveColors.mainGradient,
                      borderRadius: BorderRadius.circular(26.pt),
                    ),
                    child: Text(
                      'Become VIP',
                      style: ColiveStyles.title16w600.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
