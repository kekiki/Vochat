import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/logger/colive_log_util.dart';
import 'common/adapts/colive_screen_adapt.dart';
import 'common/behavior/colive_over_scroll_behavior.dart';
import 'services/observers/colive_getx_router_observer.dart';
import 'common/utils/colive_keyboard_util.dart';
import 'common/utils/colive_loading_util.dart';
import 'services/i18n/colive_local_translations.dart';
import 'services/managers/colive_socket_manager.dart';
import 'services/routes/colive_routes.dart';
import 'services/static/colive_colors.dart';

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
        ColiveLogUtil.d('AppLifecycleState', 'app resumed');
        ColiveSocketManager.instance.sendPauseCallMessage(isStop: false);
        break;
      case AppLifecycleState.paused:
        ColiveLogUtil.d('AppLifecycleState', 'app paused');
        ColiveSocketManager.instance.sendPauseCallMessage(isStop: true);
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
      initialRoute: ColiveRoutes.splash,
      getPages: ColiveRoutes.getPageList,
      navigatorObservers: [ColiveGetXRouterObserver()],
      translations: ColiveLocalTranslations(),
      popGesture: true,
      locale: ColiveLocalTranslationLanguage.defaultLocale,
      fallbackLocale: const Locale('en', 'US'),
      defaultTransition: Transition.cupertino,
      builder: ColiveLoadingUtil.init(
        builder: (context, child) {
          ColiveScreenAdapt.initialize(context);
          final MediaQueryData data = MediaQuery.of(context);
          return MediaQuery(
            data: data.copyWith(textScaler: const TextScaler.linear(1.0)),
            child: ScrollConfiguration(
              behavior: ColiveOverScrollBehavior(),
              child: GestureDetector(
                onTap: () => ColiveKeyboardUtil.hideKeyboard(context),
                child: child,
              ),
            ),
          );
        },
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColiveColors.primaryColor,
          secondary: ColiveColors.primaryColor,
        ),
        useMaterial3: true,
        dialogTheme: const DialogTheme(elevation: 0),
      ),
    );
  }
}
