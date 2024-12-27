import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import '../generated/assets.dart';
import '../services/models/colive_system_message_model.dart';
import '../services/static/colive_colors.dart';
import '../services/widgets/colive_app_bar.dart';
import '../services/widgets/colive_app_scaffold.dart';
import '../services/static/colive_styles.dart';
import '../services/widgets/colive_refresh_header.dart';
import 'colive_home_chat_controller.dart';
import 'colive_chat_conversation_item_widget.dart';
import 'colive_home_chat_state.dart';

class ColiveHomeChatPage extends GetView<ColiveHomeChatController> {
  const ColiveHomeChatPage({super.key});

  ColiveHomeChatState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    return ColiveAppScaffold(
      safeBottom: false,
      appBar: ColiveAppBar(
        isAllowBack: false,
        startSpacing: 15.pt,
        start: Text(
          "colive_chat".tr,
          style: ColiveStyles.title22w700,
        ),
        end: InkWell(
          onTap: controller.onTapMore,
          child: Container(
            width: 44.pt,
            height: 44.pt,
            alignment: Alignment.center,
            child: Image.asset(
              Assets.imagesColiveAppbarMore,
              width: 24.pt,
              height: 24.pt,
            ),
          ),
        ),
      ),
      body: EasyRefresh.builder(
        controller: controller.refreshController,
        header: ColiveRefreshHeader.classic(),
        onRefresh: controller.onRefresh,
        childBuilder: (context, physics) {
          return CustomScrollView(
            physics: physics,
            slivers: [
              SliverToBoxAdapter(child: _buildSystemMessageWidget()),
              Obx(() {
                return SliverList.separated(
                  itemBuilder: (context, index) {
                    final conversationModel = state.conversationList[index];
                    return InkWell(
                      onTap: () =>
                          controller.onTapConversation(conversationModel),
                      child: ColiveChatConversationItemWidget(
                        conversation: conversationModel,
                        onTapPin: controller.onTapPin,
                        onTapDelete: controller.onTapDelete,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 0.5,
                      indent: 75.pt,
                      color: ColiveColors.separatorLineColor,
                    );
                  },
                  itemCount: state.conversationList.length,
                );
              })
            ],
          );
        },
      ),
    );
  }

  Widget _buildSystemMessageWidget() {
    return InkWell(
      onTap: controller.onTapSystemMessage,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 80.pt,
            padding: EdgeInsets.symmetric(horizontal: 15.pt, vertical: 10.pt),
            color: Colors.white,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.pt),
                  child: Image.asset(
                    Assets.imagesColiveAvatarSystemMessage,
                    width: 50.pt,
                    height: 50.pt,
                  ),
                ),
                SizedBox(width: 10.pt),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'colive_system_message'.tr,
                            style: ColiveStyles.title14w600.copyWith(
                              color: ColiveColors.primaryTextColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Obx(() {
                        final model = state.systemMessageModelObs.value != null
                            ? state.systemMessageModelObs.value!
                            : ColiveSystemMessageModel.createDefaultModel();
                        return Text(
                          model.title.trim(),
                          style: ColiveStyles.body12w400.copyWith(
                            color: ColiveColors.primaryTextColor
                                .withOpacity(0.7),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ).marginOnly(top: 4.pt);
                      }),
                    ],
                  ),
                ),
                SizedBox(width: 10.pt),
              ],
            ),
          ),
          Divider(
            height: 0.5,
            indent: 75.pt,
            color: ColiveColors.separatorLineColor,
          ),
        ],
      ),
    );
  }
}
