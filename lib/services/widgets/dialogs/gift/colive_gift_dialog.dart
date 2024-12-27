import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/utils/colive_loading_util.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/managers/colive_profile_manager.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:colive/services/static/colive_styles.dart';

import '../../../../home_anchors/widgets/colive_anchor_tab_indicator.dart';
import 'colive_gift_icon_widget.dart';
import '../../../models/colive_gift_base_model.dart';
import '../../../managers/colive_gift_manager.dart';
import '../colive_dialog_util.dart';
import '../colive_quick_recharge_dialog.dart';

class ColiveGiftDialog extends StatefulWidget {
  const ColiveGiftDialog({
    super.key,
    required this.isCalling,
    required this.anchorId,
    required this.sessionId,
    this.conversationId = '',
  });

  final bool isCalling;
  final int anchorId;
  final String sessionId;
  final String conversationId;

  @override
  State<ColiveGiftDialog> createState() => _ColiveGiftDialogState();
}

class _ColiveGiftDialogState extends State<ColiveGiftDialog>
    with SingleTickerProviderStateMixin {
  var _profile = ColiveProfileManager.instance.userInfo;
  var _giftModel = ColiveGiftManager.instance.giftBaseModel;

  List<ColiveGiftItemModel> get _giftList => _giftModel.giftList;
  List<ColiveGiftItemModel> get _backpackList => _giftModel.backpackGiftList;

  int _selectedGiftIndex = -1;
  int _selectedBackpackIndex = -1;
  final List<StreamSubscription> _subsriptions = [];
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();

    _subsriptions
        .add(ColiveProfileManager.instance.profileStream.listen((event) {
      _profile = event;
      if (mounted) setState(() {});
    }));

    _refreshGiftList(ColiveGiftListType.all);
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (var element in _subsriptions) {
      element.cancel();
    }
    _subsriptions.clear();
    super.dispose();
  }

