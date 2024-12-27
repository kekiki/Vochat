import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/static/colive_styles.dart';

import '../../../services/static/colive_colors.dart';

class ColiveChatVipBanner extends StatelessWidget {
  const ColiveChatVipBanner({
    super.key,
    required this.chatNum,
    this.onTap,
    this.onTapClose,
  });

  final int chatNum;
  final VoidCallback? onTap;
  final VoidCallback? onTapClose;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(8.pt),
        height: 64.pt,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.pt),
          gradient: ColiveColors.mainGradient,
        ),
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(width: 10.pt),
                Image.asset(
                  Assets.imagesColiveChatVipBannerIcon,
                  width: 34.pt,
                  height: 34.pt,
                ),
                SizedBox(width: 10.pt),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        chatNum > 0
                            ? 'colive_chat_vip_%s_limit'
                                .trArgs([chatNum.toString()])
                            : 'colive_chat_vip_runout'.tr,
                        maxLines: 2,
                        minFontSize: 8,
                        style: ColiveStyles.title12w700.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      AutoSizeText(
                        'colive_chat_vip_tip'.tr,
                        maxLines: 1,
                        minFontSize: 8,
                        style: ColiveStyles.body10w400.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.pt),
                Container(
                  width: 90.pt,
                  height: 26.pt,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 8.pt),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13.pt),
                  ),
                  child: AutoSizeText(
                    'colive_become_vip'.tr,
                    maxLines: 1,
                    minFontSize: 8,
                    style: ColiveStyles.title12w700.copyWith(
                      color: ColiveColors.primaryColor,
                    ),
                  ),
                ),
                SizedBox(width: 20.pt),
              ],
            ),
            PositionedDirectional(
              top: 0,
              end: 0,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onTapClose,
                child: Container(
                  width: 24.pt,
                  height: 24.pt,
                  alignment: Alignment.center,
                  child: Image.asset(
                    Assets.imagesColiveDialogClose,
                    width: 12.pt,
                    height: 12.pt,
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
