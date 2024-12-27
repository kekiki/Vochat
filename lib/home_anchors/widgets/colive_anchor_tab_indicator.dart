import 'package:flutter/material.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/services/static/colive_colors.dart';

class ColiveAnchorTabIndicator extends Decoration {
  final TabController? tabController;
  final double indicatorWidth;
  final double indicatorHeight;

  const ColiveAnchorTabIndicator({
    this.tabController,
    this.indicatorWidth = 20,
    this.indicatorHeight = 4,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _UnderlinePainter(onChanged, this, indicatorWidth, indicatorHeight);
  }

  @override
  Path getClipPath(Rect rect, TextDirection textDirection) {
    return Path()..addRect(_indicatorRectFor(rect, textDirection));
  }

  Rect _indicatorRectFor(Rect indicator, TextDirection textDirection) {
    double width = indicatorWidth;
    double height = indicatorHeight;
    double left = indicator.center.dx - (indicatorWidth / 2);
    double top = indicator.bottom - indicatorHeight - 2.pt;
    return Rect.fromLTWH(left, top, width, height);
  }
}

class _UnderlinePainter extends BoxPainter {
  final Paint underLinePaint = Paint();
  final ColiveAnchorTabIndicator decoration;
  final double indicatorWidth;
  final double indicatorHeight;

  _UnderlinePainter(
    super.onChanged,
    this.decoration,
    this.indicatorWidth,
    this.indicatorHeight,
  );

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final TextDirection textDirection = configuration.textDirection!;
    final Rect indicator = decoration._indicatorRectFor(rect, textDirection);
    underLinePaint.style = PaintingStyle.fill;
    underLinePaint.shader = ColiveColors.mainGradient.createShader(indicator);
    canvas.drawRRect(RRect.fromRectXY(indicator, 20, 20), underLinePaint);
  }
}
