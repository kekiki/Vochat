import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/services/extensions/colive_api_response_ext.dart';
import 'package:colive/services/static/colive_styles.dart';

import '../../../common/widgets/colive_round_image_widget.dart';
import '../../../generated/assets.dart';
import '../../../services/api/colive_api_client.dart';
import '../../../services/models/colive_turntable_record_model.dart';
import '../../../services/static/colive_colors.dart';
import '../../../services/widgets/colive_empty_widget.dart';
import '../../../services/widgets/colive_refresh_footer.dart';
import '../../../services/widgets/colive_refresh_header.dart';

class ColiveLuckyDrawRecordsDialog extends StatefulWidget {
  const ColiveLuckyDrawRecordsDialog({super.key});

  @override
  State<ColiveLuckyDrawRecordsDialog> createState() =>
      _ColiveLuckyDrawRecordsDialogState();
}

class _ColiveLuckyDrawRecordsDialogState
    extends State<ColiveLuckyDrawRecordsDialog> {
  final _apiClient = Get.find<ColiveApiClient>();

  List<ColiveTurntableRecordModel> _recordList = [];
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
          .fetchTurntableRecordList('$_currentPage', '$_pageSize')
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
          .fetchTurntableRecordList('$_currentPage', '$_pageSize')
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
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.pt),
          width: double.infinity,
          height: 480.pt,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.pt),
          ),
          padding: EdgeInsets.symmetric(vertical: 24.pt),
          child: Column(
            children: [
              Text(
                'colive_records'.tr,
                style: ColiveStyles.title18w700,
              ),
              SizedBox(height: 12.pt),
              Expanded(
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
                        SliverToBoxAdapter(
                          child: Visibility(
                            visible: _isNoData,
                            child: ColiveEmptyWidget(
                                text: 'colive_no_data'.tr),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Visibility(
                            visible: _isLoadFailed,
                            child: ColiveEmptyWidget(
                                text: 'colive_no_network'.tr),
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
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.pt),
        IconButton(
          onPressed: Get.back,
          icon: Image.asset(
            Assets.imagesColiveDialogClose,
            width: 28.pt,
            height: 28.pt,
          ),
        ),
      ],
    );
  }

  Widget _buildRecordItem(ColiveTurntableRecordModel record) {
    return Container(
      height: 56.pt,
      padding: EdgeInsets.symmetric(horizontal: 15.pt),
      child: Row(
        children: [
          ColiveRoundImageWidget(
            record.img,
            width: 24.pt,
            height: 24.pt,
            placeholder: Assets.imagesColiveChatInputGift,
          ),
          SizedBox(width: 8.pt),
          Expanded(
            child: AutoSizeText(
              '${record.name} x${record.num}',
              maxLines: 1,
              minFontSize: 8,
              overflow: TextOverflow.ellipsis,
              style: ColiveStyles.body14w400,
            ),
          ),
          SizedBox(width: 8.pt),
          Text(
            record.time,
            style: ColiveStyles.body12w400.copyWith(
              color: ColiveColors.grayTextColor,
            ),
          )
        ],
      ),
    );
  }
}
