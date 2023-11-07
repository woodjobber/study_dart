import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../flavors.dart';
import '../middleware/auth/auth_middleware.dart';
import '../middleware/auth/welcome_page.dart';
import '../middleware/global_middleware.dart';
import '../pages/my_home_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
        page: () => const WelcomePage(),
        name: '/welcome',
        middlewares: [AuthMiddleware()]),
    GetPage(
      name: '/home',
      page: () => _flavorBanner(
        child: MyHomePage(),
        show: kDebugMode,
      ),
      transition: Transition.noTransition,
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
        name: '/login',
        page: () => LoginPage(),
        binding: LoginBinding(),
        transition: Transition.noTransition),
  ];
}

Widget _flavorBanner({
  required Widget child,
  bool show = true,
}) =>
    show
        ? Banner(
            child: child,
            location: BannerLocation.topStart,
            message: F.name,
            color: Colors.red.withOpacity(0.6),
            textStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                letterSpacing: 1.0),
            textDirection: TextDirection.ltr,
          )
        : Container(
            child: child,
          );
