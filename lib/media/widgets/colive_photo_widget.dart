import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/widgets/colive_round_image_widget.dart';
import 'package:colive/generated/assets.dart';

class ColivePhotoWidget extends StatefulWidget {
  final String photoUri;
  const ColivePhotoWidget({super.key, required this.photoUri});

  @override
  State<ColivePhotoWidget> createState() => _ColivePhotoWidgetState();
}

class _ColivePhotoWidgetState extends State<ColivePhotoWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColiveRoundImageWidget(
      widget.photoUri,
      width: ColiveScreenAdapt.screenWidth,
      height: ColiveScreenAdapt.screenHeight,
      placeholder: Assets.imagesColiveAvatarAnchor,
      isLocalImage: !widget.photoUri.isURL,
      fit: BoxFit.contain,
    );
  }
}
