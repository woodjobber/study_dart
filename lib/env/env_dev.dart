// lib/env/env_dev.dart
import 'package:envied/envied.dart';

part 'env_dev.g.dart';

@Envied(path: '.env.development', name: 'EnvDev')
abstract class EnvDev {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _EnvDev.baseUrl;
  @EnviedField(varName: 'PASSWORD', obfuscate: true)
  static String password = _EnvDev.password;
}