// refresh gift list
  Future<void> _refreshGiftList(ColiveGiftListType type) async {
    await ColiveGiftManager.instance.fetchGiftList(listType: type);
    _giftModel = ColiveGiftManager.instance.giftBaseModel;
    if (mounted) setState(() {});
  }

  void _onTapTopup() {
    ColiveDialogUtil.showDialog(
      const ColiveQuickRechargeDialog(isBalanceInsufficient: false),
    );
  }

  void _onTapSendGift(ColiveGiftItemModel gift, bool isBackpack) async {
    if (isBackpack) {
      ColiveLoadingUtil.show();
      final isSuccess = await ColiveGiftManager.instance.sendGift(
        gift: gift,
        anchorId: widget.anchorId,
        sessionId: widget.sessionId,
        isCalling: widget.isCalling,
        conversationId: widget.conversationId,
        isBackpackGift: isBackpack,
      );
      if (isSuccess) {
        await _refreshGiftList(ColiveGiftListType.backpack);
      }
      ColiveLoadingUtil.dismiss();
    } else {
      ColiveGiftManager.instance.sendGift(
        gift: gift,
        anchorId: widget.anchorId,
        sessionId: widget.sessionId,
        isCalling: widget.isCalling,
        conversationId: widget.conversationId,
        isBackpackGift: isBackpack,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360.pt,
      padding: EdgeInsets.symmetric(vertical: 8.pt, horizontal: 12.pt),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.vertical(
          top: Radius.circular(16.pt),
        ),
      ),
      child: Column(
        children: [
          _buildSegmentWidget(),
          SizedBox(height: 8.pt),
          Expanded(child: _buildTabListView()),
          SizedBox(
            height: 44.pt,
            child: Row(
              children: [
                Image.asset(Assets.imagesColiveDiamond,
                    width: 18.pt, height: 18.pt),
                SizedBox(width: 4.pt),
                Text(
                  _profile.diamonds.toString(),
                  style: ColiveStyles.body14w600,
                ),
                const Spacer(),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: _onTapTopup,
                  child: Container(
                    height: 30.pt,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 15.pt),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.pt),
                      border: Border.all(color: ColiveColors.primaryColor),
                    ),
                    child: Text(
                      'colive_topup'.tr,
                      style: ColiveStyles.body14w600.copyWith(
                        color: ColiveColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: ColiveScreenAdapt.navigationBarHeight,
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentWidget() {
    return Row(
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          dividerHeight: 0,
          unselectedLabelColor: ColiveColors.primaryTextColor.withOpacity(0.6),
          unselectedLabelStyle: ColiveStyles.title16w600,
          labelColor: ColiveColors.primaryTextColor,
          labelStyle: ColiveStyles.title16w700,
          indicatorSize: TabBarIndicatorSize.tab,
          padding: EdgeInsets.zero,
          labelPadding: EdgeInsetsDirectional.symmetric(horizontal: 10.pt),
          indicator: ColiveAnchorTabIndicator(
            tabController: _tabController,
          ),
          tabs: [
            Tab(
              text: 'colive_gift'.tr,
              iconMargin: EdgeInsets.zero,
            ),
            Tab(
              text: 'colive_backpack'.tr,
              iconMargin: EdgeInsets.zero,
            ),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: Get.back,
          child: Image.asset(
            Assets.imagesColiveDialogTopEndClose,
            width: 24.pt,
            height: 24.pt,
          ),
        ),
      ],
    );
  }

  Widget _buildTabListView() {
    return TabBarView(
      controller: _tabController,
      children: [
        GridView.builder(
          itemCount: _giftList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 88 / 100,
          ),
          itemBuilder: (context, index) {
            final item = _giftList[index];
            final isSelected = index == _selectedGiftIndex;
            return GestureDetector(
              onTap: () {
                if (isSelected) {
                  _onTapSendGift(item, false);
                } else {
                  _selectedGiftIndex = index;
                  setState(() {});
                }
              },
              child: _giftItemWidget(item, isSelected),
            );
          },
        ),
        Visibility(
          visible: _backpackList.isNotEmpty,
          replacement: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.imagesColiveIconNoData,
                width: 122.pt,
                height: 122.pt,
              ),
              SizedBox(height: 10.pt),
              Text(
                'colive_backpack_empty'.tr,
                style: ColiveStyles.body12w400.copyWith(
                  color: ColiveColors.grayTextColor,
                ),
              ),
            ],
          ),
          child: GridView.builder(
            itemCount: _backpackList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 88 / 100,
            ),
            itemBuilder: (context, index) {
              final item = _backpackList[index];
              final isSelected = index == _selectedBackpackIndex;
              return GestureDetector(
                onTap: () {
                  if (isSelected) {
                    _onTapSendGift(item, true);
                  } else {
                    _selectedBackpackIndex = index;
                    setState(() {});
                  }
                },
                child: _giftItemWidget(item, isSelected),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _giftItemWidget(ColiveGiftItemModel item, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.pt),
        border: Border.all(
          color: isSelected ? ColiveColors.primaryColor : Colors.transparent,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 8.pt),
          ColiveGiftIconWidget(item.id.toString(), item.logo),
          SizedBox(height: 8.pt),
          Visibility(
            visible: isSelected,
            replacement: AutoSizeText(
              item.backName,
              maxLines: 1,
              minFontSize: 8,
              style: ColiveStyles.body12w400,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.imagesColiveDiamond,
                  width: 13.pt,
                  height: 13.pt,
                ),
                SizedBox(width: 3.pt),
                Text(item.price.toString(), style: ColiveStyles.body10w400),
              ],
            ),
          ),
          SizedBox(height: 6.pt),
          Expanded(
            child: Visibility(
              visible: isSelected,
              replacement: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    Assets.imagesColiveDiamond,
                    width: 13.pt,
                    height: 13.pt,
                  ),
                  SizedBox(width: 3.pt),
                  Text(item.price.toString(), style: ColiveStyles.body10w400),
                ],
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: ColiveColors.primaryColor,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(8.pt))),
                child: Text(
                  'colive_send'.tr,
                  style: ColiveStyles.body12w400.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
