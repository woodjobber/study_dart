import 'package:study_dart/dialog_interceptor/dialog_options.dart';

import 'dialog_interceptor_handler.dart';

// 拦截器接口
abstract class DialogInterceptor<T extends DialogOptions> {
  DialogInterceptor({this.priority = 0});
  void intercept(T options, DialogInterceptorHandler<T> handler) {
    handler.next(options);
  }

  /// 执行顺序  -1 > 0 > 1 > 2 . `priority` 值越小优先级越高.
  int priority;
}
