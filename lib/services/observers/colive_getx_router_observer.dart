import 'package:flutter/material.dart';

import '../../common/logger/colive_log_util.dart';

class ColiveGetXRouterObserver extends NavigatorObserver {
  final _tag = "RouterObserver";

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final routeName = route.settings.name;
    final previousRouteName = previousRoute?.settings.name;
    ColiveLogUtil.d(_tag, "didPush => $routeName, $previousRouteName");
    for (var listener in ColiveRouteObserverManager.instance.listeners) {
      listener.didPush(route.settings.name, previousRoute?.settings.name);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    final routeName = route.settings.name;
    final previousRouteName = previousRoute?.settings.name;
    ColiveLogUtil.d(_tag, "didPop => $routeName, $previousRouteName");
    for (var listener in ColiveRouteObserverManager.instance.listeners) {
      listener.didPop(routeName, previousRouteName);
    }
  }
}

class ColiveRouteObserverManager {
  ColiveRouteObserverManager._internal();

  static ColiveRouteObserverManager? _instance;

  static ColiveRouteObserverManager get instance =>
      _instance ??= ColiveRouteObserverManager._internal();

  final List<ColiveRouteListener> _listenerList = [];

  List<ColiveRouteListener> get listeners => _listenerList;

  void addListener(ColiveRouteListener listener) {
    _listenerList.add(listener);
  }

  void removeListener(ColiveRouteListener listener) {
    _listenerList.remove(listener);
  }

  void close() {
    _listenerList.clear();
    _instance = null;
  }
}

typedef RouteAction = void Function(String?, String?);

class ColiveRouteListener {
  final RouteAction? pushAction;
  final RouteAction? popAction;

  ColiveRouteListener({this.pushAction, this.popAction});

  void didPush(String? routeName, String? previousRouteName) {
    pushAction?.call(routeName, previousRouteName);
  }

  void didPop(String? routeName, String? previousRouteName) {
    popAction?.call(routeName, previousRouteName);
  }
}
