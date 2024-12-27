import 'package:get/get.dart';
import 'package:colive/home_mine/diamonds_store/colive_diamonds_store_binding.dart';
import 'package:colive/home_mine/diamonds_store/colive_diamonds_store_page.dart';
import 'package:colive/home_mine/vip_center/colive_vip_center_binding.dart';
import 'package:colive/home_mine/vip_center/colive_vip_center_page.dart';
import 'package:colive/home_moment/post/colive_moment_post_binding.dart';
import 'package:colive/home_moment/post/colive_moment_post_page.dart';

import '../../anchor_detail/colive_anchor_detail_binding.dart';
import '../../anchor_detail/colive_anchor_detail_page.dart';
import '../../anchor_detail/videos/colive_anchor_videos_binding.dart';
import '../../anchor_detail/videos/colive_anchor_videos_page.dart';
import '../../call/calling/colive_call_calling_binding.dart';
import '../../call/calling/colive_call_calling_page.dart';
import '../../call/finished/colive_call_finished_binding.dart';
import '../../call/finished/colive_call_finished_page.dart';
import '../../call/waiting/colive_call_waiting_binding.dart';
import '../../call/waiting/colive_call_waiting_page.dart';
import '../widgets/webview/colive_webview_page.dart';
import '../../home/colive_home_binding.dart';
import '../../home/colive_home_page.dart';
import '../../home_anchors/colive_home_anchors_binding.dart';
import '../../home_chat/content/colive_chat_content_binding.dart';
import '../../home_chat/content/colive_chat_content_page.dart';
import '../../home_chat/colive_home_chat_binding.dart';
import '../../home_mine/about_us/colive_about_us_binding.dart';
import '../../home_mine/about_us/colive_about_us_page.dart';
import '../../home_mine/edit_profile/colive_edit_profile_binding.dart';
import '../../home_mine/edit_profile/colive_edit_profile_page.dart';
import '../../home_mine/colive_home_mine_binding.dart';
import '../../home_mine/lucky_draw/colive_lucky_draw_binding.dart';
import '../../home_mine/lucky_draw/colive_lucky_draw_page.dart';
import '../../home_mine/my_bills/colive_my_bills_binding.dart';
import '../../home_mine/my_bills/colive_my_bills_page.dart';
import '../../home_mine/my_cards/colive_my_cards_binding.dart';
import '../../home_mine/my_cards/colive_my_cards_page.dart';
import '../../home_mine/my_follows/colive_my_follows_binding.dart';
import '../../home_mine/my_follows/colive_my_follows_page.dart';
import '../../home_mine/settings/colive_settings_binding.dart';
import '../../home_mine/settings/colive_settings_page.dart';
import '../../home_moment/colive_home_moment_binding.dart';
import '../../login/colive_login_binding.dart';
import '../../login/colive_login_page.dart';
import '../../media/colive_media_binding.dart';
import '../../media/colive_media_page.dart';
import '../../anchor_detail/photos/colive_anchor_photos_binding.dart';
import '../../anchor_detail/photos/colive_anchor_photos_page.dart';
import '../../search/colive_search_binding.dart';
import '../../search/colive_search_page.dart';
import '../../splash/colive_splash_page.dart';

abstract class ColiveRoutes {
  static const splash = "/";
  static const login = "/login";
  static const web = "/web";
  static const home = "/home";
  static const chat = "/chat";
  static const media = "/media";

  static const anchorDetail = "/anchorDetail";
  static const anchorPhotos = "/anchorPhotos";
  static const anchorVideos = "/anchorVideos";

  static const callWaiting = "/callWaiting";
  static const callCalling = "/callCalling";
  static const callFinished = "/callFinished";

  static const store = "/store";
  static const vip = "/vip";
  static const editProfile = "/editProfile";
  static const myBills = "/myBills";
  static const myCards = "/myCards";
  static const myFollows = "/myFollows";
  static const settings = "/settings";
  static const aboutUs = "/aboutUs";
  static const search = "/search";
  static const luckyDraw = "/luckyDraw";
  static const postMoment = "/postMoment";

  static final getPageList = [
    GetPage(
      name: splash,
      page: () => const ColiveSplashPage(),
    ),
    GetPage(
      name: login,
      page: () => const ColiveLoginPage(),
      binding: ColiveLoginBinding(),
    ),
    GetPage(
      name: web,
      page: () => const ColiveWebviewPage(),
    ),
    GetPage(
      name: home,
      page: () => const ColiveHomePage(),
      binding: ColiveHomeBinding(),
      bindings: [
        ColiveHomeAnchorsBinding(),
        ColiveHomeMomentBinding(),
        ColiveHomeChatBinding(),
        ColiveHomeMineBinding(),
      ],
    ),
    GetPage(
      name: chat,
      page: () => const ColiveChatContentPage(),
      binding: ColiveChatContentBinding(),
    ),
    GetPage(
      name: media,
      page: () => const ColiveMediaPage(),
      binding: ColiveMediaBinding(),
    ),
    GetPage(
      name: anchorDetail,
      page: () => const ColiveAnchorDetailPage(),
      binding: ColiveAnchorDetailBinding(),
    ),
    GetPage(
      name: anchorPhotos,
      page: () => const ColiveAnchorPhotosPage(),
      binding: ColiveAnchorPhotosBinding(),
    ),
    GetPage(
      name: anchorVideos,
      page: () => const ColiveAnchorVideosPage(),
      binding: ColiveAnchorVideosBinding(),
    ),
    GetPage(
      name: callWaiting,
      page: () => const ColiveCallWaitingPage(),
      binding: ColiveCallWaitingBinding(),
    ),
    GetPage(
      name: callCalling,
      page: () => const ColiveCallCallingPage(),
      binding: ColiveCallCallingBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: callFinished,
      page: () => const ColiveCallFinishedPage(),
      binding: ColiveCallFinishedBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: store,
      page: () => const ColiveDiamondsStorePage(),
      binding: ColiveDiamondsStoreBinding(),
    ),
    GetPage(
      name: vip,
      page: () => const ColiveVipCenterPage(),
      binding: ColiveVipCenterBinding(),
    ),
    GetPage(
      name: editProfile,
      page: () => const ColiveEditProfilePage(),
      binding: ColiveEditProfileBinding(),
    ),
    GetPage(
      name: myBills,
      page: () => const ColiveMyBillsPage(),
      binding: ColiveMyBillsBinding(),
    ),
    GetPage(
      name: myCards,
      page: () => const ColiveMyCardsPage(),
      binding: ColiveMyCardsBinding(),
    ),
    GetPage(
      name: myFollows,
      page: () => const ColiveMyFollowsPage(),
      binding: ColiveMyFollowsBinding(),
    ),
    GetPage(
      name: settings,
      page: () => const ColiveSettingsPage(),
      binding: ColiveSettingsBinding(),
    ),
    GetPage(
      name: aboutUs,
      page: () => const ColiveAboutUsPage(),
      binding: ColiveAboutUsBinding(),
    ),
    GetPage(
      name: search,
      page: () => const ColiveSearchPage(),
      binding: ColiveSearchBinding(),
    ),
    GetPage(
      name: luckyDraw,
      page: () => const ColiveLuckyDrawPage(),
      binding: ColiveLuckyDrawBinding(),
    ),
    GetPage(
      name: postMoment,
      page: () => const ColiveMomentPostPage(),
      binding: ColiveMomentPostBinding(),
    ),
  ];
}
