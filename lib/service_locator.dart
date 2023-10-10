import 'package:get_it/get_it.dart';
import 'package:study_dart/navigate_service.dart';

GetIt getIt = GetIt.instance;
NavigateService navigator = getIt.get<NavigateService>();

class ServiceLocator {
  static ServiceLocator? _instance;
  ServiceLocator._internal() {
    _instance = this;
  }
  factory ServiceLocator() => _instance ?? ServiceLocator._internal();

  static ServiceLocator share = _instance ?? ServiceLocator();

  static ServiceLocator instance() => ServiceLocator._internal();
  static ServiceLocator get s => share;

  void setup() {
    getIt.registerSingleton<NavigateService>(NavigateService());
  }
}

class Vehicle {
  Vehicle(this.color);
  final String color;
  final String definiton = "v";

  void method() {}
}

class Car implements Vehicle {
  @override
  // TODO: implement color
  String get color => throw UnimplementedError();

  @override
  // TODO: implement definiton
  String get definiton => throw UnimplementedError();

  @override
  void method() {}
}

class Car2 extends Vehicle {
  Car2(super.color);
}
