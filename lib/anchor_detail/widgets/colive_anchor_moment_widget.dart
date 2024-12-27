import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/static/colive_styles.dart';
import 'package:colive/common/widgets/colive_round_image_widget.dart';

import '../../common/utils/colive_format_util.dart';
import '../../media/colive_media_model.dart';
import '../../services/database/colive_database.dart';
import '../../services/widgets/dialogs/colive_dialog_util.dart';
import '../../services/widgets/dialogs/report/colive_report_dialog.dart';
import '../../services/models/colive_anchor_model.dart';
import '../../services/models/colive_moment_item_model.dart';
import '../../services/routes/colive_routes.dart';
import '../../services/static/colive_colors.dart';

class ColiveAnchorMomentidget extends StatefulWidget {
  const ColiveAnchorMomentidget({
    super.key,
    required this.moment,
  });

  final ColiveMomentItemModel moment;

  @override
  State<ColiveAnchorMomentidget> createState() =>
      _ColiveAnchorMomentidgetState();
}

class _ColiveAnchorMomentidgetState extends State<ColiveAnchorMomentidget> {
  late ColiveMomentItemModel _moment;
  late ColiveAnchorModel _anchor;
  final List<StreamSubscription> _streams = [];

  final _anchorDao = Get.find<ColiveDatabase>().anchorDao;
  final _momentDao = Get.find<ColiveDatabase>().momentDao;

  @override
  void initState() {
    _moment = widget.moment;
    _anchor = _moment.toAnchorModel;
    super.initState();

    _setupLikeInfo();
    _setupListener();
  }

  @override
  void dispose() {
    _clear();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ColiveAnchorMomentidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setupListener();
  }

  void _setupLikeInfo() async {
    final localMoment = await _momentDao.findMomentById(_moment.id);
    if (localMoment != null) {
      _moment = _moment.copyWith(
        isLike: localMoment.isLike,
        likeNum: max(_moment.likeNum, localMoment.likeNum),
      );
      if (mounted) setState(() {});
    }
  }

  void _setupListener() {
    _clear();
    _streams
        .add(_anchorDao.findAnchorByIdAsStream(_anchor.id).listen((anchorInfo) {
      if (anchorInfo == null) return;
      _anchor = anchorInfo;
      if (mounted) setState(() {});
    }));
    _streams
        .add(_momentDao.findMomentByIdAsStream(_moment.id).listen((momentInfo) {
      if (momentInfo == null) return;
      _moment = momentInfo;
      if (mounted) setState(() {});
    }));
  }

  void _clear() {
    for (var stream in _streams) {
      stream.cancel();
    }
    _streams.clear();
  }

  void _onTapImage(List<String> images, int index) {
    final mediaList = images.map((e) {
      return ColiveMediaModel(type: ColiveMediaType.photo, path: e);
    }).toList();
    Get.toNamed(ColiveRoutes.media, arguments: {
      'index': index,
      'list': mediaList,
    });
  }

  void _onTapLike() {
    if (_moment.isLike) {
      _moment = _moment.copyWith(
        isLike: false,
        likeNum: max(0, _moment.likeNum - 1),
      );
    } else {
      _moment = _moment.copyWith(
        isLike: true,
        likeNum: _moment.likeNum + 1,
      );
    }
    if (mounted) setState(() {});
    _momentDao.insertMoment(_moment);
  }

  void _onTapReport() {
    ColiveDialogUtil.showDialog(
      const ColiveReportDialog(),
      arguments: _anchor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 14.pt),
          child: Text(
            _moment.content,
            style: ColiveStyles.body14w400.copyWith(
              color: ColiveColors.secondTextColor,
            ),
          ),
        ),
        SizedBox(height: 12.pt),
        _buildImagesWidget(),
        Row(
          children: [
            SizedBox(width: 14.pt),
            Text(
              ColiveFormatUtil.millisecondsToDate(_moment.createTime * 1000),
              style: ColiveStyles.body12w400.copyWith(
                color: ColiveColors.secondTextColor.withOpacity(0.5),
              ),
            ),
            const Spacer(),
            IconButton(
              iconSize: 20.pt,
              onPressed: _onTapLike,
              icon: Row(
                children: [
                  Image.asset(
                    Assets.imagesColiveHeart,
                    width: 16.pt,
                    height: 16.pt,
                    color: _moment.isLike
                        ? rgba(255, 62, 93, 1)
                        : rgba(185, 195, 207, 1),
                  ),
                  SizedBox(width: 4.pt),
                  Text(
                    _moment.likeNum.toString(),
                    style: ColiveStyles.body14w400.copyWith(
                      color: _moment.isLike
                          ? rgba(255, 62, 93, 1)
                          : rgba(185, 195, 207, 1),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              iconSize: 20.pt,
              onPressed: _onTapReport,
              icon: Image.asset(
                Assets.imagesColiveAppbarReport,
                width: 16.pt,
                height: 16.pt,
                color: rgba(185, 195, 207, 1),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImagesWidget() {
    final crossCount = _moment.images.length == 1
        ? 1
        : _moment.images.length == 2 || _moment.images.length == 4
            ? 2
            : 3;
    final imageSize = crossCount == 1
        ? 218.pt
        : crossCount == 2
            ? 159.pt
            : 100.pt;
    return GridView.builder(
      padding: EdgeInsetsDirectional.only(start: 15.pt, end: 160.pt),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _moment.images.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossCount,
        mainAxisSpacing: 6.pt,
        crossAxisSpacing: 6.pt,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _onTapImage(_moment.images, index),
          child: ColiveRoundImageWidget(
            _moment.images[index],
            placeholder: Assets.imagesColiveAvatarAnchor,
            width: imageSize,
            height: imageSize,
            borderRadius: BorderRadius.circular(12.pt),
          ),
        );
      },
    );
  }
}