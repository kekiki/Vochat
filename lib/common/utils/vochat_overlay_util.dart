import 'package:flutter/material.dart';

class VochatOverlayUtils {
  static OverlayEntry? _overlayEntry;
  static bool get isVisible => _overlayEntry != null && _overlayEntry!.mounted;

  VochatOverlayUtils._internal();

  static void showOverlay(BuildContext context, Widget child) {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry?.dispose();
    }
    var renderObject = context.findRenderObject();
    if (renderObject == null || renderObject is! RenderBox) {
      return;
    }
    var renderBox = renderObject;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    final overlayEntry = OverlayEntry(
      builder: (context) => PositionedDirectional(
        start: offset.dx,
        top: size.height + offset.dy - 3,
        width: size.width,
        child: child,
      ),
    );
    _overlayEntry = overlayEntry;
    Overlay.of(context).insert(overlayEntry);
  }

  static void dismiss() {
    if (_overlayEntry == null) return;
    final overlay = _overlayEntry!;
    overlay.remove();
    overlay.dispose();
    _overlayEntry = null;
  }
}
