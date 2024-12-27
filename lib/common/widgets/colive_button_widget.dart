import 'package:flutter/material.dart';

import 'colive_gradient_border.dart';

class ColiveButtonWidget extends StatelessWidget {
  const ColiveButtonWidget({
    super.key,
    required this.onPressed,
    required this.width,
    required this.height,
    this.child,
    this.backgroundGradient,
    this.borderGradient,
    this.borderRadius = 0,
    this.borderWidth = 0,
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.transparent,
    this.splashColor = Colors.black12,
  });

  final Widget? child;
  final Color backgroundColor;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final double borderRadius;

  final Color borderColor;
  final double borderWidth;
  final Color splashColor;
  final Gradient? backgroundGradient;
  final Gradient? borderGradient;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.all(Radius.circular(this.borderRadius));
    BoxBorder? border;
    final gradient = borderGradient;
    if (gradient != null) {
      border = ColiveGradientBorder(gradient: gradient, width: borderWidth);
    }
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: backgroundGradient,
        borderRadius: borderRadius,
        border: border,
      ),
      child: OutlinedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
          foregroundColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: MaterialStateProperty.all(splashColor),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          fixedSize: MaterialStateProperty.all(Size(width, height)),
          side: MaterialStateProperty.all(
              BorderSide(color: borderColor, width: borderWidth)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
          ),
        ),
        onPressed: onPressed,
        child: child ?? Container(),
      ),
    );
  }
}
