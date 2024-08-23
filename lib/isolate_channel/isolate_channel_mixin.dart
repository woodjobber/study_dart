import 'dart:async';
import 'dart:collection';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'initialize_isolate_token.dart';
import 'isolate_entry.dart';
import 'run_isolate_entry.dart';

mixin IsolateChannelMixin {
  static const int _maxIsolates = 9;
  int _currentIsolate = 0;
  final Queue<Function> _taskQueue = Queue();

  Future<T> run<T, U>(
      FutureOr<T> Function(U message) function, U message) async {
    WidgetsFlutterBinding.ensureInitialized();
    if (_currentIsolate < _maxIsolates) {
      _currentIsolate++;
      return _executeIsolate<T, U>(function, message);
    }
    final completer = Completer<T>();
    _taskQueue.add(() async {
      final result = await _executeIsolate<T, U>(function, message);
      completer.complete(result);
    });
    return completer.future;
  }

  Future<T> _executeIsolate<T, U>(
      FutureOr<T> Function(U message) function, U message) async {
    final ReceivePort receivePort = ReceivePort();
    final RootIsolateToken rootIsolateToken =
        IsolateTokenHelper().rootIsolateToken;
    final isolate = await Isolate.spawn(
        isolateEntryPoint<T, U>,
        IsolateEntry<T, U>(
          function: function,
          sendPort: receivePort.sendPort,
          rootIsolateToken: rootIsolateToken,
          message: message,
        ));
    return receivePort.first.then((data) {
      _currentIsolate--;
      if (_currentIsolate < 0) {
        _currentIsolate = 0;
      }
      _runNextTask();
      if (data is T) {
        isolate.kill(priority: Isolate.immediate);
        return data;
      } else {
        isolate.kill(priority: Isolate.immediate);
        throw data;
      }
    });
  }

  void _runNextTask() {
    if (_taskQueue.isNotEmpty) {
      final nextTask = _taskQueue.removeFirst();
      nextTask();
    }
  }
}
