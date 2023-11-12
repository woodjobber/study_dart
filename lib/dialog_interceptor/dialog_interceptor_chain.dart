import 'package:study_dart/dialog_interceptor/dialog_options.dart';
import 'package:study_dart/dialog_interceptor/dialog_interceptor_handler.dart';

import 'dialog_interceptor.dart';

// 拦截器链，管理拦截器
class DialogInterceptorChain<T extends DialogOptions,
    U extends DialogInterceptor> {
  DialogInterceptorChain();

  final List<U> _interceptors = <U>[];

  DialogInterceptorChain addInterceptor(U interceptor) {
    _interceptors.add(interceptor);
    return this;
  }

  DialogInterceptorChain addInterceptors(List<U> interceptors) {
    _interceptors.addAll(interceptors);
    return this;
  }

  void _processInterceptorsPriority() {
    _interceptors.sort((a, b) => a.priority.compareTo(b.priority));
  }

  void removeInterceptor(Type type) {
    _interceptors.removeWhere((e) => e.runtimeType == type);
  }

  void send(T options) async {
    await _processInterceptors(options);

    /// 正常处理
  }

  Future<void> _processInterceptors(T options) async {
    if (_interceptors.isEmpty) {
      return;
    }
    _processInterceptorsPriority();
    int index = 0;
    var _options = options;
    final interceptors = _interceptors;
    while (index < interceptors.length) {
      final interceptor = interceptors[index];
      final handler = DialogInterceptorHandler<T>();
      interceptor.intercept(_options, handler);
      _options = await handler.future;
      index++;
    }
  }
}
