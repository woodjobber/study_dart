import 'dart:isolate';
import 'dart:ui';

class IsolateEntry {
  const IsolateEntry({
    required this.function,
    required this.sendPort,
    required this.rootIsolateToken,
  });
  final Future Function() function;
  final SendPort sendPort;
  final RootIsolateToken rootIsolateToken;
}
