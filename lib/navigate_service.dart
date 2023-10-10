import 'package:flutter/material.dart';

class NavigateService {
  final GlobalKey<NavigatorState> key = GlobalKey(debugLabel: "navigate_key");
  NavigatorState get navigator => key.currentState!;
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? args,
  }) async {
    return navigator.pushNamed<T>(
      routeName,
      arguments: args,
    );
  }
}
