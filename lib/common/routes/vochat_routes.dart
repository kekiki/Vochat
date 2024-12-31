import 'package:get/get.dart';
import 'package:vochat/bottom_tab/tab_community/vochat_tab_community_binding.dart';
import 'package:vochat/bottom_tab/vochat_bottom_tab_page.dart';
import '../../bottom_tab/tab_home/vochat_tab_home_binding.dart';
import '../../bottom_tab/tab_me/vochat_tab_me_binding.dart';
import '../../bottom_tab/tab_message/vochat_tab_message_binding.dart';
import '../../bottom_tab/vochat_bottom_tab_binding.dart';
import '../../login/vochat_login_binding.dart';
import '../../login/vochat_login_page.dart';
import '../widgets/webview/vochat_webview_page.dart';
import '../widgets/media/vochat_media_binding.dart';
import '../widgets/media/vochat_media_page.dart';
import '../../splash/vochat_splash_page.dart';

abstract class VochatRoutes {
  static const splash = "/";
  static const login = "/login";
  static const web = "/web";
  static const tabs = "/tabs";
  static const chat = "/chat";
  static const media = "/media";

  static final getPageList = [
    GetPage(
      name: splash,
      page: () => const VochatSplashPage(),
    ),
    GetPage(
      name: login,
      page: () => const VochatLoginPage(),
      binding: VochatLoginBinding(),
    ),
    GetPage(
      name: web,
      page: () => const VochatWebviewPage(),
    ),
    GetPage(
      name: tabs,
      page: () => const VochatBottomTabPage(),
      binding: VochatBottomTabBinding(),
      bindings: [
        VochatTabHomeBinding(),
        VochatTabCommunityBinding(),
        VochatTabMessageBinding(),
        VochatTabMeBinding(),
      ],
    ),
    // GetPage(
    //   name: chat,
    //   page: () => const VochatChatContentPage(),
    //   binding: VochatChatContentBinding(),
    // ),
    GetPage(
      name: media,
      page: () => const VochatMediaPage(),
      binding: VochatMediaBinding(),
    ),
  ];
}
