import 'dart:collection';

import 'package:study_dart/dialog_interceptor/dialog_options.dart';
import 'package:study_dart/dialog_interceptor/dialog_interceptor_handler.dart';

import 'dialog_interceptor.dart';

// 拦截器链，管理拦截器
class DialogInterceptorChain<T extends DialogOptions,
    U extends DialogInterceptor> {
  DialogInterceptorChain({
    this.distinctEnable = true,
  });

  final List<U> _interceptors = <U>[];

  /// 是否去重 `DialogInterceptor` ，按 runtimeType 去重.
  final bool distinctEnable;

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

  void _distinct() {
    final result = (LinkedHashSet<U>(
            equals: (a, b) => a.runtimeType == b.runtimeType,
            hashCode: (e) => e.runtimeType.hashCode)
          ..addAll(_interceptors))
        .toList();
    _interceptors.clear();
    _interceptors.addAll(result);
  }

  Future<void> _processInterceptors(T options) async {
    if (_interceptors.isEmpty) {
      return;
    }
    if (distinctEnable) {
      _distinct();
    }

    // 处理优先级
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

  Iterable<E> removeDuplicates<E>(Iterable<E> iterable) sync* {
    Set<E> items = {};
    for (E item in iterable) {
      if (!items.contains(item)) yield item;
      items.add(item);
    }
  }
}
