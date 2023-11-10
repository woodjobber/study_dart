import 'package:get/get.dart';
import 'package:study_dart/logger/logger.dart';

class GlobalRouterHistoryManager {
  GlobalRouterHistoryManager._();
  static final GlobalRouterHistoryManager _instance =
      GlobalRouterHistoryManager._();

  factory GlobalRouterHistoryManager() => _instance;

  static final GlobalRouterHistoryManager instance = _instance;
  final List<String> _routeNames = [];

  List<String> get routeNames => _routeNames;

  void putRouterByName(String? routeName) {
    if (routeName == null) {
      return;
    }
    _routeNames.addIf(routeName.isNotEmpty, routeName);
    logger.d('>>>> Added after $_routeNames');
  }

  void removeRouterByName(String? routeName) {
    if (routeName != null && _routeNames.contains(routeName)) {
      _routeNames.remove(routeName);
    }
    logger.d('>>>> Removed after $_routeNames');
  }

  bool isRouteExist(String routeName) {
    if (routeName.isEmpty) {
      return false;
    }
    return _routeNames.contains(routeName);
  }

  bool isTopRouteExist(String routeName) {
    if (!isRouteExist(routeName)) {
      return false;
    }
    return _routeNames.last == routeName;
  }
}
