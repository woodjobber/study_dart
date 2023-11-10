import 'package:get/get.dart';
import 'package:study_dart/global_route_observer/global_router_history_manager.dart';

extension SingleTask on GetInterface {
  bool isRouteExist(String routeName) {
    return GlobalRouterHistoryManager().isRouteExist(routeName);
  }

  bool isTopRouteExist(String routeName) {
    return GlobalRouterHistoryManager().isTopRouteExist(routeName);
  }

  Future<T?>? offNamedSingleTask<T>(
    String routeName, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    if (isRouteExist(routeName)) {
      Get.until((route) => route.settings.name == routeName);
      return null;
    } else {
      return Get.offNamed(routeName,
          arguments: arguments, parameters: parameters);
    }
  }

  Future<T?>? toNamedSingleTask<T>(
    String routeName, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    if (isRouteExist(routeName)) {
      Get.until((route) => route.settings.name == routeName);
      return null;
    } else {
      return Get.toNamed(routeName,
          arguments: arguments, parameters: parameters);
    }
  }

  Future<T?>? toNamedSingleTop<T>(
    String routeName, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    if (isTopRouteExist(routeName)) {
      Get.until((route) => route.settings.name == routeName);
      return null;
    } else {
      return toNamedSingleTask(routeName,
          arguments: arguments, parameters: parameters);
    }
  }
}
