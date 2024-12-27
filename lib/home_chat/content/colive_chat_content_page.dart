import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/home_chat/content/colive_chat_content_state.dart';
import 'package:colive/services/widgets/dialogs/gift/colive_gift_animate_page.dart';
import 'package:colive/services/managers/colive_chat_manager.dart';
import 'package:lottie/lottie.dart';

import '../../common/adapts/colive_screen_adapt.dart';
import '../../services/widgets/colive_app_bar.dart';
import '../../services/widgets/colive_app_scaffold.dart';
import '../../generated/assets.dart';
import '../../services/static/colive_styles.dart';
import 'colive_chat_content_controller.dart';
import 'widgets/colive_chat_input_emoji_widget.dart';
// import 'widgets/colive_chat_input_gift_widget.dart';
import 'widgets/colive_chat_input_widget.dart';
import 'widgets/colive_chat_message_widget.dart';
import 'widgets/colive_chat_vip_banner.dart';

class ColiveChatContentPage extends GetView<ColiveChatContentController> {
  const ColiveChatContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = controller.state;
    return Stack(
      children: [
        ColiveAppScaffold(
          appBar: ColiveAppBar(
            center: Obx(() {
              final title = state.isCustomerService.value
                  ? ColiveChatManager.customerServiceName.tr
                  : state.anchorInfoObs.value?.nickname ?? '';
              return Text(
                title,
                style: ColiveStyles.title18w700,
              );
            }),
            end: Visibility(
              visible: !state.isCustomerService.value,
              replacement: SizedBox(width: 44.pt),
              child: InkWell(
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
          ),
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          body: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: controller.onCloseKeyboard,
                  child: Column(
                    children: [
                      Obx(() {
                        final show = state.showVipBannerObs.value &&
                            !state.profileObs.value.isVIP &&
                            !state.isCustomerService.value;
                        return Visibility(
                          visible: show,
                          child: ColiveChatVipBanner(
                            chatNum: state.blockModelObs.value.chatNum,
                            onTap: controller.onTapVipBanner,
                            onTapClose: controller.onTapVipBannerClose,
                          ),
                        );
                      }),
                      Flexible(
                        child: Obx(() {
                          final messageList = List.from(state.messageList);
                          return CustomScrollView(
                            // physics: const ClampingScrollPhysics(),
                            controller: controller.scrollController,
                            shrinkWrap: true,
                            reverse: true,
                            slivers: [
                              SliverList.builder(
                                itemCount: messageList.length,
                                itemBuilder: (context, index) {
                                  final anchorAvatar = state
                                          .isCustomerService.value
                                      ? Assets.imagesColiveAvatarCustomerService
                                      : state.anchorInfoObs.value?.avatar ?? '';
                                  return ColiveChatMessageWidget(
                                    message: messageList[index],
                                    onTapAnchorAvatar:
                                        controller.onTapAnchorAvatar,
                                    onTapUserAvatar: controller.onTapUserAvatar,
                                    onTapMessage: controller.onTapMessage,
                                    userAvatar: state.profileObs.value.avatar,
                                    anchorAvatar: anchorAvatar,
                                    onTapResend: controller.onTapResend,
                                  );
                                },
                              ),
                              SliverToBoxAdapter(
                                child: AnimatedSize(
                                  alignment: Alignment.topCenter,
                                  duration: const Duration(milliseconds: 150),
                                  child: Visibility(
                                    visible: state.isMessageLoading.value,
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.pt),
                                      alignment: Alignment.center,
                                      child: Lottie.asset(
                                        Assets.animatesColiveChatMessageLoading,
                                        width: 22.pt,
                                        height: 22.pt,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() {
                String placeholder = 'colive_enter_content'.tr;
                if (!state.profileObs.value.isVIP &&
                    !state.isCustomerService.value) {
                  if (state.blockModelObs.value.chatNum > 0) {
                    placeholder = 'colive_message_remain_%s_num'
                        .trArgs([state.blockModelObs.value.chatNum.toString()]);
                  } else {
                    placeholder = 'colive_unlimit_chat_tips'.tr;
                  }
                }
                return ColiveChatInputWidget(
                  conversationId: state.sessionId,
                  placeholder: placeholder,
                  textEditingController: controller.editingController,
                  textEditingNode: controller.editingNode,
                  inputType: state.inputTypeObs.value,
                  enableSend: state.enableSendObs.value,
                  onTapSend: controller.onTapSend,
                  onTapEmoji: controller.onTapEmoji,
                  onTapImage: controller.onTapImage,
                  onTapCall: controller.onTapCall,
                  onTapGift: controller.onTapGift,
                  onTapTextField: controller.onTapTextField,
                );
              }),
              Obx(
                () => AnimatedSize(
                  alignment: Alignment.topCenter,
                  duration: const Duration(milliseconds: 150),
                  child: Visibility(
                    visible:
                        state.inputTypeObs.value == ColiveChatInputType.emoji,
                    replacement: SizedBox(width: ColiveScreenAdapt.screenWidth),
                    child: ColiveChatInputEmojiWidget(
                      emojiList: state.emojiList,
                      onTapSendEmoji: controller.onTapSendEmoji,
                    ),
                  ),
                ),
              ),
              // Obx(
              //   () => AnimatedSize(
              //     alignment: Alignment.topCenter,
              //     duration: const Duration(milliseconds: 150),
              //     child: Visibility(
              //       visible:
              //           state.inputTypeObs.value == ColiveChatInputType.gift,
              //       replacement:
              //           SizedBox(width: ColiveScreenAdapt.screenWidth),
              //       child: ColiveChatInputGiftWidget(
              //         balance: state.profileObs.value.diamonds,
              //         giftModel: state.giftModelObs.value,
              //         onTapSendGift: controller.onTapSendGift,
              //         onTapTopup: controller.onTapTopup,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        const Positioned.fill(
          child: ColiveGiftAnimatePage(),
        ),
      ],
    );
  }
}
