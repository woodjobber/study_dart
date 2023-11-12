import 'dart:async';

// 处理拦截器，将前一个拦截器的结果作为参数传递给下一个拦截器
class DialogInterceptorHandler<T> {
  final _completer = Completer<T>();

  Future<T> get future => _completer.future;

  bool get isCompleted => _completer.isCompleted;

  void next(T options) {
    _completer.complete(options);
  }
}
