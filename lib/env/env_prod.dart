// lib/env/env_prod.dart
import 'package:envied/envied.dart';

part 'env_prod.g.dart';

@Envied(path: '.env.production')
abstract class EnvProd {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _EnvProd.baseUrl;
  @EnviedField(varName: 'PASSWORD', obfuscate: true)
  static String password = _EnvProd.password;
}
