import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:get/get.dart';
import 'package:study_dart/logger/logger.dart';

import 'dialog_interceptor.dart';
import 'dialog_interceptor_handler.dart';

// 具体实现拦截器
class OneInterceptor extends DialogInterceptor {
  @override
  void intercept(options, DialogInterceptorHandler handler) async {
    logger.d('OneInterceptor ${options.msg}');

    await showOkAlertDialog(
        context: Get.context!,
        title: 'one ${options.title}',
        message: options.msg);
    handler.next(options);
  }

  @override
  int get priority => super.priority;
}
