import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vochat/common/adapts/vochat_screen_adapt.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:vochat/common/extensions/vochat_widget_ext.dart';

import '../../adapts/vochat_colors.dart';
import '../../adapts/vochat_styles.dart';
import '../../generated/assets.dart';
import 'vochat_media_controller.dart';

import 'widgets/vochat_photo_widget.dart';
import 'widgets/vochat_video_widget.dart';

class VochatMediaPage extends GetView<VochatMediaController> {
  const VochatMediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = controller.state;
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
              Assets.imagesVochatAppbarBack,
              width: 24.pt,
              height: 24.pt,
              color: Colors.white,
            ).rtl,
          ),
        ),
        centerTitle: true,
        title: Obx(() {
          return Visibility(
            visible: state.mediaList.length > 1,
            child: Text(
              '${state.indexObs.value + 1}/${state.mediaList.length}',
              style: VochatStyles.title18w700.copyWith(
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
          itemCount: state.mediaList.length,
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
            final media = state.mediaList[index];
            if (media.isVideo) {
              return PhotoViewGalleryPageOptions.customChild(
                child: VochatVideoWidget(videoUri: media.path),
                heroAttributes: PhotoViewHeroAttributes(tag: index.toString()),
                disableGestures: true,
              );
            }

            return PhotoViewGalleryPageOptions.customChild(
              child: VochatPhotoWidget(photoUri: media.path),
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
}
