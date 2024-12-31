import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../adapts/vochat_screen_adapt.dart';

class VochatRoundImageWidget extends StatelessWidget {
  final String imageUrl;
  final String? placeholder;
  final Widget? placeholderWidget;
  final Widget? errorWidget;

  final double? width;
  final double? height;

  final double borderWidth;
  final Color borderColor;

  final bool isCircle;
  final bool isLocalImage;

  final BorderRadiusGeometry borderRadius;
  final double roundRadius;
  final BoxFit fit;

  const VochatRoundImageWidget(
    this.imageUrl, {
    super.key,
    this.width,
    this.height,
    this.placeholder,
    this.placeholderWidget,
    this.errorWidget,
    this.borderWidth = 0,
    this.borderColor = Colors.transparent,
    this.isCircle = false,
    this.borderRadius = BorderRadius.zero,
    this.roundRadius = 0,
    this.isLocalImage = false,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final Widget? image;
    if (imageUrl.isURL || RegExp(r'^http').hasMatch(imageUrl)) {
      image = CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        fadeInDuration: const Duration(milliseconds: 200),
        fadeOutDuration: const Duration(milliseconds: 200),
        placeholder: (context, url) => _buildPlaceholder(),
        errorWidget: (context, url, error) {
          return _buildErrorWidget();
        },
        memCacheWidth: width != null ? width!.toInt() * 3 : null,
        maxWidthDiskCache: VochatScreenAdapt.screenWidth.toInt(),
        maxHeightDiskCache: VochatScreenAdapt.screenHeight.toInt(),
      );
    } else if (imageUrl.isNotEmpty) {
      image = isLocalImage
          ? Image.file(
              File(imageUrl),
              width: width,
              height: height,
              fit: fit,
            )
          : Image.asset(
              imageUrl,
              width: width,
              height: height,
              fit: fit,
            );
    } else {
      image = _buildPlaceholder();
    }
    var newBorderRadius = borderRadius;
    if (isCircle && width != null) {
      newBorderRadius = BorderRadius.circular(width! / 2);
    } else {
      if (borderRadius != BorderRadius.zero) {
        newBorderRadius = borderRadius;
      } else if (roundRadius != 0) {
        newBorderRadius = BorderRadius.circular(roundRadius);
      }
    }
    return Stack(
      children: [
        SizedBox(
          width: width,
          height: height,
          child: ClipRRect(
            borderRadius: newBorderRadius,
            child: image,
          ),
        ),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: newBorderRadius,
            border: borderColor != Colors.transparent && borderWidth > 0
                ? Border.all(color: borderColor, width: borderWidth)
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    if (placeholderWidget != null) {
      return placeholderWidget!;
    } else if (placeholder != null) {
      return Image.asset(
        placeholder!,
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      return SizedBox(width: width, height: height);
    }
  }

  Widget _buildErrorWidget() {
    return errorWidget ?? _buildPlaceholder();
  }
}
