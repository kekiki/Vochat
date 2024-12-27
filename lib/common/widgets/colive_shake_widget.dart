import 'dart:math';

import 'package:flutter/material.dart';

class ColiveShakeWidget extends StatefulWidget {
  const ColiveShakeWidget({
    super.key,
    required this.child,
    required this.shakeOffset,
    required this.controller,
    this.shakeCount = 3,
  });

  final Widget child;
  final double shakeOffset;
  final int shakeCount;
  final AnimationController controller;

  @override
  State<ColiveShakeWidget> createState() => _ColiveShakeWidgetState();
}

class _ColiveShakeWidgetState extends State<ColiveShakeWidget> {
  late AnimationController _controller;
  late Animation<double> _sineAnimation;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _sineAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: SineCurve(count: widget.shakeCount.toDouble()),
    ));
    _controller.addStatusListener(_updateStatus);
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_updateStatus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sineAnimation,
      child: widget.child,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_sineAnimation.value * widget.shakeOffset, 0),
          child: child,
        );
      },
    );
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _controller.reset();
    }
  }
}

class SineCurve extends Curve {
  const SineCurve({this.count = 3});

  final double count;

  @override
  double transformInternal(double t) {
    return sin(count * 2 * pi * t);
  }
}
