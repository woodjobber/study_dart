import 'dart:async';

import 'package:flutter/services.dart';
import 'isolate_entry.dart';

void isolateEntryPoint<T, U>(IsolateEntry<T, U> entry) async {
  final FutureOr<T> Function(U) function = entry.function;
  try {
    BackgroundIsolateBinaryMessenger.ensureInitialized(entry.rootIsolateToken);
  } on MissingPluginException catch (e) {
    return Future.error(e.toString());
  }
  final result = await function(entry.message);
  entry.sendPort.send(result);
}
