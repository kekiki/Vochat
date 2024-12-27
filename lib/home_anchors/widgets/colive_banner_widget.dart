import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/services/static/colive_colors.dart';

import '../../common/widgets/colive_round_image_widget.dart';
import '../../services/models/colive_banner_model.dart';
import '../../services/widgets/colive_svga_image.dart';

class ColiveBannerWidget extends StatelessWidget {
  final List<ColiveBannerModel> bannerList;
  final ValueChanged<ColiveBannerModel>? onTapBanner;
  final double width;
  final double height;

  const ColiveBannerWidget({
    super.key,
    required this.bannerList,
    required this.width,
    required this.height,
    this.onTapBanner,
  });

  @override
  Widget build(BuildContext context) {
    if (bannerList.isEmpty) {
      return const SizedBox();
    }
    final indexObs = 0.obs;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
            child: CarouselSlider.builder(
              itemCount: bannerList.length,
              itemBuilder: (context, index, realIndex) {
                final bannerInfo = bannerList[index];
                return GestureDetector(
                  onTap: () => onTapBanner?.call(bannerInfo),
                  behavior: HitTestBehavior.translucent,
                  child: Visibility(
                    visible: !bannerInfo.images.contains('.svga'),
                    replacement: ColiveSvgaImage(
                      bannerInfo.images,
                      preferredSize: Size(345.pt, 90.pt),
                      borderRadius: BorderRadius.circular(12.pt),
                      placeholderWidget: Container(
                        width: 345.pt,
                        height: 90.pt,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.pt),
                          color: ColiveColors.cardColor,
                        ),
                      ),
                    ),
                    child: ColiveRoundImageWidget(
                      bannerInfo.images,
                      width: 345.pt,
                      height: 90.pt,
                      borderRadius: BorderRadius.circular(12.pt),
                      placeholderWidget: Container(
                        width: 345.pt,
                        height: 90.pt,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.pt),
                          color: ColiveColors.cardColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 90.pt,
                aspectRatio: 345 / 90,
                viewportFraction: 1,
                enableInfiniteScroll: bannerList.length > 1,
                autoPlay: bannerList.length > 1,
                onPageChanged: (index, reason) {
                  indexObs.value = index;
                },
              ),
            ),
          ),
          PositionedDirectional(
            bottom: 6.pt,
            start: 0,
            end: 0,
            child: Visibility(
              visible: bannerList.length > 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: bannerList.map((e) {
                  return Obx(() {
                    final isSelect = indexObs.value == bannerList.indexOf(e);
                    final double width;
                    final Color color;
                    if (isSelect) {
                      width = 20.pt;
                      color = Colors.white;
                    } else {
                      width = 6.pt;
                      color = Colors.white54;
                    }
                    return Container(
                      width: width,
                      height: 6.pt,
                      margin: EdgeInsets.symmetric(horizontal: 3.pt),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(22.pt),
                      ),
                    );
                  });
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
