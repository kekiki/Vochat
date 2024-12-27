import 'package:flutter/widgets.dart';

/// The direction in which an animation is running.
enum ColiveAnimationDirection {
  /// The animation is running from beginning to end.
  forward,

  /// The animation is running backwards, from end to beginning.
  reverse,
}

/// Helper Widget to Fade in or out
class ColiveFadeWidget extends StatefulWidget {
  /// Child widget being faded
  final Widget child;

  /// Fade duration
  final Duration duration;

  /// Duration direction, forward is from invisible to visible
  final ColiveAnimationDirection direction;

  /// Animation curve. See [Curves] for more options.
  final Curve curve;

  /// Fading [child] in or out depending on [direction] with a [curve] and
  /// [duration]./
  const ColiveFadeWidget(
      {required this.child,
      this.duration = const Duration(milliseconds: 200),
      this.direction = ColiveAnimationDirection.forward,
      this.curve = Curves.easeInOut,
      super.key});

  @override
  State<ColiveFadeWidget> createState() => _ColiveFadeWidgetState();
}

class _ColiveFadeWidgetState extends State<ColiveFadeWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController controller;
  late bool hideWidget;

  @override
  Widget build(BuildContext context) {
    if (hideWidget) {
      return const SizedBox.shrink();
    }

    return FadeTransition(
      opacity: opacity,
      child: widget.child,
    );
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: widget.duration, vsync: this);
    final curved = CurvedAnimation(parent: controller, curve: widget.curve);
    var begin =
        widget.direction == ColiveAnimationDirection.forward ? 0.0 : 1.0;
    var end =
        widget.direction == ColiveAnimationDirection.forward ? 1.0 : 0.0;
    opacity = Tween<double>(begin: begin, end: end).animate(curved);
    controller.forward();

    hideWidget = false;
    if (widget.direction == ColiveAnimationDirection.reverse) {
      opacity.addStatusListener(animationStatusChange);
    }
  }

  @override
  void didUpdateWidget(ColiveFadeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (Widget.canUpdate(oldWidget.child, widget.child)) return;
    opacity.removeStatusListener(animationStatusChange);
    controller.duration = widget.duration;
    controller.value = 0;
    final curved = CurvedAnimation(parent: controller, curve: widget.curve);
    var begin =
        widget.direction == ColiveAnimationDirection.forward ? 0.0 : 1.0;
    var end =
        widget.direction == ColiveAnimationDirection.forward ? 1.0 : 0.0;
    opacity = Tween<double>(begin: begin, end: end).animate(curved);
    controller.forward();

    hideWidget = false;
    if (widget.direction == ColiveAnimationDirection.reverse) {
      opacity.addStatusListener(animationStatusChange);
    }
  }

  @override
  void dispose() {
    opacity.removeStatusListener(animationStatusChange);
    controller.dispose();
    super.dispose();
  }

  void animationStatusChange(AnimationStatus status) {
    setState(() {
      hideWidget = widget.direction == ColiveAnimationDirection.reverse &&
          status == AnimationStatus.completed;
    });
  }
}
