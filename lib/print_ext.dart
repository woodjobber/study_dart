import 'package:study_dart/logger/logger.dart';

extension PrintExt on Object? {
  static var _msg = '';
  void get print => _print();

  Object? msg(dynamic msg) {
    _msg = msg;
    return this;
  }

  void _print() {
    logger.d('$_msg${this}');
    _msg = '';
  }
}
