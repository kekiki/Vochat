import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/widgets/colive_round_image_widget.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/extensions/colive_api_response_ext.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:colive/services/static/colive_styles.dart';

import '../../../common/event_bus/colive_event_bus.dart';
import '../../../home_anchors/widgets/colive_anchor_age_widget.dart';
import '../../../services/api/colive_api_client.dart';
import '../../../services/database/colive_database.dart';
import '../../../services/managers/colive_event_bus_event.dart';
import '../../../services/models/colive_anchor_model.dart';
import '../../../services/models/colive_api_response.dart';
import '../../../services/models/colive_follow_model.dart';
import '../../../services/repositories/colive_anchor_repository.dart';
import '../../../services/routes/colive_routes.dart';
import '../../../services/widgets/colive_empty_widget.dart';
import '../../../services/widgets/colive_refresh_footer.dart';
import '../../../services/widgets/colive_refresh_header.dart';

class ColiveFollowingListWidget extends StatefulWidget {
  const ColiveFollowingListWidget({super.key});

  @override
  State<ColiveFollowingListWidget> createState() =>
      _ColiveFollowingListWidgetState();
}

class _ColiveFollowingListWidgetState
    extends State<ColiveFollowingListWidget>
    with AutomaticKeepAliveClientMixin {
// data
  final List<StreamSubscription> subsriptions = [];
  final _apiClient = Get.find<ColiveApiClient>();

  List<ColiveAnchorModel> _anchorList = [];
  bool _isNoData = false;
  bool _isLoadFailed = false;

  final _refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  int _currentPage = 1;
  final int _pageSize = 20;

  @override
  void initState() {
    super.initState();
    _setupListener();
  }

  @override
  void dispose() {
    super.dispose();
    _removeListener();
  }

  @override
  void didUpdateWidget(covariant ColiveFollowingListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setupListener();
  }

  void _setupListener() {
    _removeListener();
    subsriptions.add(ColiveEventBus.instance
        .on<ColiveFollowRefreshEvent>()
        .listen((event) {
      _onRefresh();
    }));
  }

  void _removeListener() {
    for (var stream in subsriptions) {
      stream.cancel();
    }
    subsriptions.clear();
  }

  void _onRefresh() async {
    try {
      _currentPage = 1;
      final result = await _fetchAnchorList(
        page: _currentPage,
        size: _pageSize,
      );
      final data = result.data;
      if (!result.isSuccess || data == null) {
        _isLoadFailed = _anchorList.isEmpty;
        if (mounted) setState(() {});
        _refreshController.finishRefresh(IndicatorResult.fail);
        return;
      }
      _anchorList = data.map((e) {
        return e.toAnchorModel.copyWith(isLike: true);
      }).toList();
      _isNoData = _anchorList.isEmpty;
      _isLoadFailed = false;
      if (mounted) setState(() {});
      _refreshController.finishRefresh(IndicatorResult.success);
    } catch (e) {
      _isLoadFailed = _anchorList.isEmpty;
      if (mounted) setState(() {});
      _refreshController.finishRefresh(IndicatorResult.fail);
    }
  }

  void _onLoadMore() async {
    try {
      _currentPage++;
      final result = await _fetchAnchorList(
        page: _currentPage,
        size: _pageSize,
      );
      final data = result.data;
      if (!result.isSuccess || data == null) {
        _refreshController.finishLoad(IndicatorResult.fail);
        _currentPage--;
        return;
      }
      _anchorList.addAll(data.map((e) => e.toAnchorModel).toList());
      if (mounted) setState(() {});
      _refreshController.finishLoad(
          data.isNotEmpty ? IndicatorResult.success : IndicatorResult.noMore);
    } catch (e) {
      _refreshController.finishLoad(IndicatorResult.fail);
      _currentPage--;
    }
  }

  Future<ColiveApiResponse<List<ColiveFollowModel>>> _fetchAnchorList({
    required int page,
    required int size,
  }) async {
    final anchorRes = await _apiClient
        .fetchFollowList(
          '$page',
          '$size',
        )
        .response;
    if (anchorRes.isSuccess && anchorRes.data != null) {
      _saveAnchorList(anchorRes.data!);
    }
    return anchorRes;
  }

  Future<void> _saveAnchorList(List<ColiveFollowModel> list) async {
    final database = Get.find<ColiveDatabase>();
    for (var element in list) {
      final anchor = await database.anchorDao.findAnchorById(element.followId);
      if (anchor == null) {
        database.anchorDao.insertAnchor(element.toAnchorModel);
      }
    }
  }

  void _onTapAnchor(ColiveAnchorModel anchor) {
    Get.toNamed(ColiveRoutes.anchorDetail, arguments: anchor);
  }

  void _onTapFollowed(ColiveAnchorModel anchor) {
    final repository = Get.find<ColiveAnchorRepository>();
    repository.requestFollow(anchor: anchor);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.pt),
      child: EasyRefresh.builder(
        refreshOnStart: true,
        controller: _refreshController,
        header: ColiveRefreshHeader.classic(),
        footer: ColiveRefreshFooter.classic(),
        onRefresh: _onRefresh,
        onLoad: _onLoadMore,
        childBuilder: (context, physics) {
          return CustomScrollView(
            physics: physics,
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 6.pt)),
              SliverToBoxAdapter(
                child: Visibility(
                  visible: _isNoData,
                  child: ColiveEmptyWidget(text: 'colive_no_data'.tr),
                ),
              ),
              SliverToBoxAdapter(
                child: Visibility(
                  visible: _isLoadFailed,
                  child: ColiveEmptyWidget(text: 'colive_no_network'.tr),
                ),
              ),
              SliverList.builder(
                itemCount: _anchorList.length,
                itemBuilder: (context, index) {
                  final anchor = _anchorList[index];
                  return _buildFollowItem(anchor);
                },
              ),
              SliverToBoxAdapter(child: SizedBox(height: 15.pt)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFollowItem(ColiveAnchorModel anchor) {
    return GestureDetector(
      onTap: () => _onTapAnchor(anchor),
      child: SizedBox(
        height: 66.pt,
        child: Row(
          children: [
            ColiveRoundImageWidget(
              anchor.avatar,
              width: 46.pt,
              height: 46.pt,
              isCircle: true,
              placeholder: Assets.imagesColiveAvatarAnchor,
            ),
            SizedBox(width: 10.pt),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: AutoSizeText(
                      anchor.nickname,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      minFontSize: 8,
                      style: ColiveStyles.title16w600,
                    ),
                  ),
                  SizedBox(width: 8.pt),
                  ColiveAnchorAgeWidget(anchor: anchor),
                ],
              ),
            ),
            SizedBox(width: 20.pt),
            InkWell(
              onTap: () => _onTapFollowed(anchor),
              borderRadius: BorderRadius.circular(12.pt),
              child: Container(
                width: 78.pt,
                height: 24.pt,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 6.pt),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.pt),
                  border: Border.all(color: ColiveColors.primaryColor),
                ),
                child: AutoSizeText(
                  'colive_followed'.tr,
                  maxLines: 1,
                  minFontSize: 8,
                  style: ColiveStyles.body12w400.copyWith(
                    color: ColiveColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
