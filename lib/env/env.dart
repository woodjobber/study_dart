// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _Env.baseUrl;
  @EnviedField(varName: 'PASSWORD', obfuscate: false)
  static String password = _Env.password;
  @EnviedField(varName: 'TEMP_URL', obfuscate: false)
  static String tempUrl = _Env.tempUrl;
}
