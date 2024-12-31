import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vochat/common/adapts/vochat_screen_adapt.dart';
import 'package:vochat/common/widgets/vochat_round_image_widget.dart';

import '../../../generated/assets.dart';

class VochatPhotoWidget extends StatefulWidget {
  final String photoUri;
  const VochatPhotoWidget({super.key, required this.photoUri});

  @override
  State<VochatPhotoWidget> createState() => _VochatPhotoWidgetState();
}

class _VochatPhotoWidgetState extends State<VochatPhotoWidget> {
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
    return VochatRoundImageWidget(
      widget.photoUri,
      width: VochatScreenAdapt.screenWidth,
      height: VochatScreenAdapt.screenHeight,
      placeholder: Assets.imagesVochatAvatarFemale,
      isLocalImage: !widget.photoUri.isURL,
      fit: BoxFit.contain,
    );
  }
}
