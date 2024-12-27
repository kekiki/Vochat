import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../common/adapts/colive_screen_adapt.dart';
import '../colive_app_bar.dart';
import '../colive_app_scaffold.dart';
import '../../static/colive_styles.dart';
import 'colive_webview_controller.dart';

class ColiveWebviewPage extends StatelessWidget {
  const ColiveWebviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColiveWebviewController>(
      init: ColiveWebviewController(),
      builder: (controller) {
        return ColiveAppScaffold(
          backgroundColor: Colors.white,
          appBar: ColiveAppBar(
            center: Text(
              controller.title,
              style: ColiveStyles.title18w700,
            ),
          ),
          body: Stack(
            children: [
              Positioned.fill(
                child: WebViewWidget(
                  controller: controller.webViewController,
                ),
              ),
              PositionedDirectional(
                top: 0,
                start: 0,
                end: 0,
                child: Obx(() {
                  return Visibility(
                    visible: controller.progressObs.value < 100,
                    child: LinearProgressIndicator(
                      minHeight: 2.pt,
                      value: controller.progressObs.value / 100,
                      backgroundColor: Colors.transparent,
                      color: ColiveColors.primaryColor,
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
