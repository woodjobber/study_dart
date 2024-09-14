import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_dart/global_route_observer/global_route_observer.dart';
import 'package:study_dart/get_x_material_app/get_x_material_app.dart';
import 'package:study_dart/middleware/auth/inital_binds.dart';
import 'package:study_dart/page_storage_key/app_route_observer.dart';
import 'package:study_dart/routes/app_pages.dart';

import 'father_widget.dart';
import 'flavors.dart';
import 'middleware/global_middleware.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetXMaterialApp(
      onAdvanceInit: () {
        // Others that need to be initialized in advance are placed here.
        Get.put(AuthController());
      },
      title: F.title,
      navigatorKey: navigatorKey,
      navigatorObservers: [
        AppRouteObserver().routeObserver,
        GlobalRouteObserver(),
      ],
      // initialRoute: AppPages.INITIAL,

      home: FartherWidget(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: InitialBindings(),
      getPages: () => AppPages.routes,
      onGenerateRoute: (setting) {
        return null;
      },
      onUnknownRoute: (setting) {
        return null;
      },
      routingCallback: (routing) {
        final controller = Get.find<AuthController>();
        if (!controller.authenticated) {
          print('routing callback.${routing?.route?.settings.name}');
        }
      },
    );
  }
}

var onGenerateRoute = (RouteSettings settings) {
  final routes = {
    '/search': (context, {arguments}) => FartherWidget(),
  };
  final String? name = settings.name;
  final Function? pageContentBuilder = routes[name] as Function;
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          settings: settings,
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route = MaterialPageRoute(
          settings: settings,
          builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
