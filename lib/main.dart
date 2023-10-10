import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:study_dart/amigo.dart';
import 'app.dart';

FutureOr<void> main() async {
  // Isolate.current.addErrorListener(new RawReceivePort((dynamic pair) {
  //   print(pair);
  //   var isolateError = pair as List<dynamic>;
  //   var _error = isolateError.first;
  //   var _stackTrace = isolateError.last;
  //   Zone.current.handleUncaughtError(_error, _stackTrace);
  // }).sendPort);
  // FlutterError.onError = (details) {
  //   // FlutterError.presentError(details);
  //   Zone.current.handleUncaughtError(details.exception, details.stack!);
  //   showDialog(
  //       context: navigatorKey.currentContext!,
  //       builder: (context) => Center(
  //             child: Material(
  //               color: Colors.transparent,
  //               child: Text(
  //                 "${details.exception.toString()}",
  //                 style: TextStyle(fontSize: 40, color: Colors.red),
  //               ),
  //             ),
  //           ));
  // };
  // ErrorWidget.builder = (FlutterErrorDetails details) {
  //   return CustomErrorScreen(details: details);
  // };
  // runZonedGuarded(() {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   runApp(const App());
  //   Ned.createIsolate();
  //   Future.delayed(Duration(seconds: 1))
  //       .then((e) => throw StateError('This is a Dart exception in Future.'));
  // }, (error, stack) {
  //   print('async error caught by zone');
  // });

  PlatformDispatcher.instance.onError = (error, stack) {
    FlutterBugly.uploadException(
        message: error.toString(), detail: stack.toString());

    return true;
  };
  FlutterBugly.postCatchedException(() {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterBugly.init(iOSAppId: 'c5f84ad631');
    FlutterBugly.setUserId('123');
    FlutterBugly.setUserTag(247971);
    FlutterBugly.putUserData(key: "customKey", value: "2");
    runApp(const App());
  }, debugUpload: true);
  testYield();
}

void testYield() {
  var d = countDown(4);
  d.forEach((element) {
    print(element);
  });
  countDownFrom(5).forEach((element) {
    print(element);
  });
}

Stream<int> runToMax(int n) async* {
  int i = 0;
  while (i < n) {
    yield i;
    i++;
    await Future.delayed(Duration(seconds: 1));
  }
}

Stream<int> countDownFrom(int n) async* {
  if (n > 0) {
    yield n;
    yield* runToMax(n - 1);
  }
}

Iterable<int> countDown(int n) sync* {
  if (n > 0) {
    yield n;

    /// yield 发送 值，不会中断函数，it like 'return' ,but not.
    /// yield* 委托调用另一个迭代器，一旦迭代器停止生产值，将恢复主迭代器
    yield* genIterates(n - 1);
  }
}

Iterable<int> genIterates(int max) sync* {
  var i = 0;
  while (i < max) {
    yield i;
    i++;
  }
}

class CustomErrorScreen extends StatelessWidget {
  const CustomErrorScreen({Key? key, required this.details}) : super(key: key);
  final FlutterErrorDetails details;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Error",
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "${details.exception} ",
              textDirection: TextDirection.ltr,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
