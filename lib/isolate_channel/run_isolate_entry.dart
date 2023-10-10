import 'package:flutter/services.dart';
import 'package:study_dart/isolate_channel/isolate_entry.dart';

Future isolateEntryPoint(IsolateEntry entry) async {
  final Function function = entry.function;
  try {
    BackgroundIsolateBinaryMessenger.ensureInitialized(entry.rootIsolateToken);
  } on MissingPluginException catch (e) {
    return Future.error(e.toString());
  }
  final result = await function();
  entry.sendPort.send(result);
}
