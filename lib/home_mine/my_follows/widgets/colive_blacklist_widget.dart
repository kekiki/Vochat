import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/widgets/colive_round_image_widget.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/extensions/colive_api_response_ext.dart';
import 'package:colive/services/managers/colive_profile_manager.dart';
import 'package:colive/services/static/colive_styles.dart';

import '../../../home_anchors/widgets/colive_anchor_age_widget.dart';
import '../../../services/api/colive_api_client.dart';
import '../../../services/database/colive_database.dart';
import '../../../services/models/colive_anchor_model.dart';
import '../../../services/models/colive_api_response.dart';
import '../../../services/models/colive_block_model.dart';
import '../../../services/repositories/colive_anchor_repository.dart';
import '../../../services/routes/colive_routes.dart';
import '../../../services/widgets/colive_empty_widget.dart';
import '../../../services/widgets/colive_refresh_footer.dart';
import '../../../services/widgets/colive_refresh_header.dart';

class ColiveBlacklistWidget extends StatefulWidget {
  const ColiveBlacklistWidget({super.key});

  @override
  State<ColiveBlacklistWidget> createState() =>
      _ColiveBlacklistWidgetState();
}

class _ColiveBlacklistWidgetState extends State<ColiveBlacklistWidget>
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
  void didUpdateWidget(covariant ColiveBlacklistWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setupListener();
  }

  void _setupListener() {
    _removeListener();
    subsriptions
        .add(ColiveProfileManager.instance.profileStream.listen((event) {
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
        return e.toAnchorModel.copyWith(
          isBlock: true,
        );
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

  Future<ColiveApiResponse<List<ColiveBlockModel>>> _fetchAnchorList({
    required int page,
    required int size,
  }) async {
    final anchorRes = await _apiClient
        .fetchBlockList(
          '$page',
          '$size',
        )
        .response;
    if (anchorRes.isSuccess && anchorRes.data != null) {
      _saveAnchorList(anchorRes.data!);
    }
    return anchorRes;
  }

  Future<void> _saveAnchorList(List<ColiveBlockModel> list) async {
    final database = Get.find<ColiveDatabase>();
    for (var element in list) {
      final anchor = await database.anchorDao.findAnchorById(element.blockId);
      if (anchor == null) {
        database.anchorDao.insertAnchor(element.toAnchorModel);
      }
    }
  }

  void _onTapAnchor(ColiveAnchorModel anchor) {
    Get.toNamed(ColiveRoutes.anchorDetail, arguments: anchor);
  }

  void _onTapUnblock(ColiveAnchorModel anchor) {
    final repository = Get.find<ColiveAnchorRepository>();
    repository.requestBlock(anchor: anchor);
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
              onTap: () => _onTapUnblock(anchor),
              borderRadius: BorderRadius.circular(12.pt),
              child: Container(
                width: 40.pt,
                height: 40.pt,
                alignment: Alignment.center,
                child: Image.asset(
                  Assets.imagesColiveUnblock,
                  width: 24.pt,
                  height: 24.pt,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
