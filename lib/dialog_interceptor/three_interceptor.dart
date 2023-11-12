import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:get/get.dart';
import 'package:study_dart/logger/logger.dart';

import 'dialog_interceptor.dart';
import 'dialog_interceptor_handler.dart';

class ThreeInterceptor extends DialogInterceptor {
  @override
  void intercept(options, DialogInterceptorHandler handler) async {
    logger.d('ThreeInterceptor ${options.msg}');
    await showOkAlertDialog(
        context: Get.context!,
        title: 'three  ${options.title}',
        message: options.msg);
    handler.next(options);
  }

  @override
  int get priority => -1;
}
