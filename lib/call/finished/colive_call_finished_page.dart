import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/widgets/colive_round_image_widget.dart';
import 'package:colive/common/utils/colive_format_util.dart';
import 'package:colive/services/static/colive_styles.dart';

import '../../common/widgets/colive_button_widget.dart';
import '../../generated/assets.dart';
import '../../services/static/colive_colors.dart';
import 'colive_call_finished_controller.dart';
import 'colive_call_finished_state.dart';

class ColiveCallFinishedPage extends GetView<ColiveCallFinishedController> {
  const ColiveCallFinishedPage({super.key});

  ColiveCallFinishedState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          leading: Container(),
          actions: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: controller.onTapReport,
              icon: Image.asset(
                Assets.imagesColiveAppbarReport,
                width: 24.pt,
                height: 24.pt,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: ColiveRoundImageWidget(
                state.callModel.anchorAvatar,
                placeholderWidget: Container(),
                width: ColiveScreenAdapt.screenWidth,
                height: ColiveScreenAdapt.screenHeight,
              ),
            ),
            Positioned(child: Container(color: rgba(0, 0, 0, 0.2))),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 12.pt),
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 15.pt),
                    child: Row(
                      children: [
                        ColiveRoundImageWidget(
                          state.callModel.anchorAvatar,
                          width: 80.pt,
                          height: 80.pt,
                          placeholder: Assets.imagesColiveAvatarAnchor,
                          isCircle: true,
                        ),
                        SizedBox(width: 14.pt),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.callModel.anchorNickname,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: ColiveStyles.title18w700.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 6.pt),
                              Obx(
                                () => GestureDetector(
                                  onTap: controller.onTapFollow,
                                  child: Visibility(
                                    visible: state.anchorInfoObs.value.isLike,
                                    replacement: FittedBox(
                                      child: Container(
                                        height: 24.pt,
                                        alignment: AlignmentDirectional.center,
                                        padding:
                                            EdgeInsetsDirectional.symmetric(
                                                horizontal: 12.pt),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  12.pt),
                                          color: ColiveColors.primaryColor,
                                        ),
                                        child: Text(
                                          'colive_follow'.tr,
                                          style: ColiveStyles.body14w400
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    child: FittedBox(
                                      child: Container(
                                        height: 24.pt,
                                        padding:
                                            EdgeInsetsDirectional.symmetric(
                                                horizontal: 12.pt),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(12.pt),
                                            color: Colors.transparent,
                                            border: Border.all(
                                                color: Colors.white)),
                                        child: Text(
                                          'colive_followed'.tr,
                                          style: ColiveStyles.body14w400
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.pt),
                  Container(
                    height: 90.pt,
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 20.pt),
                    margin: EdgeInsetsDirectional.symmetric(horizontal: 15.pt),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadiusDirectional.circular(12.pt),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _costItemWidget(
                          text: 'colive_call_duration'.tr,
                          value: ColiveFormatUtil.durationToTime(
                            state.settlementModel.conversationTime,
                          ),
                        ),
                        _costItemWidget(
                          text: 'colive_gift_cost'.tr,
                          value: state.settlementModel.gift,
                          showDiamond: true,
                        ),
                        Visibility(
                          visible: state.settlementModel.cardNum > 0,
                          replacement: _costItemWidget(
                            text: 'colive_call_cost'.tr,
                            value: state.settlementModel.diamonds,
                            showDiamond: true,
                          ),
                          child: _costItemWidget(
                            text: 'colive_card_cost'.tr,
                            value: state.settlementModel.cardNum.toString(),
                            showDiamond: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.pt),
                  Text(
                    'colive_rate_tips'.tr,
                    style: ColiveStyles.title18w700.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.pt),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemSize: 44.pt,
                    itemPadding: EdgeInsets.zero,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star_rate_rounded,
                      color: ColiveColors.starColor,
                    ),
                    onRatingUpdate: (rating) {
                      state.ratingScore = rating;
                    },
                  ),
                  SizedBox(height: 60.pt),
                  ColiveButtonWidget(
                    onPressed: controller.onTapDone,
                    width: 260.pt,
                    height: 44.pt,
                    borderRadius: 22.pt,
                    backgroundColor: ColiveColors.primaryColor,
                    child: Text(
                      'colive_done'.tr,
                      style: ColiveStyles.title16w700.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _costItemWidget({
    required String text,
    required String value,
    bool showDiamond = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: ColiveStyles.body12w400.copyWith(
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.pt),
        Row(
          children: [
            Text(
              value,
              style: ColiveStyles.title16w600.copyWith(
                color: Colors.white,
              ),
            ).marginSymmetric(horizontal: 4.pt),
            Visibility(
              visible: showDiamond,
              child: Image.asset(
                Assets.imagesColiveDiamond,
                width: 16.pt,
                height: 16.pt,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
