import 'package:flutter/material.dart';
import 'package:vochat/common/adapts/vochat_colors.dart';

class VochatAppScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? appBar;
  final Widget? bottomNavigationBar;

  final bool isAllowBack;
  final VoidCallback? onBackPressed;
  final Color backgroundColor;
  final Decoration? decoration;
  final bool safeTop;
  final bool safeBottom;
  final bool resizeToAvoidBottomInset;
  final bool isStatusBarLight;

  const VochatAppScaffold({
    super.key,
    this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.isAllowBack = true,
    this.safeTop = true,
    this.safeBottom = true,
    this.onBackPressed,
    this.decoration,
    this.backgroundColor = Colors.white,
    this.resizeToAvoidBottomInset = false,
    this.isStatusBarLight = false,
  });

  @override
  Widget build(BuildContext context) {
    if (onBackPressed != null || !isAllowBack) {
      return PopScope(
        canPop: isAllowBack,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop && onBackPressed != null) {
            onBackPressed!();
          }
        },
        child: _buildScoffold(),
      );
    }
    return _buildScoffold();
  }

  Widget _buildScoffold() {
    final appBarWidget = appBar ?? const SizedBox();
    final bodyWidget = body ?? const SizedBox();
    final bottomWidget = bottomNavigationBar ?? const SizedBox();
    return Container(
      decoration: decoration,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:
              isStatusBarLight ? Colors.transparent : rgba(255, 255, 255, 0),
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          toolbarHeight: 0,
        ),
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor:
            decoration == null ? backgroundColor : Colors.transparent,
        body: SafeArea(
          top: safeTop,
          bottom: safeBottom,
          child: Column(
            children: [
              appBarWidget,
              Expanded(child: bodyWidget),
              bottomWidget,
            ],
          ),
        ),
      ),
    );
  }
}
