import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_dart/remote_image/fade_remote_image.dart';
import 'package:study_dart/remote_image/remote_image.dart';
import 'package:study_dart/routes/app_pages.dart';
import 'package:transparent_image/transparent_image.dart';

class GlobalMiddleware extends GetMiddleware {
  final authController = Get.find<AuthController>();
  @override
  // TODO: implement priority
  int? get priority => -1000;

  // @override
  // Future<GetNavConfig?> redirectDelegate(GetNavConfig route) {
  //   // TODO: implement redirectDelegate
  //   print(redirectDelegate);
  //   if (!authController.authenticated) {
  //     Future.delayed(Duration(seconds: 1), () => Get.snackbar("提示", "请先登录APP"));
  //   }
  //   if (!authController.authenticated) {
  //     return Get.rootDelegate.toNamed('/login');
  //     // return Future.value(GetNavConfig.fromRoute('/login'));
  //   }
  //   return super.redirectDelegate(route);
  // }

  @override
  RouteSettings? redirect(String? route) {
    print('redirect called..$authController');
    return authController.authenticated || route == Routes.LOGIN
        ? null
        : RouteSettings(name: Routes.LOGIN);
  }

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    print('>>>>>>>>>>>>>> Bindings ${bindings?.length}');
    bindings = [OtherBinding()];
    return bindings;
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    print('Bindings of ${page.toString()} are ready');
    return super.onPageBuildStart(page);
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    print('>>> Page ${page?.name} called');
    print('>>> User ${authController} ${authController.username} logged');
    return authController.username.isNotEmpty
        ? page?.copy(arguments: {'user': authController.username})
        : page;
  }

  @override
  Widget onPageBuilt(Widget page) {
    print('Widget ${page.toStringShort()} will be showed');
    return page;
  }

  @override
  void onPageDispose() {
    print('PageDisposed');
  }
}

class AuthController extends GetxController {
  final _authenticated = false.obs;
  final _username = RxString('');

  bool get authenticated => _authenticated.value;
  set authenticated(bool value) => _authenticated.value = value;
  String get username => _username.value;
  set username(String value) => _username.value = value;

  @override
  void onInit() {
    ever(_authenticated, (value) {
      if (value) {
        username = 'Eduardo';
        Get.offNamed('/home');
      } else {
        Get.offNamed('/login');
      }
    });

    super.onInit();
  }
}

class OtherBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OtherController());
  }
}

class OtherController extends GetxController {
  @override
  void onInit() {
    print('>>> OtherController started');
    super.onInit();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HOME')),
      body: Center(
        child: Text('User: ${Get.parameters['user']}'),
      ),
    );
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    print('>>>> LoginBinding ..');
    Get.put(AuthController());
    Get.put(LoginController());
  }
}

class LoginController extends GetxController {
  final imgSrc =
      'https://p2.music.126.net/5CJeYN35LnzRDsv5Lcs0-Q==/109951165374966765.jpg';
  @override
  void onInit() {
    print('>>> LoginController started');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(Duration(seconds: 0), () => Get.snackbar("提示", "请先登录APP"));
  }

  AuthController get authController => Get.find<AuthController>();
}

class LoginPage extends GetView<LoginController> {
  void preload(BuildContext context) {
    var configuration = createLocalImageConfiguration(context);
    RemoteImage(controller.imgSrc).resolve(configuration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Container(
        color: Colors.grey,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Center(
            //   child: GestureDetector(
            //     onTap: () {
            //       controller.authController.authenticated = true;
            //     },
            //     child: RImage.remote(
            //       controller.imgSrc,
            //       loadingBuilder: (BuildContext context, Widget child,
            //           ImageChunkEvent? loadingProgress) {
            //         if (loadingProgress == null) {
            //           return child;
            //         }
            //         return Center(
            //           child: CircularProgressIndicator(
            //             value: loadingProgress.expectedTotalBytes != null
            //                 ? loadingProgress.cumulativeBytesLoaded /
            //                     loadingProgress.expectedTotalBytes!
            //                 : null,
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
            Center(
              child: GestureDetector(
                onTap: () {
                  controller.authController.authenticated = true;
                },
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 400,
                  ),
                  child: FadeRemoteImage.remote(
                      placeholder: kTransparentImage, image: controller.imgSrc),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
