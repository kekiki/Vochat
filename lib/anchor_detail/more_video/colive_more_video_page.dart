import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';

import '../../services/models/colive_anchor_model.dart';
import '../../services/static/colive_styles.dart';
import '../../services/widgets/colive_app_bar.dart';
import '../../services/widgets/colive_app_scaffold.dart';
import '../../services/widgets/colive_refresh_footer.dart';
import '../../services/widgets/colive_refresh_header.dart';
import '../widgets/colive_anchor_video_cover.dart';
import 'colive_more_video_controller.dart';

class ColiveMoreVideoPage extends GetView<ColiveMoreVideoController> {
  const ColiveMoreVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ColiveMoreVideoController());
    return ColiveAppScaffold(
      safeBottom: false,
      appBar: ColiveAppBar(
        center: Text(
          "colive_video".tr,
          style: ColiveStyles.title18w700,
        ),
      ),
      body: EasyRefresh.builder(
        controller: controller.refreshController,
        header: ColiveRefreshHeader.classic(),
        footer: ColiveRefreshFooter.classic(),
        onRefresh: controller.onRefresh,
        onLoad: controller.onLoadMore,
        childBuilder: (context, physics) {
          return Obx(() {
            final List<ColiveAnchorModelVideo> videoList =
                List.from(controller.videoListObs);
            return GridView.builder(
              physics: physics,
              padding: EdgeInsets.all(15.pt),
              itemCount: videoList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15.pt,
                crossAxisSpacing: 9.pt,
                childAspectRatio: 168 / 200,
              ),
              itemBuilder: (context, index) {
                final video = videoList[index];
                return ColiveAnchorVideoCover(
                  videoModel: video,
                  profile: controller.profileObs.value,
                  onTap: controller.onTapVideo,
                  width: 90.pt,
                  height: 120.pt,
                  borderRadius: BorderRadius.circular(8.pt),
                );
              },
            );
          });
        },
      ),
    );
  }
}
