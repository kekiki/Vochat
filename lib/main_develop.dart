import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'services/config/colive_app_config.dart';
import 'services/managers/colive_event_logger.dart';
import 'my_app.dart';

import 'dart:async';
import 'common/utils/colive_stacktrace_util.dart';

void main() {
  runZoned(
    () async {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

      ColiveAppConfig.enableApiLog = true;
      ColiveAppConfig.enableTestLogin = true;
      ColiveAppConfig.enableAnalytics = false;
      await ColiveAppConfig.instance.initDevelop();

      final onError = FlutterError.onError;
      FlutterError.onError = (FlutterErrorDetails details) {
        onError?.call(details);
        ColiveEventLogger.instance.reportError(details.exception.toString());
      };
      runApp(const MyApp());
    },
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        parent.print(zone, "[Log]: $line");
      },
      handleUncaughtError: (Zone self, ZoneDelegate parent, Zone zone,
          Object error, StackTrace stackTrace) {
        final stringBuffer = StringBuffer();
        stringBuffer.writeln(error.toString());
        stringBuffer.write(ColiveStacktraceUtil.format(stackTrace, 1));
        parent.print(zone, stringBuffer.toString());
        ColiveEventLogger.instance.reportError(stringBuffer.toString());
      },
    ),
  );
}
