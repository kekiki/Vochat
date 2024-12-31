import 'package:flutter/material.dart';
import 'package:vochat/common/logger/vochat_log_util.dart';

class VochatKeepAliveWidget extends StatefulWidget {
  final Widget child;

  const VochatKeepAliveWidget({
    super.key,
    required this.child,
  });

  @override
  State<VochatKeepAliveWidget> createState() =>
      _VochatKeepAliveWidgetState();
}

class _VochatKeepAliveWidgetState extends State<VochatKeepAliveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    VochatLogUtil.i('_KeepAliveState', 'initState');
  }

  @override
  void dispose() {
    super.dispose();
    VochatLogUtil.i('_KeepAliveState', 'dispose');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
