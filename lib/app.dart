import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_dart/get_material_app_wrapper/get_x_material_app.dart';
import 'package:study_dart/middleware/auth/inital_binds.dart';
import 'package:study_dart/pagestorage_key/app_route_observer.dart';

import 'flavors.dart';
import 'middleware/auth/auth_middleware.dart';
import 'middleware/auth/welcome_page.dart';
import 'middleware/global_middleware.dart';
import 'pages/my_home_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetXMaterialApp(
      effect: () {
        Get.put(AuthController());
      },
      title: F.title,
      navigatorKey: navigatorKey,
      navigatorObservers: [AppRouteObserver().routeObserver],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: InitialBindings(),
      getPages: () => [
        GetPage(
            page: () => const WelcomePage(),
            name: '/',
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
      ],
    );
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
}
