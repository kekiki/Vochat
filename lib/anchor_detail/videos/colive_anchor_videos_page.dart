import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/extensions/colive_widget_ext.dart';

import '../../services/static/colive_colors.dart';
import '../../services/static/colive_styles.dart';
import 'colive_anchor_video_play_widget.dart';
import 'colive_anchor_videos_controller.dart';

class ColiveAnchorVideosPage extends GetView<ColiveAnchorVideosController> {
  const ColiveAnchorVideosPage({super.key});

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
            visible: state.videoList.length > 1,
            child: Text(
              '${state.indexObs.value + 1}/${state.videoList.length}',
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
        child: PageView.builder(
          controller: controller.pageController,
          itemCount: state.videoList.length,
          onPageChanged: controller.onPageChanged,
          itemBuilder: (context, index) {
            final video = state.videoList[index];
            return ColiveAnchorVideoPlayWidget(videoModel: video);
          },
        ),
      ),
    );
  }
}
