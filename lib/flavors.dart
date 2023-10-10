import 'package:study_dart/env/env_dev.dart';
import 'package:study_dart/env/env_prod.dart';

import 'env/env.dart';

enum Flavor {
  prod,
  dev,
  stg,
}

class F {
  static Flavor appFlavor = Flavor.dev;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.prod:
        return 'Apple';
      case Flavor.dev:
        return 'Banana';
      case Flavor.stg:
        return '栗子';
      default:
        return 'title';
    }
  }

  static String get baseUrl => switch (appFlavor) {
        Flavor.prod => EnvProd.baseUrl,
        Flavor.dev => EnvDev.baseUrl,
        Flavor.stg => Env.baseUrl,
      };
}
