import 'package:get/get.dart';

class Once {
  Once._();
  static final Once _once = Once._();

  factory Once() => _once;

  final List<String> _tokens = [];

  static run(String token, void Function() func) {
    _once.call(token, func);
  }

  void call(String token, void Function() func) {
    if (_tokens.contains(token)) {
      return;
    }
    _tokens.addIf(token.isNotEmpty, token);
    func();
  }
}
