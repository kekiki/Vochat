import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/widgets/colive_marquee_widget.dart';
import 'package:colive/common/widgets/colive_round_image_widget.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:colive/services/static/colive_styles.dart';

import '../../services/models/colive_turntable_model.dart';
import '../../services/widgets/colive_app_bar.dart';
import '../../services/widgets/colive_app_scaffold.dart';
import 'colive_lucky_draw_controller.dart';
import 'colive_lucky_draw_state.dart';

class ColiveLuckyDrawPage extends GetView<ColiveLuckyDrawController> {
  const ColiveLuckyDrawPage({super.key});

  ColiveLuckyDrawState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    return ColiveAppScaffold(
      isStatusBarLight: true,
      appBar: ColiveAppBar(
        appbarColor: Colors.transparent,
        backColor: Colors.white,
        center: Image.asset(
          Assets.imagesColiveLuckDrawPageTitle,
          width: 200.pt,
        ),
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.imagesColiveLuckDrawPageBg),
          fit: BoxFit.cover,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12.pt),
            _buildRewardNoticeWidget(),
            SizedBox(height: 40.pt),
            SizedBox(
              width: ColiveScreenAdapt.screenWidth,
              height: 563.pt,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 3.pt,
                    child: Image.asset(
                      Assets.imagesColiveLuckDrawTurntable,
                      width: 365.pt,
                      height: 563.pt,
                    ),
                  ),
                  Positioned(
                    top: 59.pt,
                    left: 73.pt,
                    width: 234.pt,
                    height: 234.pt,
                    child: Stack(
                      children: [
                        Obx(() {
                          final List<ColiveTurntableRewardModel> rewardList =
                              List.from(state.rewardListObs);
                          if (rewardList.isEmpty) {
                            rewardList
                                .add(ColiveTurntableRewardModel.empty());
                            rewardList
                                .add(ColiveTurntableRewardModel.empty());
                            rewardList
                                .add(ColiveTurntableRewardModel.empty());
                            rewardList
                                .add(ColiveTurntableRewardModel.empty());
                            rewardList
                                .add(ColiveTurntableRewardModel.empty());
                            rewardList
                                .add(ColiveTurntableRewardModel.empty());
                          }
                          return FortuneWheel(
                            selected: controller.wheelController.stream,
                            animateFirst: false,
                            onAnimationEnd: controller.onAnimationEnd,
                            onAnimationStart: controller.onAnimationStart,
                            physics: NoPanPhysics(),
                            indicators: [
                              FortuneIndicator(
                                alignment: Alignment.topCenter,
                                child: Container(),
                              ),
                            ],
                            items: _buildFortuneItems(rewardList),
                          );
                        }),
                        InkWell(
                          onTap: controller.onTapGo,
                          child: Center(
                            child: Image.asset(
                              Assets.imagesColiveLuckDrawGoButton,
                              width: 72.pt,
                              height: 88.pt,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 16.pt,
                    right: 0,
                    top: 362.pt,
                    child: Column(
                      children: [
                        Obx(() {
                          final times = state.remainTimesObs.value;
                          final timesStr =
                              'colive_remain_times_%s'.trArgs(['$times']);
                          return Text(
                            timesStr,
                            style: ColiveStyles.body20w400.copyWith(
                              color: Colors.white,
                            ),
                          );
                        }),
                        SizedBox(height: 66.pt),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: controller.onTapRule,
                              child: Image.asset(
                                Assets.imagesColiveLuckDrawRuleButton,
                                width: 135.pt,
                                height: 50.pt,
                              ),
                            ),
                            SizedBox(width: 8.pt),
                            InkWell(
                              onTap: controller.onTapRecord,
                              child: Image.asset(
                                Assets.imagesColiveLuckDrawRecordButton,
                                width: 135.pt,
                                height: 50.pt,
                              ),
                            ),
                          ],
                        ),
                      ],
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

  Widget _buildRewardNoticeWidget() {
    return Obx(() {
      final List<ColiveTurntableRewardModel> list =
          List.from(state.rewardListObs);
      if (list.isEmpty) {
        return Container(height: 30.pt);
      }
      return Container(
        height: 30.pt,
        color: rgba(255, 255, 255, 0.2),
        child: ColiveMarqueeWidget(
          speed: list.length * 5,
          child: _buildNotifyWidget(list),
        ),
      );
    });
  }

  Widget _buildNotifyWidget(List<ColiveTurntableRewardModel> list) {
    var children = <Widget>[];
    for (var notice in list) {
      children.add(Text(
        '${'colive_lucky_draw_notice_%s_%s'.trArgs([
              'V1${Random().nextInt(1000000) + 1000000}',
              '${notice.name} x${notice.num}'
            ])};',
        style: ColiveStyles.body12w400.copyWith(
          color: Colors.white,
        ),
      ));
      children.add(SizedBox(width: 20.pt));
    }
    return Row(children: children);
  }

  List<FortuneItem> _buildFortuneItems(
      List<ColiveTurntableRewardModel> rewardList) {
    var list = <FortuneItem>[];
    for (int i = 0; i < rewardList.length; i++) {
      final reward = state.rewardListObs[i];
      list.add(_buildRewardItem(reward, i));
    }
    return list;
  }

  FortuneItem _buildRewardItem(ColiveTurntableRewardModel reward, int index) {
    return FortuneItem(
      child: RotatedBox(
        quarterTurns: 1,
        child: SizedBox(
          child: Column(
            children: [
              SizedBox(height: 12.pt),
              AutoSizeText(
                '${reward.name} x${reward.num}',
                style: ColiveStyles.body12w400.copyWith(
                  color: rgba(162, 111, 74, 1),
                ),
                maxLines: 1,
                minFontSize: 8,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.pt),
              ColiveRoundImageWidget(
                reward.img,
                width: 32.pt,
                height: 32.pt,
                placeholder: Assets.imagesColiveChatInputGift,
              ),
            ],
          ),
        ),
      ),
      style: FortuneItemStyle(
        color: index % 2 != 0 ? rgba(248, 210, 134, 1) : rgba(246, 220, 161, 1),
        borderWidth: 1.pt,
        borderColor: rgba(162, 117, 80, 1),
      ),
    );
  }
}
