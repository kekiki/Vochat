import 'package:flutter/material.dart';

class VochatMarqueeWidget extends StatefulWidget {
  const VochatMarqueeWidget(
      {required this.child, this.speed = 10, super.key});
  final Widget child;
  final int speed;

  @override
  State<VochatMarqueeWidget> createState() => _VochatMarqueeWidgetState();
}

class _VochatMarqueeWidgetState extends State<VochatMarqueeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late ScrollController _scrCrl;
  SingleChildScrollView? _scrollView;

  double _space = 0;

  @override
  void initState() {
    super.initState();

    _scrCrl = ScrollController();

    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: widget.speed));
    _animation = Tween(
      begin: 0.1,
      end: 100.0,
    ).animate(_controller);
    _animation.addListener(() {
      if (_scrCrl.hasClients) {
        if (_scrollView != null && _scrCrl.position.hasContentDimensions) {
          var index = _animation.value / 100;
          _scrCrl.jumpTo(index * _scrCrl.position.maxScrollExtent);
        }
        if (_scrCrl.position.hasViewportDimension && _space == 0) {
          setState(() {
            _space = _scrCrl.position.viewportDimension;
          });
        }
      }
    });
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    _scrollView = SingleChildScrollView(
      controller: _scrCrl,
      scrollDirection: Axis.horizontal,
      child: _scrCrl.hasClients
          ? Row(
              children: [
                SizedBox(
                  width: _space,
                ),
                widget.child,
                SizedBox(
                  width: _space,
                ),
              ],
            )
          : const SizedBox(),
    );
    return _scrollView ?? const SizedBox();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
