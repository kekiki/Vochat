import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/static/colive_styles.dart';

class ColiveFilterAreaDialog extends StatelessWidget {
  const ColiveFilterAreaDialog({
    super.key,
    required this.currentArea,
    required this.areaList,
  });

  final String currentArea;
  final List areaList;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PositionedDirectional(
          top: 44.pt,
          end: 36.pt,
          child: Image.asset(
            Assets.imagesColiveHomeFilterTopTriangle,
            width: 15.pt,
            height: 7.pt,
            fit: BoxFit.cover,
          ),
        ),
        PositionedDirectional(
          top: 50.pt,
          end: 15.pt,
          child: Container(
            width: 140.pt,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.pt),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final area = areaList[index];
                return InkWell(
                  onTap: () => Get.back(result: area),
                  child: Container(
                    height: 40.pt,
                    alignment: Alignment.center,
                    child: Text(
                      area,
                      style: ColiveStyles.body14w400.copyWith(
                        color: currentArea == area
                            ? ColiveColors.primaryColor
                            : ColiveColors.primaryTextColor,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: ColiveColors.separatorLineColor,
                  height: 0.5.pt,
                );
              },
              itemCount: areaList.length,
            ),
          ),
        ),
      ],
    );
  }
}
