import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/i18n/vochat_local_translations.dart';
import 'common/logger/vochat_log_util.dart';
import 'common/adapts/vochat_screen_adapt.dart';
import 'common/behavior/vochat_over_scroll_behavior.dart';
import 'common/routes/vochat_routes.dart';
import 'common/utils/vochat_keyboard_util.dart';
import 'common/utils/vochat_loading_util.dart';
import 'services/managers/vochat_socket_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        VochatLogUtil.d('AppLifecycleState', 'app resumed');
        VochatSocketManager.instance.sendPauseCallMessage(isStop: false);
        break;
      case AppLifecycleState.paused:
        VochatLogUtil.d('AppLifecycleState', 'app paused');
        VochatSocketManager.instance.sendPauseCallMessage(isStop: true);
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: VochatRoutes.splash,
      getPages: VochatRoutes.getPageList,
      translations: VochatLocalTranslations(),
      popGesture: true,
      locale: VochatLocalTranslationLanguage.defaultLocale,
      fallbackLocale: const Locale('en', 'US'),
      defaultTransition: Transition.cupertino,
      builder: VochatLoadingUtil.init(
        builder: (context, child) {
          VochatScreenAdapt.initialize(context);
          final MediaQueryData data = MediaQuery.of(context);
          return MediaQuery(
            data: data.copyWith(textScaler: const TextScaler.linear(1.0)),
            child: ScrollConfiguration(
              behavior: VochatOverScrollBehavior(),
              child: GestureDetector(
                onTap: () => VochatKeyboardUtil.hideKeyboard(context),
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}
