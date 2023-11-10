import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/router_report.dart';
import 'package:study_dart/global_route_observer/global_router_history_manager.dart';
import 'package:study_dart/logger/logger.dart';

class GlobalRouteObserver<R extends Route<dynamic>> extends RouteObserver<R> {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    RouterReportManager.reportCurrentRoute(route);
    GlobalRouterHistoryManager().putRouterByName(route.settings.name);
    logger.d(
        'didPush route: ${route.settings.name},  previousRoute:${previousRoute?.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    RouterReportManager.reportRouteDispose(route);
    GlobalRouterHistoryManager.instance.removeRouterByName(route.settings.name);
    logger.d(
        'didPop route: ${route.settings.name},  previousRoute:${previousRoute?.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    GlobalRouterHistoryManager.instance
        .putRouterByName(newRoute?.settings.name);
    GlobalRouterHistoryManager.instance
        .removeRouterByName(oldRoute?.settings.name);
    logger.d('didReplace newRoute: $newRoute,oldRoute:$oldRoute');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    GlobalRouterHistoryManager.instance.removeRouterByName(route.settings.name);
    logger.d('didRemove route: $route,previousRoute:$previousRoute');
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    logger.d('didStartUserGesture route: $route,previousRoute:$previousRoute');
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    logger.d('didStopUserGesture');
  }
}
