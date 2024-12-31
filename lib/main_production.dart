import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'app_macros/vochat_app_macros.dart';
import 'services/managers/vochat_event_logger.dart';
import 'my_app.dart';

import 'dart:async';
import 'common/utils/vochat_stacktrace_util.dart';

void main() {
  runZoned(
    () async {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

      VochatAppMacros.enableApiLog = false;
      VochatAppMacros.enableTestLogin = false;
      VochatAppMacros.enableAnalytics = true;
      await VochatAppMacros.instance.initProduction();

      final onError = FlutterError.onError;
      FlutterError.onError = (FlutterErrorDetails details) {
        onError?.call(details);
        VochatEventLogger.instance.reportError(details.exception.toString());
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
        stringBuffer.write(VochatStacktraceUtil.format(stackTrace, 1));
        parent.print(zone, stringBuffer.toString());
        VochatEventLogger.instance.reportError(stringBuffer.toString());
      },
    ),
  );
}
