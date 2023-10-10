import 'dart:async';
import 'dart:collection';
import 'dart:isolate';
import 'dart:ui';

import 'package:study_dart/isolate_channel/initalize_isolate_token.dart';
import 'package:study_dart/isolate_channel/isolate_entry.dart';
import 'package:study_dart/isolate_channel/run_isolate_entry.dart';

mixin class IsolateChannelMixin {
  static const int _maxIsolates = 3;
  int _currentIsolate = 0;
  final Queue<Function> _taskQueue = Queue();

  Future<T> run<T>(Future<T> Function() function) async {
    if (_currentIsolate < _maxIsolates) {
      _currentIsolate++;
      return _executeIsolate(function);
    }
    final completer = Completer<T>();
    _taskQueue.add(() async {
      final result = await _executeIsolate(function);
      completer.complete(result);
    });
    return completer.future;
  }

  Future<T> _executeIsolate<T>(Future<T> Function() function) async {
    final ReceivePort receivePort = ReceivePort();
    final RootIsolateToken rootIsolateToken =
        IsolateTokenHelper().rootIsolateToken;
    final isolate = await Isolate.spawn(
        isolateEntryPoint,
        IsolateEntry(
            function: function,
            sendPort: receivePort.sendPort,
            rootIsolateToken: rootIsolateToken));
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
