import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/services/widgets/colive_refresh_footer.dart';
import '../../common/utils/colive_format_util.dart';
import '../../common/widgets/colive_round_image_widget.dart';
import '../../services/models/colive_system_message_model.dart';
import '../../services/static/colive_colors.dart';
import '../../services/static/colive_styles.dart';
import '../../services/widgets/colive_app_bar.dart';
import '../../services/widgets/colive_app_scaffold.dart';
import '../../services/widgets/colive_empty_widget.dart';
import '../../services/widgets/colive_refresh_header.dart';
import 'colive_system_message_controller.dart';

class ColiveSystemMessagePage
    extends GetView<ColiveSystemMessageController> {
  const ColiveSystemMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ColiveSystemMessageController());
    return ColiveAppScaffold(
      appBar: ColiveAppBar(
        center: Text(
          'colive_system_message'.tr,
          style: ColiveStyles.title18w700,
        ),
      ),
      body: EasyRefresh.builder(
        controller: controller.refreshController,
        refreshOnStart: true,
        header: ColiveRefreshHeader.classic(),
        footer: ColiveRefreshFooter.classic(),
        onRefresh: controller.onRefresh,
        onLoad: controller.onLoadMore,
        childBuilder: (context, physics) {
          return Obx(() {
            final messageList = List<ColiveSystemMessageModel>.from(
                controller.messageListObs);
            return CustomScrollView(
              physics: physics,
              slivers: [
                SliverToBoxAdapter(
                  child: Visibility(
                    visible: controller.isLoadFailedObs.value,
                    child: ColiveEmptyWidget(text: 'colive_no_network'.tr),
                  ),
                ),
                SliverList.builder(
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    final model = messageList[index];
                    return _listItemWidget(model);
                  },
                ),
              ],
            );
          });
        },
      ),
    );
  }

  Widget _listItemWidget(ColiveSystemMessageModel model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 14.pt),
        Text(
          ColiveFormatUtil.millisecondsToTime(model.createTime * 1000),
          style: ColiveStyles.body12w400.copyWith(
            color: ColiveColors.primaryTextColor.withOpacity(0.6),
            height: 1.4,
          ),
        ),
        SizedBox(height: 4.pt),
        GestureDetector(
          onTap: () => controller.onTapMessage(model),
          child: Container(
            width: 345.pt,
            padding: EdgeInsets.all(15.pt),
            decoration: BoxDecoration(
              color: ColiveColors.cardColor,
              borderRadius: BorderRadius.circular(12.pt),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title.trim(),
                  style: ColiveStyles.title14w600,
                ),
                SizedBox(height: 12.pt),
                Text(
                  model.content.trim(),
                  style: ColiveStyles.body14w400.copyWith(
                    color: ColiveColors.grayTextColor,
                  ),
                ),
                model.images.isEmpty
                    ? const SizedBox.shrink()
                    : GestureDetector(
                        onTap: () => controller.onTapImage(model),
                        child: Container(
                          margin: EdgeInsets.only(top: 12.pt),
                          constraints: BoxConstraints(maxWidth: 315.pt),
                          child: ColiveRoundImageWidget(
                            model.images,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
