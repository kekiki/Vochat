import 'package:flutter/material.dart';

class VochatRotateAnimationWidget extends StatefulWidget {
  const VochatRotateAnimationWidget({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 10),
  });

  final Widget child;
  final Duration duration;

  @override
  State<VochatRotateAnimationWidget> createState() =>
      _VochatRotateAnimationWidgetState();
}

class _VochatRotateAnimationWidgetState
    extends State<VochatRotateAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: widget.child,
    );
  }
}
