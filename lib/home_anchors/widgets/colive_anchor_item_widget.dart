import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/static/colive_styles.dart';
import 'package:colive/home_anchors/widgets/colive_anchor_status_widget.dart';
import 'package:colive/common/widgets/colive_round_image_widget.dart';

import '../../services/database/colive_database.dart';
import '../../services/models/colive_anchor_model.dart';
import '../../services/static/colive_colors.dart';
import 'colive_anchor_country_widget.dart';
import 'colive_anchor_price_widget.dart';
import 'colive_free_call_sign.dart';

class ColiveAnchorItemWidget extends StatefulWidget {
  const ColiveAnchorItemWidget({
    super.key,
    required this.anchor,
    required this.onTapAnchor,
    required this.onTapCall,
    required this.onTapChat,
  });

  final ColiveAnchorModel anchor;
  final ValueChanged<ColiveAnchorModel> onTapAnchor;
  final ValueChanged<ColiveAnchorModel> onTapCall;
  final ValueChanged<ColiveAnchorModel> onTapChat;

  @override
  State<ColiveAnchorItemWidget> createState() => _ColiveAnchorItemWidgetState();
}

class _ColiveAnchorItemWidgetState extends State<ColiveAnchorItemWidget> {
  final List<StreamSubscription> _streams = [];
  final anchorDao = Get.find<ColiveDatabase>().anchorDao;
  late ColiveAnchorModel _anchor;

  @override
  void initState() {
    _anchor = widget.anchor;
    super.initState();
    _setupListener();
  }

  @override
  void dispose() {
    _clear();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ColiveAnchorItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _anchor = widget.anchor;
    _setupListener();
  }

  void _setupListener() {
    _clear();
    _streams
        .add(anchorDao.findAnchorByIdAsStream(_anchor.id).listen((anchorInfo) {
      if (anchorInfo == null) return;
      _anchor = anchorInfo;
      if (mounted) setState(() {});
    }));
  }

  void _clear() {
    for (var stream in _streams) {
      stream.cancel();
    }
    _streams.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => widget.onTapAnchor(_anchor),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.pt),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColiveRoundImageWidget(
              _anchor.avatar,
              width: 168.pt,
              height: 200.pt,
              placeholder: Assets.imagesColiveAvatarAnchor,
            ),
            PositionedDirectional(
              start: 0,
              end: 0,
              bottom: 0,
              height: 100.pt,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.vertical(
                    bottom: Radius.circular(12.pt),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.5)],
                  ),
                ),
              ),
            ),
            PositionedDirectional(
              top: 6.pt,
              start: 6.pt,
              child: ColiveAnchorStatusWidget(anchor: _anchor),
            ),
            PositionedDirectional(
              top: 6.pt,
              end: 6.pt,
              child: ColiveAnchorCountryWidget(anchor: _anchor),
            ),
            PositionedDirectional(
              bottom: 0,
              end: 0,
              width: 80.pt,
              height: 80.pt,
              child: Image.asset(Assets.imagesColiveHomeCallBg),
            ),
            PositionedDirectional(
              start: 6.pt,
              end: 0,
              bottom: 0,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _anchor.nickname,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: ColiveStyles.body14w400.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4.pt),
                        ColiveAnchorPriceWidget(anchor: _anchor),
                        SizedBox(height: 4.pt),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 48.pt,
                    height: 48.pt,
                    child: Visibility(
                      visible: _anchor.isOnline,
                      replacement: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => widget.onTapChat(_anchor),
                        icon: Image.asset(Assets.imagesColiveHomeChatIcon),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => widget.onTapCall(_anchor),
                        icon: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Image.asset(Assets.imagesColiveHomeCallIcon),
                            const ColiveFreeCallSign(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
