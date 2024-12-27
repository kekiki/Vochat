import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/utils/colive_loading_util.dart';
import 'package:colive/common/widgets/colive_button_widget.dart';
import 'package:colive/common/widgets/colive_round_image_widget.dart';
import 'package:colive/services/models/colive_channel_item_model.dart';
import 'package:colive/services/models/colive_country_item_model.dart';
import 'package:colive/services/models/colive_product_base_model.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:colive/services/topup/colive_topup_service.dart';
import 'package:sprintf/sprintf.dart';

import '../../extensions/colive_preference_ext.dart';
import '../../static/colive_styles.dart';
import 'colive_topup_channel_header.dart';

class ColiveTopupChannelDialog extends StatefulWidget {
  const ColiveTopupChannelDialog({
    super.key,
    required this.product,
    required this.channelList,
    required this.country,
  });

  final ColiveProductItemModel product;
  final List<ColiveChannelItemModel> channelList;
  final ColiveCountryItemModel country;

  @override
  State<ColiveTopupChannelDialog> createState() =>
      _ColiveTopupChannelDialogState();
}

class _ColiveTopupChannelDialogState extends State<ColiveTopupChannelDialog> {
  final _countryList = ColiveTopupService.instance.countryList;
  final List<GlobalKey> _countryKeyList = [];
  late List<ColiveChannelItemModel> channelList;
  late ColiveCountryItemModel currentCountry;
  bool isShowCountries = false;

  @override
  void initState() {
    currentCountry = widget.country;
    channelList = widget.channelList;
    for (var _ in _countryList) {
      _countryKeyList.add(GlobalKey());
    }
    super.initState();
  }

  void _onTapCountry() {
    isShowCountries = !isShowCountries;
    setState(() {});

    if (!isShowCountries) return;
    Future.delayed(const Duration(milliseconds: 100), () {
      final index =
          _countryList.indexWhere((e) => e.code == currentCountry.code);
      if (index >= 0) {
        final context = _countryKeyList[index].currentContext;
        if (context == null) return;
        Scrollable.ensureVisible(
          // ignore: use_build_context_synchronously
          context,
          duration: const Duration(milliseconds: 150),
          alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
        );
      }
    });
  }

  void _onTapChannel(ColiveChannelItemModel channel) {
    Get.back(result: channel);
  }

  void _onSelectedCountry(ColiveCountryItemModel country) async {
    if (currentCountry == country) {
      isShowCountries = false;
      setState(() {});
      return;
    }
    currentCountry = country;
    isShowCountries = false;
    ColiveAppPreferenceExt.currentTopupCountryCode = country.code;
    setState(() {});
    ColiveLoadingUtil.show();
    final result = await ColiveTopupService.instance.fetchChannelList(
      productId: widget.product.id.toString(),
      country: country.code,
    );
    ColiveLoadingUtil.dismiss();
    if (result.isSuccess) {
      channelList = result.data ?? [];
      if (mounted) setState(() {});
    } else {
      ColiveLoadingUtil.showToast(result.msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ColiveScreenAdapt.screenHeight * 0.7,
      width: ColiveScreenAdapt.screenWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.pt),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              SizedBox(height: 16.pt),
              ColiveTopupChannelHeader(
                product: widget.product,
                country: currentCountry,
                onTapCountry: _onTapCountry,
              ),
              SizedBox(height: 21.pt),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 15.pt),
                child: Text(
                  'colive_payment_method'.tr,
                  style: ColiveStyles.body12w400.copyWith(
                    color: ColiveColors.grayTextColor,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: channelList.length,
                  itemBuilder: (context, index) {
                    final channel = channelList[index];
                    return _buildChannelItemWidget(channel);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 1.pt,
                      thickness: 1.pt,
                      indent: 15.pt,
                      endIndent: 15.pt,
                      color: ColiveColors.separatorLineColor,
                    );
                  },
                ),
              ),
            ],
          ),
          PositionedDirectional(
            top: 62.pt,
            start: 15.pt,
            end: 15.pt,
            child: Visibility(
              visible: isShowCountries,
              child: _buildCountryListWidget(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChannelItemWidget(ColiveChannelItemModel channel) {
    return Container(
      height: 60.pt,
      padding: EdgeInsets.symmetric(horizontal: 15.pt),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ColiveRoundImageWidget(
            channel.logo,
            width: 32.pt,
            height: 32.pt,
            fit: BoxFit.contain,
            placeholderWidget: const SizedBox.shrink(),
          ),
          SizedBox(width: 8.pt),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                channel.channelName,
                style: ColiveStyles.title14w600,
              ),
              Visibility(
                visible: channel.discountCouponNum > 0,
                child: Padding(
                  padding: EdgeInsets.only(top: 3.pt),
                  child: Text(
                    'colive_%s_off'.trArgs(['${channel.discountCouponNum}%']),
                    style: ColiveStyles.body12w400.copyWith(
                      color: ColiveColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          ColiveButtonWidget(
            onPressed: () => _onTapChannel(channel),
            width: 116.pt,
            height: 36.pt,
            backgroundColor: ColiveColors.primaryColor,
            borderRadius: 18.pt,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.pt),
              child: AutoSizeText(
                sprintf("${channel.currency} %.2f", [channel.price.toDouble()]),
                maxLines: 1,
                minFontSize: 8,
                style: ColiveStyles.body16w400.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountryListWidget() {
    return Container(
      width: 345.pt,
      height: 345.pt,
      padding: EdgeInsets.all(14.pt),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.pt),
        color: rgba(0, 0, 0, 0.9),
      ),
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 12.pt,
          runSpacing: 14.pt,
          children: _buildCountryList(),
        ),
      ),
    );
  }

  List<Widget> _buildCountryList() {
    final List<Widget> widgetList = [];
    for (var i = 0; i < _countryList.length; i++) {
      final country = _countryList[i];
      final key = _countryKeyList[i];
      widgetList.add(_buildCountryItemWidget(country, key));
    }
    return widgetList;
  }

  Widget _buildCountryItemWidget(
      ColiveCountryItemModel country, GlobalKey key) {
    final isSelected = country.code == currentCountry.code;
    return GestureDetector(
      onTap: () => _onSelectedCountry(country),
      child: Container(
        key: key,
        height: 30.pt,
        padding: EdgeInsets.symmetric(horizontal: 10.pt),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(33.pt),
          color: isSelected ? ColiveColors.primaryColor : Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColiveRoundImageWidget(
              country.logo,
              width: 16.pt,
              height: 16.pt,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 4.pt),
            Flexible(
              child: Text(
                country.showName,
                style: ColiveStyles.body12w400.copyWith(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  color:
                      isSelected ? Colors.white : ColiveColors.primaryTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
