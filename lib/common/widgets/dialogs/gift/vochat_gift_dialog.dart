import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vochat/common/adapts/vochat_screen_adapt.dart';
import 'package:vochat/common/utils/vochat_loading_util.dart';
import 'package:vochat/common/generated/assets.dart';
import 'package:vochat/common/adapts/vochat_colors.dart';
import 'package:vochat/common/adapts/vochat_styles.dart';

import '../../../../common/widgets/vochat_anchor_tab_indicator.dart';
import '../../../../login/managers/vochat_profile_manager.dart';
import '../../../../services/managers/vochat_gift_manager.dart';
import '../../../../services/models/vochat_gift_base_model.dart';
import 'vochat_gift_icon_widget.dart';
import '../vochat_dialog_util.dart';
import '../vochat_quick_recharge_dialog.dart';

class VochatGiftDialog extends StatefulWidget {
  const VochatGiftDialog({
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
  State<VochatGiftDialog> createState() => _VochatGiftDialogState();
}

class _VochatGiftDialogState extends State<VochatGiftDialog>
    with SingleTickerProviderStateMixin {
  var _profile = VochatProfileManager.instance.userInfo;
  var _giftModel = VochatGiftManager.instance.giftBaseModel;

  List<VochatGiftItemModel> get _giftList => _giftModel.giftList;
  List<VochatGiftItemModel> get _backpackList => _giftModel.backpackGiftList;

  int _selectedGiftIndex = -1;
  int _selectedBackpackIndex = -1;
  final List<StreamSubscription> _subsriptions = [];
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();

    _subsriptions
        .add(VochatProfileManager.instance.profileStream.listen((event) {
      _profile = event;
      if (mounted) setState(() {});
    }));

    _refreshGiftList(VochatGiftListType.all);
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
  Future<void> _refreshGiftList(VochatGiftListType type) async {
    await VochatGiftManager.instance.fetchGiftList(listType: type);
    _giftModel = VochatGiftManager.instance.giftBaseModel;
    if (mounted) setState(() {});
  }

  void _onTapTopup() {
    VochatDialogUtil.showDialog(
      const VochatQuickRechargeDialog(isBalanceInsufficient: false),
    );
  }

  void _onTapSendGift(VochatGiftItemModel gift, bool isBackpack) async {
    if (isBackpack) {
      VochatLoadingUtil.show();
      final isSuccess = await VochatGiftManager.instance.sendGift(
        gift: gift,
        anchorId: widget.anchorId,
        sessionId: widget.sessionId,
        isCalling: widget.isCalling,
        conversationId: widget.conversationId,
        isBackpackGift: isBackpack,
      );
      if (isSuccess) {
        await _refreshGiftList(VochatGiftListType.backpack);
      }
      VochatLoadingUtil.dismiss();
    } else {
      VochatGiftManager.instance.sendGift(
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
                // Image.asset(Assets.imagesVochatDiamond,
                //     width: 18.pt, height: 18.pt),
                // SizedBox(width: 4.pt),
                Text(
                  _profile.mizuan.toString(),
                  style: VochatStyles.body14w600,
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
                      border: Border.all(color: VochatColors.primaryColor),
                    ),
                    child: Text(
                      'vochat_topup'.tr,
                      style: VochatStyles.body14w600.copyWith(
                        color: VochatColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: VochatScreenAdapt.navigationBarHeight,
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
          unselectedLabelColor: VochatColors.primaryTextColor.withOpacity(0.6),
          unselectedLabelStyle: VochatStyles.title16w600,
          labelColor: VochatColors.primaryTextColor,
          labelStyle: VochatStyles.title16w700,
          indicatorSize: TabBarIndicatorSize.tab,
          padding: EdgeInsets.zero,
          labelPadding: EdgeInsetsDirectional.symmetric(horizontal: 10.pt),
          indicator: VochatAnchorTabIndicator(
            tabController: _tabController,
          ),
          tabs: [
            Tab(
              text: 'vochat_gift'.tr,
              iconMargin: EdgeInsets.zero,
            ),
            Tab(
              text: 'vochat_backpack'.tr,
              iconMargin: EdgeInsets.zero,
            ),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: Get.back,
          child: Image.asset(
            Assets.imagesVochatDialogTopEndClose,
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
                Assets.imagesVochatIconNoData,
                width: 122.pt,
                height: 122.pt,
              ),
              SizedBox(height: 10.pt),
              Text(
                'vochat_backpack_empty'.tr,
                style: VochatStyles.body12w400.copyWith(
                  color: VochatColors.grayTextColor,
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

  Widget _giftItemWidget(VochatGiftItemModel item, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.pt),
        border: Border.all(
          color: isSelected ? VochatColors.primaryColor : Colors.transparent,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 8.pt),
          VochatGiftIconWidget(item.id.toString(), item.logo),
          SizedBox(height: 8.pt),
          Visibility(
            visible: isSelected,
            replacement: AutoSizeText(
              item.backName,
              maxLines: 1,
              minFontSize: 8,
              style: VochatStyles.body12w400,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset(
                //   Assets.imagesVochatDiamond,
                //   width: 13.pt,
                //   height: 13.pt,
                // ),
                // SizedBox(width: 3.pt),
                Text(item.price.toString(), style: VochatStyles.body10w400),
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
                  // Image.asset(
                  //   Assets.imagesVochatDiamond,
                  //   width: 13.pt,
                  //   height: 13.pt,
                  // ),
                  // SizedBox(width: 3.pt),
                  Text(item.price.toString(), style: VochatStyles.body10w400),
                ],
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: VochatColors.primaryColor,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(8.pt))),
                child: Text(
                  'vochat_send'.tr,
                  style: VochatStyles.body12w400.copyWith(
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
