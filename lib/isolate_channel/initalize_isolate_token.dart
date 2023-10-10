import 'package:flutter/services.dart';

class IsolateTokenHelper {
  final RootIsolateToken rootIsolateToken;
  IsolateTokenHelper() : rootIsolateToken = RootIsolateToken.instance! {
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
  }
}
