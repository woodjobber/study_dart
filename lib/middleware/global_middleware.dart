import 'dart:convert';
import 'dart:io';
import 'package:dio/io.dart';

import 'package:basic_utils/basic_utils.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:defer_pointer/defer_pointer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:study_dart/custom_gesture_recognizer.dart';
import 'package:study_dart/custom_scroll_physics.dart';
import 'package:study_dart/custom_tooltip.dart';
import 'package:study_dart/dialog_interceptor/dialog_options.dart';
import 'package:study_dart/dialog_interceptor/dialog_interceptor_chain.dart';
import 'package:study_dart/dialog_interceptor/dialog_interceptor_handler.dart';
import 'package:study_dart/dialog_interceptor/one_interceptor.dart';
import 'package:study_dart/dialog_interceptor/three_interceptor.dart';
import 'package:study_dart/dialog_interceptor/two_interceptor.dart';
import 'package:study_dart/logger/logger.dart';
import 'package:study_dart/print_ext.dart';
import 'package:study_dart/remote_image/fade_remote_image.dart';
import 'package:study_dart/remote_image/remote_image.dart';
import 'package:study_dart/routes/app_pages.dart';
import 'package:study_dart/single_task/single_task.dart';
import 'package:study_dart/slide_captcha_widget/slide_captcha_widget.dart';
import 'package:transparent_image/transparent_image.dart';

