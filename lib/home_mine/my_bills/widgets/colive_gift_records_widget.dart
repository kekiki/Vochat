import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/utils/colive_format_util.dart';
import 'package:colive/services/extensions/colive_api_response_ext.dart';
import 'package:colive/services/static/colive_styles.dart';

import '../../../generated/assets.dart';
import '../../../services/api/colive_api_client.dart';
import '../../../services/models/colive_gift_record_model.dart';
import '../../../services/static/colive_colors.dart';
import '../../../services/widgets/colive_empty_widget.dart';
import '../../../services/widgets/colive_refresh_footer.dart';
import '../../../services/widgets/colive_refresh_header.dart';

class ColiveGiftRecordsWidget extends StatefulWidget {
  const ColiveGiftRecordsWidget({super.key});

  @override
  State<ColiveGiftRecordsWidget> createState() =>
      _ColiveGiftRecordsWidgetState();
}

class _ColiveGiftRecordsWidgetState extends State<ColiveGiftRecordsWidget>
    with AutomaticKeepAliveClientMixin {
  final _apiClient = Get.find<ColiveApiClient>();

  List<ColiveGiftRecordModel> _recordList = [];
  bool _isNoData = false;
  bool _isLoadFailed = false;

  final _refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  int _currentPage = 1;
  final int _pageSize = 20;

  void _onRefresh() async {
    try {
      _currentPage = 1;
      final result = await _apiClient
          .fetchGiftRecordList('$_currentPage', '$_pageSize')
          .response;
      final data = result.data;
      if (!result.isSuccess || data == null) {
        _isLoadFailed = _recordList.isEmpty;
        if (mounted) setState(() {});
        _refreshController.finishRefresh(IndicatorResult.fail);
        return;
      }
      _recordList = data;
      _isNoData = _recordList.isEmpty;
      _isLoadFailed = false;
      if (mounted) setState(() {});
      _refreshController.finishRefresh(IndicatorResult.success);
    } catch (e) {
      _isLoadFailed = _recordList.isEmpty;
      if (mounted) setState(() {});
      _refreshController.finishRefresh(IndicatorResult.fail);
    }
  }

  void _onLoadMore() async {
    try {
      _currentPage++;
      final result = await _apiClient
          .fetchGiftRecordList('$_currentPage', '$_pageSize')
          .response;
      final data = result.data;
      if (!result.isSuccess || data == null) {
        _refreshController.finishLoad(IndicatorResult.fail);
        _currentPage--;
        return;
      }
      _recordList.addAll(data);
      if (mounted) setState(() {});
      _refreshController.finishLoad(
          data.isNotEmpty ? IndicatorResult.success : IndicatorResult.noMore);
    } catch (e) {
      _refreshController.finishLoad(IndicatorResult.fail);
      _currentPage--;
    }
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
              SliverList.separated(
                itemCount: _recordList.length,
                itemBuilder: (context, index) {
                  final record = _recordList[index];
                  return _buildRecordItem(record);
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 0.5,
                    indent: 15.pt,
                    endIndent: 15.pt,
                    color: ColiveColors.separatorLineColor,
                  );
                },
              ),
              SliverToBoxAdapter(child: SizedBox(height: 15.pt)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRecordItem(ColiveGiftRecordModel record) {
    return SizedBox(
      height: 76.pt,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: AutoSizeText(
                        record.nickname,
                        maxLines: 1,
                        minFontSize: 8,
                        overflow: TextOverflow.ellipsis,
                        style: ColiveStyles.title14w600,
                      ),
                    ),
                    SizedBox(width: 8.pt),
                  ],
                ),
                SizedBox(height: 4.pt),
                Text(
                  ColiveFormatUtil.millisecondsToTime(
                      record.createTime * 1000),
                  style: ColiveStyles.body12w400.copyWith(
                    color: ColiveColors.grayTextColor,
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Image.asset(
                    Assets.imagesColiveDiamond,
                    width: 14.pt,
                    height: 14.pt,
                  ),
                  SizedBox(width: 4.pt),
                  Text(
                    '${min(0, -record.diamonds)}',
                    style: ColiveStyles.body14w600.copyWith(
                      color: ColiveColors.accentColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.pt),
              Text(
                '${'colive_gift'.tr}: ${record.giftName}',
                style: ColiveStyles.body10w400.copyWith(
                  color: ColiveColors.grayTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
