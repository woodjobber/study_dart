// ignore_for_file: avoid_print
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:study_dart/isolate_channel/isolate_channel_mixin.dart';

sealed class Amigo {}

class Lucky extends Amigo {}

class Dusty extends Amigo {}

class Ned extends Amigo {
  int someInt({int x = 0}) => x;
  String someString({String x = "2"}) => x;

  void test() {
    try {} on PossibleErrors catch (t, _) {
      switch (t) {
        case IntParseError _:
          t.error("Int");
        case StringParseError _:
          t.error("s");
        case ListParseError _:
          t.error("List");
      }
    }
  }

  static void createIsolate() {
    /// RootIsolateToken.instance 必须在 root isolate 上创建,如果在非 root isolate 上,instance 是 null
    RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
    ReceivePort receivePort = ReceivePort()
      ..listen((message) {
        print(message);
      });
    Isolate.spawn(_isolateGetData, [rootIsolateToken, receivePort.sendPort]);
  }

  static void _isolateGetData(List<Object> args) async {
    final rootIsolateToken = args.first as RootIsolateToken;
    final sendPort = args.last as SendPort;
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
    sendPort.send('发送消息，来自后台');
  }

  Future<Map<String, String>> parseStringToMap(
      {String assetsFileName = '.env'}) async {
    final lines = await rootBundle.loadString(assetsFileName);
    Map<String, String> environment = {};
    for (String line in lines.split('\n')) {
      line = line.trim();
      if (line.contains('=') //Set Key Value Pairs on lines separated by =
          &&
          !line.startsWith(RegExp(r'=\|#'))) {
        //No need to add empty keys and remove comments
        List<String> contents = line.split('=');
        environment[contents[0]] = contents.sublist(1).join('=');
      }
    }
    return environment;
  }
}

String lastName(Amigo amigo) => switch (amigo) {
      Lucky() => 'Day',
      Dusty() => 'Bottoms',
      Ned() => 'ned',
    };

// 您只能在定义它的同一文件中实现或扩展密封类。
// 密封类对外部扩展是封闭的。
// 密封类是隐式抽象的，因此无法实例化。
sealed class PossibleErrors implements Exception {
  void error(String e);
}

class IntParseError extends PossibleErrors {
  @override
  void error(String e) {
    log(e);
  }
}

class StringParseError extends PossibleErrors {
  @override
  void error(String e) {
    log(e);
  }
}

class ListParseError extends PossibleErrors {
  @override
  void error(String e) {
    log(e);
  }
}

void log(Object? message) {
  if (kDebugMode) {
    print(message);
  }
}

class Service with IsolateChannelMixin {
  Future<List<int>> performExpensiveWork() => run(() => _expensiveWork());
  Future<List<int>> performExpensiveWork2() => run(() => _expensiveWork());
  Future<List<int>> performExpensiveWork3() => run(() => _expensiveWork());
  Future<List<int>> performExpensiveWork4() => run(() => _expensiveWork());
  Future<List<int>> performExpensiveWork5() => run(() => _expensiveWork());
  Future<List<int>> performExpensiveWork6() => run(() => _expensiveWork());
  Future<List<int>> performExpensiveWork7() => run(() => _expensiveWork());
}

Future<List<int>> _expensiveWork() async {
  List<int> result = [];
  for (int i = 0; i < 1000000; i++) {
    result.add(i);
  }
  return result;
}

class Student {
  String _name;
  int _age;
  String get name => _name;
  set name(String name) => _name = name;
  int get age => _age;
  set age(int age) => _age = age;

  Student({int? age, String? name})
      : _name = name ?? '',
        _age = age ?? 0;

  Student.fromJson(Map<String, dynamic> map)
      : _name = map['name'] ?? '',
        _age = map['age'] ?? 0;

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      name: map['name'],
      age: map['age'],
    );
  }
}

/// mixin\extends\implements 同方法优先级问题
mixin A {
  void test() {
    print("object A");
  }
}
mixin B {
  void test() {
    print("object B");
  }
}

class C {
  void test() {
    print("object C");
  }
}

class D {
  void test() {
    print("object D");
  }

  void test2() {
    print("object D2");
  }
}

class AB extends C with A, B implements D {
  @override
  void test() {
    super.test();
  }

  @override
  void test2() {
    super.test();
  }
}

abstract class F {
  void test();
}
