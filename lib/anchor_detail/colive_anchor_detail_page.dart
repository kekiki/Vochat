import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:colive/common/widgets/colive_gradient_border.dart';
import 'package:colive/common/widgets/colive_round_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/services/extensions/colive_widget_ext.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:colive/services/static/colive_styles.dart';
import 'package:sprintf/sprintf.dart';

import '../generated/assets.dart';
import '../home_anchors/widgets/colive_anchor_age_widget.dart';
import '../home_anchors/widgets/colive_anchor_country_widget.dart';
import '../home_anchors/widgets/colive_anchor_status_widget.dart';
import '../services/models/colive_anchor_model.dart';
import 'colive_anchor_detail_controller.dart';
import 'colive_anchor_detail_state.dart';
import 'widgets/colive_anchor_bottom_bar.dart';
import 'widgets/colive_anchor_images_header.dart';
import 'widgets/colive_anchor_moment_widget.dart';
import 'widgets/colive_anchor_video_cover.dart';
import 'widgets/colive_sliver_flexible_header.dart';

class ColiveAnchorDetailPage extends GetView<ColiveAnchorDetailController> {
  const ColiveAnchorDetailPage({super.key});

  ColiveAnchorDetailState get state => controller.state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: rgba(255, 255, 255, state.appBarAlphaObs.value),
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          title: Opacity(
            opacity: state.appBarAlphaObs.value,
            child: Text(
              state.anchorInfoObs.value.nickname,
              style: ColiveStyles.title18w700,
            ),
          ),
          leading: IconButton(
            onPressed: Get.back,
            icon: Container(
              width: 28.pt,
              height: 28.pt,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: rgba(255, 255, 255, 0.5),
                borderRadius: BorderRadius.circular(14.pt),
              ),
              child: Image.asset(
                Assets.imagesColiveAppbarBack,
                width: 24.pt,
                height: 24.pt,
              ).rtl,
            ),
          ),
          actions: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: controller.onTapReport,
              icon: Container(
                width: 28.pt,
                height: 28.pt,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: rgba(255, 255, 255, 0.5),
                  borderRadius: BorderRadius.circular(14.pt),
                ),
                child: Image.asset(
                  Assets.imagesColiveAppbarReport,
                  width: 20.pt,
                  height: 20.pt,
                ),
              ),
            )
          ],
        ),
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          controller: controller.scrollController,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            ColiveSliverFlexibleHeader(
              visibleExtent: state.headerVisibleExtent,
              backgroundBuilder: (context, availableHeight, direction) {
                return Obx(
                  () => ColiveAnchorImagesHeader(
                    controller: controller.sliderController,
                    anchor: state.anchorInfoObs.value,
                    profile: state.profileObs.value,
                    availableHeight: availableHeight,
                    onPageChanged: controller.onPageChanged,
                    onTapImage: controller.onTapImage,
                  ),
                );
              },
              childBuilder: (context) {
                return Stack(
                  children: [
                    PositionedDirectional(
                      start: 0,
                      end: 0,
                      top: 0,
                      height: ColiveScreenAdapt.statusBarHeight,
                      child: IgnorePointer(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                rgba(255, 255, 255, 0.5),
                                rgba(255, 255, 255, 0)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      start: 0,
                      end: 0,
                      bottom: 0,
                      height: 204.pt,
                      child: IgnorePointer(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.5)],
                            ),
                          ),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      start: 0,
                      bottom: 12.pt,
                      end: 0,
                      height: 52.pt,
                      child: Obx(() {
                        final imageList = List<ColiveAnchorModelAlbum>.from(
                            state.albumListObs);
                        return ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 15.pt),
                          controller: controller.imageScrollController,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Obx(() {
                              final isSelected =
                                  state.currentImageIndexObs.value == index;
                              final photo = imageList[index];
                              final isUserVip = state.profileObs.value.isVIP;
                              final isNeedVip = photo.isVip == 1;
                              final showVIP = isNeedVip && !isUserVip;
                              return Container(
                                alignment: AlignmentDirectional.bottomCenter,
                                child: GestureDetector(
                                  onTap: () => controller.onTapImagePage(index),
                                  child: Container(
                                    width: isSelected ? 52.pt : 46.pt,
                                    height: isSelected ? 52.pt : 46.pt,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(10.pt),
                                      border: isSelected
                                          ? const ColiveGradientBorder(
                                              gradient:
                                                  ColiveColors.mainGradient)
                                          : Border.all(color: Colors.white),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(9.pt),
                                      child: Stack(
                                        children: [
                                          ColiveRoundImageWidget(
                                            photo.images,
                                            placeholder:
                                                Assets.imagesColiveAvatarAnchor,
                                            width: isSelected ? 52.pt : 46.pt,
                                            height: isSelected ? 52.pt : 46.pt,
                                          ),
                                          Visibility(
                                            visible: showVIP,
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 5, sigmaY: 5),
                                              child: Container(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(width: 8.pt);
                          },
                          itemCount: imageList.length,
                        );
                      }),
                    ),
                  ],
                );
              },
            ),
            SliverToBoxAdapter(
              child: Obx(
                () => Container(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 14.pt,
                    vertical: 20.pt,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: ColiveColors.separatorLineColor,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AutoSizeText(
                                  state.anchorInfoObs.value.nickname,
                                  maxLines: 1,
                                  minFontSize: 8,
                                  style: ColiveStyles.title18w700,
                                ),
                                SizedBox(width: 6.pt),
                                ColiveAnchorAgeWidget(
                                    anchor: state.anchorInfoObs.value),
                              ],
                            ),
                            SizedBox(height: 4.pt),
                            Row(
                              children: [
                                ColiveAnchorStatusWidget(
                                  anchor: state.anchorInfoObs.value,
                                ).marginDirectional(end: 4.pt),
                                ColiveAnchorCountryWidget(
                                  anchor: state.anchorInfoObs.value,
                                ).marginDirectional(end: 4.pt),
                                Container(
                                  height: 20.pt,
                                  padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 6.pt,
                                  ),
                                  decoration: BoxDecoration(
                                    color: rgba(0, 0, 0, 0.5),
                                    borderRadius:
                                        BorderRadiusDirectional.circular(12.pt),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'colive_id_num_%s'.trArgs([
                                        state.anchorInfoObs.value.id.toString()
                                      ]),
                                      style: ColiveStyles.body10w400.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.pt),
                      GestureDetector(
                        onTap: controller.onTapFollow,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.pt, vertical: 8.pt),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.pt),
                            color: state.anchorInfoObs.value.isLike
                                ? rgba(255, 84, 125, 0.08)
                                : rgba(248, 248, 248, 1),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                Assets.imagesColiveHeart,
                                width: 20.pt,
                                color: state.anchorInfoObs.value.isLike
                                    ? rgba(255, 62, 93, 1)
                                    : rgba(185, 195, 207, 1),
                              ),
                              SizedBox(width: 4.pt),
                              Text(
                                state.anchorInfoObs.value.like.toString(),
                                style: ColiveStyles.body14w400.copyWith(
                                  color: state.anchorInfoObs.value.isLike
                                      ? rgba(255, 62, 93, 1)
                                      : rgba(185, 195, 207, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(
                () => Container(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 14.pt),
                  child: Row(
                    children: [
                      Text(
                        'colive_score'.tr,
                        style: ColiveStyles.title16w600,
                      ),
                      const Spacer(),
                      RatingBar.builder(
                        initialRating:
                            double.parse(state.anchorInfoObs.value.star),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20.pt,
                        itemPadding: EdgeInsets.zero,
                        ignoreGestures: true,
                        itemBuilder: (context, _) => const Icon(
                            Icons.star_rate_rounded,
                            color: ColiveColors.starColor),
                        onRatingUpdate: (rating) {},
                      ),
                      SizedBox(width: 6.pt),
                      Text(
                        sprintf('%0.1f',
                            [double.parse(state.anchorInfoObs.value.star)]),
                        style: ColiveStyles.title16w600.copyWith(
                          color: ColiveColors.starColor,
                        ),
                      ),
                    ],
                  ),
                ).marginOnly(top: 20.pt),
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(() {
                return Container(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 14.pt,
                    vertical: 20.pt,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: ColiveColors.separatorLineColor,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 102.pt,
                        height: 66.pt,
                        decoration: BoxDecoration(
                          color: rgba(114, 229, 255, 0.5),
                          borderRadius: BorderRadiusDirectional.circular(16.pt),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'colive_height'.tr,
                              style: ColiveStyles.body12w400.copyWith(
                                color: rgba(0, 0, 0, 0.4),
                              ),
                            ),
                            Text(
                              '${state.anchorInfoObs.value.height}cm',
                              style: ColiveStyles.title16w600,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 102.pt,
                        height: 66.pt,
                        decoration: BoxDecoration(
                          color: rgba(255, 152, 250, 0.5),
                          borderRadius: BorderRadiusDirectional.circular(16.pt),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'colive_weight'.tr,
                              style: ColiveStyles.body12w400.copyWith(
                                color: rgba(0, 0, 0, 0.4),
                              ),
                            ),
                            Text(
                              '${state.anchorInfoObs.value.weight}kg',
                              style: ColiveStyles.title16w600,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 102.pt,
                        height: 66.pt,
                        decoration: BoxDecoration(
                          color: rgba(255, 223, 105, 0.5),
                          borderRadius: BorderRadiusDirectional.circular(16.pt),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'colive_emotion'.tr,
                              style: ColiveStyles.body12w400.copyWith(
                                color: rgba(0, 0, 0, 0.4),
                              ),
                            ),
                            Text(
                              'colive_single'.tr,
                              style: ColiveStyles.title16w600,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            SliverToBoxAdapter(
              child: Obx(() {
                final signature = state.anchorInfoObs.value.signature.isNotEmpty
                    ? state.anchorInfoObs.value.signature
                    : 'colive_anchor_signature_place'.tr;

                return Container(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 14.pt,
                    vertical: 20.pt,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: ColiveColors.separatorLineColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'colive_introduction'.tr,
                        style: ColiveStyles.title16w600,
                      ).marginOnly(bottom: 6.pt),
                      Text(
                        signature,
                        style: ColiveStyles.body14w400.copyWith(
                            color: ColiveColors.grayTextColor, height: 1.6),
                      ),
                    ],
                  ),
                );
              }),
            ),
            SliverToBoxAdapter(
              child: Obx(() {
                final videos = state.anchorInfoObs.value.videos;
                return Visibility(
                  visible: videos.isNotEmpty,
                  child: Container(
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 14.pt,
                      vertical: 20.pt,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: ColiveColors.separatorLineColor,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: controller.onTapMoreVideo,
                          child: Row(
                            children: [
                              Text(
                                'colive_video'.tr,
                                style: ColiveStyles.title16w600,
                              ),
                              const Spacer(),
                              Image.asset(
                                Assets.imagesColiveMineArrowRight,
                                width: 16.pt,
                                height: 16.pt,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6.pt),
                        SizedBox(
                          width: double.infinity,
                          height: 120.pt,
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemCount: videos.length,
                            itemBuilder: (context, index) {
                              final video = videos[index];
                              return ColiveAnchorVideoCover(
                                videoModel: video,
                                profile: state.profileObs.value,
                                onTap: controller.onTapVideo,
                                width: 90.pt,
                                height: 120.pt,
                                borderRadius: BorderRadius.circular(8.pt),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 10.pt, height: 10.pt);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            SliverToBoxAdapter(
              child: Obx(() {
                return state.momentListObs.isNotEmpty
                    ? Container(
                        padding: EdgeInsetsDirectional.only(top: 20.pt),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: ColiveColors.separatorLineColor,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: controller.onTapMoreMoment,
                              child: Padding(
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 14.pt),
                                child: Row(
                                  children: [
                                    Text(
                                      'colive_moment'.tr,
                                      style: ColiveStyles.title16w600,
                                    ),
                                    const Spacer(),
                                    Image.asset(
                                      Assets.imagesColiveMineArrowRight,
                                      width: 16.pt,
                                      height: 16.pt,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 6.pt),
                            ColiveAnchorMomentidget(
                              moment: state.momentListObs.first,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink();
              }),
            ),
            SliverToBoxAdapter(
              child: Obx(() {
                return Visibility(
                  visible: state.anchorInfoObs.value.label.isNotEmpty,
                  child: Container(
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 14.pt,
                      vertical: 20.pt,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'colive_tags'.tr,
                          style: ColiveStyles.title16w600,
                        ),
                        SizedBox(height: 6.pt),
                        Wrap(
                          spacing: 10.pt,
                          runSpacing: 10.pt,
                          children: state.anchorInfoObs.value.label.map((e) {
                            return Container(
                              padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 10.pt,
                                vertical: 8.pt,
                              ),
                              decoration: BoxDecoration(
                                color: ColiveColors.cardColor,
                                borderRadius:
                                    BorderRadiusDirectional.circular(6.pt),
                              ),
                              child: Text(
                                e.word,
                                style: ColiveStyles.title12w700,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
        bottomNavigationBar: Obx(
          () => ColiveAnchorBottomBar(
            anchor: state.anchorInfoObs.value,
            hasFreeCallCard: state.haveFreeCallCard.value,
            onTapChat: controller.onTapChat,
            onTapCall: controller.onTapCall,
          ),
        ),
      );
    });
  }
}