import '../slide_captcha_widget/custom_radar_chart.dart';
import '../slide_captcha_widget/radar_chart.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<ByteData> loadAsset() async {
  return await rootBundle.load('assets/dd.pem');
}

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
  void onInit() async {
    ever(_authenticated, (value) {
      if (value) {
        username = 'Eduardo';
        Get.offNamedSingleTask('/home');
      } else {
        Get.offNamedSingleTask('/login');
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
  final tapGestureRecognizer = TapGestureRecognizer();
  var toggle = false.obs;

  final DialogInterceptorChain client = DialogInterceptorChain();

  @override
  void onInit() async {
    print('>>> LoginController started');
    tapGestureRecognizer.onTap = () {
      toggle.value = !toggle.value;
    };
    /*
    OpenAI.apiKey = 'sess-FxwNtOrpPwUgJW0PzjuFD5U2YTq2wUCpxYlHb75P';
    // Start using!
    final completion = await OpenAI.instance.completion.create(
      model: "text-davinci-003",
      prompt: "用 dart 语言写一个单例",
    );

    // Printing the output to the console
    completion.choices.forEach((element) {
      logger.d(element.text);
    });

    // Generate an image from a prompt.
    final image = await OpenAI.instance.image.create(
      prompt: "dinosaur",
      n: 1,
    );

    // Printing the output to the console.
    logger.d(image.data.first.url);
     */

    client.addInterceptors([
      OneInterceptor(),
      // TwoInterceptor(),
      // ThreeInterceptor(),
    ]);
    final pem = await _readPemCert('assets/google.com.hk.pem');
    final p = X509Utils.x509CertificateFromPem(pem);
    p.sha256Thumbprint.msg('sha256 ').print;
    decodePEM(pem);
    final certificates = await rootBundle.load('assets/soer.top.crt');
    final dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final securityContext = SecurityContext(); //1
      securityContext
          .setTrustedCertificatesBytes(certificates.buffer.asUint8List());
      final client = HttpClient(context: securityContext);
      client.badCertificateCallback = (cert, host, port) {
        return false;
      };
      return client;
    };

    final response = await dio.getUri(Uri.parse('https://soer.top'));
    print(response.statusCode);
    super.onInit();
  }

  Future<String> _readPemCert(String path) async {
    final sslCert = await rootBundle.load(path);
    final data = sslCert.buffer.asUint8List();
    final pemString = utf8.decode(data);
    return pemString;
  }

  Uint8List decodePEM(String pem) {
    var startsWith = [
      '-----BEGIN PUBLIC KEY-----',
      '-----BEGIN PRIVATE KEY-----',
      '-----BEGIN CERTIFICATE-----',
    ];
    var endsWith = [
      '-----END PUBLIC KEY-----',
      '-----END PRIVATE KEY-----',
      '-----END CERTIFICATE-----'
    ];
    pem = pem.trim();
    //HACK
    for (var s in startsWith) {
      if (pem.startsWith(s)) {
        pem = pem.substring(s.length);
      }
    }

    for (var s in endsWith) {
      if (pem.trim().endsWith(s)) {
        pem = pem.trim().split(s)[0];
      }
    }

    //Dart base64 decoder does not support line breaks
    pem = pem.replaceAll('\n', '');
    pem = pem.replaceAll('\r', '');
    return Uint8List.fromList(base64.decode(pem));
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(Duration(seconds: 0), () => Get.snackbar("提示", "请先登录APP"));
    client.send(AlertOptions(msg: '我是弹窗信息', title: '测试'));
  }

  @override
  void onClose() {
    tapGestureRecognizer.dispose();
    super.onClose();
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
            /*
            Center(
              child: GestureDetector(
                onTap: () {
                  controller.authController.authenticated = true;
                },
                child: RImage.remote(
                  controller.imgSrc,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            Listener(
              onPointerDown: (v) {
                print('object');
              },
              child: AbsorbPointer(
                absorbing: false,
                child: Center(
                  child: Listener(
                    onPointerDown: (v) {
                      controller.authController.authenticated = true;
                    },
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 400,
                      ),
                      child: FadeRemoteImage.remote(
                          placeholder: kTransparentImage,
                          image: controller.imgSrc),
                    ),
                  ),
                ),
              ),
            ),
            Obx(() => Text.rich(TextSpan(children: [
                  TextSpan(text: '您好事件'),
                  TextSpan(
                    text: '比那氏',
                    style: TextStyle(
                      fontSize: 30,
                      color: controller.toggle.value
                          ? Colors.blueGrey
                          : Colors.black,
                    ),
                    recognizer: controller.tapGestureRecognizer,
                  )
                ]))),
            wChild(1, Colors.white, 200),
            Container(
              color: Colors.green,
              width: 150,
              height: 150,
            ),
            CustomTapGestureRecognizer.detector(
              onTap: () {
                print("object1");
              },
              child: Container(
                color: Colors.blue,
                width: 100,
                height: 100,
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    print("object2");
                  },
                  child: Container(
                    color: Colors.orangeAccent,
                    width: 10,
                    height: 10,
                  ),
                ),
              ),
            ),*/
            Center(
              child: DeferredPointerHandler(
                child: Container(
                  color: Colors.black54,
                  width: 40,
                  height: 40,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        bottom: -30,
                        child: DeferPointer(
                          child: CustomTapGestureRecognizer.detector(
                            onTap: () {
                              controller.authController.authenticated = true;
                              // SystemChannels.platform
                              //     .invokeMethod<void>('SystemNavigator.pop');
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget wChild(int index, color, double size) {
    return Listener(
      onPointerDown: (e) => print(index),
      child: Container(
        width: size,
        height: size,
        color: Colors.grey,
      ),
    );
  }
}

class SlideVerificationCode extends StatefulWidget {
  @override
  _SlideVerificationCodeState createState() => _SlideVerificationCodeState();
}

class _SlideVerificationCodeState extends State<SlideVerificationCode> {
  double _sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        setState(() {
          _sliderValue += details.delta.dx;
          _sliderValue = _sliderValue > 0 ? _sliderValue : 0;
        });
      },
      child: Container(
        width: 300,
        height: 50,
        color: Colors.grey[200],
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              width: _sliderValue > 300 ? 300 : _sliderValue,
              height: 50,
              color: Colors.green,
            ),
            Text('拖动滑块验证'),
          ],
        ),
      ),
    );
  }
}
