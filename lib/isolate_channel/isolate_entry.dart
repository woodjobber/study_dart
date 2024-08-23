import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

class IsolateEntry<T, U> {
  const IsolateEntry({
    required this.function,
    required this.sendPort,
    required this.rootIsolateToken,
    required this.message,
  });
  final FutureOr<T> Function(U) function;
  final SendPort sendPort;
  final RootIsolateToken rootIsolateToken;
  final U message;
}
