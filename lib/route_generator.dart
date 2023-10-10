import 'package:flutter/material.dart';
import 'package:quiver/core.dart';
import 'package:study_dart/app.dart';

typedef PageRouteGenerator = Widget Function(BuildContext context,
    {dynamic arguments});

class RouteGenerator {
  static final Map<String, PageRouteGenerator> routes = {
    '/': (BuildContext context, {dynamic arguments}) => const App(),
  };
  static Route<dynamic>? generateRoute(RouteSettings setting) {
    final args = setting.arguments;
    final String name = setting.name ?? "";
    final PageRouteGenerator pageContentBuilder =
        routes[name] as PageRouteGenerator;
    debugPrint(args as String?);

    if (args != null) {
      final Route route = MaterialPageRoute(
          settings: setting,
          builder: (context) => pageContentBuilder(context, arguments: args));
      return route;
    } else {
      final Route route = MaterialPageRoute(
          settings: setting, builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
}

// @see https://www.dhiwise.com/post/decoding-the-dart-covariant-keyword-dart-flutter-exploration
class Animal {
  covariant Animal child;
  Animal(this.child);
  void chase(covariant Animal x) {}
}

class Mouse extends Animal {
  Mouse(super.child);
}

class Cat extends Animal {
  Cat(super.child);

  @override
  void chase(covariant Mouse x) {}
}

class Point {
  final int x, y;
  Point(this.x, this.y);
  //@override
  // bool operator ==(Object other) {
  //   if (other is Point) {
  //     return x == other.x && y == other.y;
  //   }
  //   return false;
  // }
  // covariant: 协变，Covariant 是一个关键字，允许您使用作为原始类型的子类的新参数类型来重写方法。
  // 当您希望为不同类型的参数提供更精确的行为而不破坏与超类函数的兼容性时，这非常方便。
  // 协变是一个奇特的类型理论术语，但它基本上意味着“这个类或其子类”。
  // 换句话说，它意味着类型层次结构中相同或较低的类型。
  // @see https://stackoverflow.com/questions/71237639/functioning-of-covariant-in-flutter
  @override
  bool operator ==(covariant Point other) => x == other.x && y == other.y;

  @override
  int get hashCode => hashObjects([x, y]);
}

class Game {
  void play(covariant Game game) {}
}

class Team {
  covariant List<Game> games;
  Team(this.games);
}

class FootballGame extends Game {
  @override
  void play(FootballGame game) {
    super.play(game);
  }
}

class FootballTeam extends Team {
  FootballTeam(super.games);
}
