import 'dart:math';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'colive_extra_info_constraints.dart';

typedef ColiveSliverFlexibleHeaderBuilder = Widget Function(
  BuildContext context,
  double maxExtent,
  ScrollDirection direction,
);

/// A sliver to provide a flexible header that its height can expand when user continue
/// dragging over scroll . Typically as the first child  of [CustomScrollView].
class ColiveSliverFlexibleHeader extends StatelessWidget {
  const ColiveSliverFlexibleHeader({
    super.key,
    this.visibleExtent = 0,
    required this.backgroundBuilder,
    required this.childBuilder,
  });

  final ColiveSliverFlexibleHeaderBuilder backgroundBuilder;
  final double visibleExtent;

  final Widget Function(BuildContext context) childBuilder;

  @override
  Widget build(BuildContext context) {
    return _ColiveSliverFlexibleHeader(
      visibleExtent: visibleExtent,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: [
              backgroundBuilder(
                context,
                constraints.maxHeight,
                (constraints
                        as ColiveExtraInfoBoxConstraints<ScrollDirection>)
                    .extra,
              ),
              childBuilder(context),
            ],
          );
        },
      ),
    );
  }
}

class _ColiveSliverFlexibleHeader extends SingleChildRenderObjectWidget {
  const _ColiveSliverFlexibleHeader({
    required Widget super.child,
    this.visibleExtent = 0,
  });
  final double visibleExtent;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _ColiveFlexibleHeaderRenderSliver(visibleExtent);
  }

  @override
  void updateRenderObject(
      context, _ColiveFlexibleHeaderRenderSliver renderObject) {
    renderObject.visibleExtent = visibleExtent;
  }
}

class _ColiveFlexibleHeaderRenderSliver extends RenderSliverSingleBoxAdapter {
  _ColiveFlexibleHeaderRenderSliver(double visibleExtent)
      : _visibleExtent = visibleExtent;
  double _lastOverScroll = 0;
  double _lastScrollOffset = 0;
  double _visibleExtent = 0;
  ScrollDirection _direction = ScrollDirection.idle;
  bool _reported = false;
  double? _scrollOffsetCorrection;

  set visibleExtent(double value) {
    if (_visibleExtent != value) {
      _lastOverScroll = 0;
      _reported = false;
      _scrollOffsetCorrection = value - _visibleExtent;
      _visibleExtent = value;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
    if (_scrollOffsetCorrection != null) {
      geometry = SliverGeometry(
        scrollOffsetCorrection: _scrollOffsetCorrection,
      );
      _scrollOffsetCorrection = null;
      return;
    }

    if (child == null) {
      geometry = SliverGeometry(scrollExtent: _visibleExtent);
      return;
    }

    if (constraints.scrollOffset > _visibleExtent) {
      geometry = SliverGeometry(scrollExtent: _visibleExtent);
      if (!_reported) {
        _reported = true;
        child!.layout(
          ColiveExtraInfoBoxConstraints(
            _direction,
            constraints.asBoxConstraints(maxExtent: 0),
          ),
          parentUsesSize: false,
        );
      }
      return;
    }

    _reported = false;
    double overScroll = constraints.overlap < 0 ? constraints.overlap.abs() : 0;
    var scrollOffset = constraints.scrollOffset;
    _direction = ScrollDirection.idle;

    var distance = overScroll > 0
        ? overScroll - _lastOverScroll
        : _lastScrollOffset - scrollOffset;
    _lastOverScroll = overScroll;
    _lastScrollOffset = scrollOffset;

    if (constraints.userScrollDirection == ScrollDirection.idle) {
      _direction = ScrollDirection.idle;
      _lastOverScroll = 0;
    } else if (distance > 0) {
      _direction = ScrollDirection.forward;
    } else if (distance < 0) {
      _direction = ScrollDirection.reverse;
    }
    double paintExtent = _visibleExtent + overScroll - constraints.scrollOffset;
    paintExtent = min(paintExtent, constraints.remainingPaintExtent);

    child!.layout(
      ColiveExtraInfoBoxConstraints(
        _direction,
        constraints.asBoxConstraints(maxExtent: paintExtent),
      ),
      parentUsesSize: false,
    );

    double layoutExtent = min(_visibleExtent, paintExtent);
    geometry = SliverGeometry(
      scrollExtent: _visibleExtent,
      paintOrigin: -overScroll,
      paintExtent: paintExtent,
      maxPaintExtent: paintExtent,
      layoutExtent: layoutExtent,
    );
  }
}
