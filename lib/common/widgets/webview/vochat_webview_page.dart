import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../common/adapts/vochat_colors.dart';
import '../../../common/adapts/vochat_screen_adapt.dart';
import '../../../common/adapts/vochat_styles.dart';
import '../vochat_app_bar.dart';
import '../vochat_app_scaffold.dart';
import 'vochat_webview_controller.dart';

class VochatWebviewPage extends StatelessWidget {
  const VochatWebviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VochatWebviewController>(
      init: VochatWebviewController(),
      builder: (controller) {
        return VochatAppScaffold(
          backgroundColor: Colors.white,
          appBar: VochatAppBar(
            center: Text(
              controller.title,
              style: VochatStyles.title18w700,
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
                      color: VochatColors.primaryColor,
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
