import 'package:flutter/material.dart';
import 'package:colive/common/logger/colive_log_util.dart';

class ColiveKeepAliveWidget extends StatefulWidget {
  final Widget child;

  const ColiveKeepAliveWidget({
    super.key,
    required this.child,
  });

  @override
  State<ColiveKeepAliveWidget> createState() =>
      _ColiveKeepAliveWidgetState();
}

class _ColiveKeepAliveWidgetState extends State<ColiveKeepAliveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    ColiveLogUtil.i('_KeepAliveState', 'initState');
  }

  @override
  void dispose() {
    super.dispose();
    ColiveLogUtil.i('_KeepAliveState', 'dispose');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
