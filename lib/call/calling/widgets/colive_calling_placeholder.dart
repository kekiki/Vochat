import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';

import '../../../common/widgets/colive_round_image_widget.dart';

class ColiveCallingPlaceholder extends StatelessWidget {
  const ColiveCallingPlaceholder({
    super.key,
    required this.avatar,
    this.fullScreen = false,
    this.isSelf = false,
  });

  final String avatar;
  final bool fullScreen;
  final bool isSelf;

  @override
  Widget build(BuildContext context) {
    final size = fullScreen ? 98.pt : 58.pt;
    final color =
        fullScreen ? const Color(0xEB323339) : const Color(0xD95D5F68);
    return Stack(
      fit: StackFit.expand,
      children: [
        ColiveRoundImageWidget(
          avatar,
          width: ColiveScreenAdapt.screenWidth,
          height: ColiveScreenAdapt.screenHeight,
          fit: BoxFit.cover,
          placeholderWidget: _buildPlaceHolder(true),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: color,
              width: size,
              height: size,
              alignment: Alignment.center,
              child: ClipOval(
                child: ColiveRoundImageWidget(
                  avatar,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                  placeholderWidget: _buildPlaceHolder(false),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceHolder(bool isBackground) {
    final size = isBackground ? 98.pt : 58.pt;
    return Image.asset(
      isSelf ? Assets.imagesColiveAvatarUser : Assets.imagesColiveAvatarAnchor,
      width: isBackground ? double.infinity : size,
      height: isBackground ? double.infinity : size,
      fit: BoxFit.cover,
    );
  }
}
