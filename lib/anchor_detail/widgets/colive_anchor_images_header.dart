import 'dart:ui';

import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';

import '../../common/widgets/colive_round_image_widget.dart';
import '../../services/models/colive_anchor_model.dart';
import '../../services/models/colive_login_model.dart';

class ColiveAnchorImagesHeader extends StatelessWidget {
  const ColiveAnchorImagesHeader({
    super.key,
    required this.controller,
    required this.anchor,
    required this.profile,
    required this.availableHeight,
    required this.onPageChanged,
    required this.onTapImage,
  });

  final CarouselSliderController controller;
  final ColiveAnchorModel anchor;
  final ColiveLoginModelUser profile;
  final double availableHeight;
  final ValueChanged<int> onPageChanged;
  final Function(List<ColiveAnchorModelAlbum> list, int index) onTapImage;

  @override
  Widget build(BuildContext context) {
    final imageList = [
      ColiveAnchorModelAlbum.fromJson({'images': anchor.avatar})
    ];
    imageList.addAll(anchor.album);
    return CarouselSlider.builder(
      controller: controller,
      itemCount: imageList.length,
      itemBuilder: (context, index, realIndex) {
        final item = imageList[index];
        final isUserVIP = profile.isVIP;
        final isShowVIP = item.isVip == 1 && !isUserVIP;
        return GestureDetector(
          onTap: () {
            onTapImage(imageList, index);
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: ColiveRoundImageWidget(
                  item.images,
                  width: ColiveScreenAdapt.screenWidth,
                  height: availableHeight,
                  placeholder: Assets.imagesColiveAvatarAnchor,
                ),
              ),
              Positioned.fill(
                child: Visibility(
                  visible: isShowVIP,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Center(
                      child: Image.asset(
                        Assets.imagesColiveVipMedia,
                        width: 60.pt,
                        height: 60.pt,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      options: CarouselOptions(
        height: availableHeight,
        aspectRatio: 375 / 431,
        viewportFraction: 1,
        enableInfiniteScroll: imageList.length > 1,
        autoPlay: imageList.length > 1,
        onPageChanged: (index, reason) {
          onPageChanged(index);
        },
      ),
    );
  }
}
