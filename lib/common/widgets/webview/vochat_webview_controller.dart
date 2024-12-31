import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VochatWebviewController extends GetxController {
  late String url;
  late String title;

  final progressObs = 0.obs;
  late WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    url = arguments["url"];
    title = arguments["title"] ?? "";
    setWebViewController();
  }

  void setWebViewController() {
    webViewController = WebViewController.fromPlatformCreationParams(
        const PlatformWebViewControllerCreationParams());
    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            progressObs.value = progress;
          },
          onPageStarted: (String url) {
            progressObs.value = 0;
          },
          onPageFinished: (String url) {
            progressObs.value = 100;
          },
          onWebResourceError: (WebResourceError error) {},
          // onNavigationRequest: (NavigationRequest request) {
          //   final url = request.url.toLowerCase();
          //   if (url.startsWith("http://") || url.startsWith("https://")) {
          //     return NavigationDecision.navigate;
          //   }
          //   final uri = Uri.parse(url);
          //   DeeplinkManager.instance.handleUri(uri);
          //   return NavigationDecision.prevent;
          // },
          onUrlChange: (UrlChange change) {},
          onHttpError: (error) {},
        ),
      )
      ..loadRequest(Uri.parse(url));
  }
}
