import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/services/static/colive_styles.dart';

import '../../services/repositories/colive_card_repository.dart';

class ColiveFreeCallSign extends StatefulWidget {
  const ColiveFreeCallSign(
      {super.key, this.visible = false, this.top, this.end});

  final bool visible;
  final double? top;
  final double? end;

  @override
  State<ColiveFreeCallSign> createState() => _ColiveFreeCallSignState();
}

class _ColiveFreeCallSignState extends State<ColiveFreeCallSign> {
  final _cardRepository = Get.find<ColiveCardRepository>();
  final List<StreamSubscription> _streams = [];
  bool _hasFreeCallCard = false;

  @override
  void initState() {
    super.initState();
    _setupListener();
  }

  @override
  void dispose() {
    _clear();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ColiveFreeCallSign oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setupListener();
  }

  void _setupListener() {
    _clear();
    _streams.add(_cardRepository.getCardList().listen((list) {
      if (list == null) return;
      _hasFreeCallCard = list.any((element) => element.isFreeCallCard);
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
    return Visibility(
      visible: widget.visible || _hasFreeCallCard,
      child: PositionedDirectional(
        top: widget.top ?? -10.pt,
        end: widget.end ?? 0,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 3.pt, horizontal: 8.pt),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(11.pt),
              topEnd: Radius.circular(11.pt),
              bottomEnd: Radius.circular(11.pt),
              bottomStart: Radius.circular(4.pt),
            ),
          ),
          child: Text(
            'colive_free'.tr,
            style: ColiveStyles.body10w400.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
