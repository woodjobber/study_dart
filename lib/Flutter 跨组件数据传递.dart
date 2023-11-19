import 'package:flutter/cupertino.dart';

/// 向下传递数据 ： 父 -> 子
/// 更新依赖，依赖指的是 调用 ShareDataWidget.of(context) 的子widget
class ShareDataWidget<T> extends InheritedWidget {
  final T data;
  final Widget child;
  ShareDataWidget({required this.child, required this.data})
      : super(child: child);

  static ShareDataWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>()!;
  }

  @override
  bool updateShouldNotify(covariant ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}

/// 向上传递数据, 子 -> 父 ,冒泡通知
/// 回调方式

class MyCustomNotification extends Notification {}

class MyCustomNotificationWidget extends StatelessWidget {
  const MyCustomNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<MyCustomNotification>(
      child: Placeholder(),
      onNotification: (notification) {
        // false: 继续冒泡，true: 取消冒泡
        return false;
      },
    );
  }
}

/// EventBus
/// 页面之间传递数据 @see event_bus.dart
///
/// https://gist.github.com/gspencergoog/d7bfef5df6bd627d9aaf8e817c850dfa
/// InheritedWidget and ChangedNotifier
///
class CustomInheritedNotifier extends InheritedNotifier<InfoNotifier> {
  CustomInheritedNotifier({
    Key? key,
    required super.child,
    InfoNotifier? notifier,
  }) : super(key: key, notifier: notifier);
  static double of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CustomInheritedNotifier>()!
        .notifier!
        .value;
  }
}

class InfoNotifier extends ChangeNotifier {
  InfoNotifier();
  double get value => _value;
  double _value = 0;
  set value(double value) {
    if (_value != value) {
      _value = value;
      notifyListeners();
    }
  }
}

class _InheritedNotifier<T extends ChangeNotifier>
    extends InheritedNotifier<T> {
  _InheritedNotifier({
    super.key,
    required this.load,
    required super.child,
    T? notifier,
  }) : super(notifier: notifier);

  final T Function() load;
}

extension ReadContext on BuildContext {
  T read<T extends ChangeNotifier>() {
    final inheritedNotifier =
        findAncestorWidgetOfExactType<_InheritedNotifier<T>>();
    return inheritedNotifier!.notifier ?? inheritedNotifier.load();
  }

  T watch<T extends ChangeNotifier>() {
    final inheritedNotifier =
        dependOnInheritedWidgetOfExactType<_InheritedNotifier<T>>();

    return inheritedNotifier!.notifier ?? inheritedNotifier.load();
  }
}

class Provider<T extends ChangeNotifier> extends StatefulWidget {
  const Provider(
      {Key? key,
      required T Function() create,
      this.lazy = true,
      required this.child})
      : _create = create,
        _value = null,
        super(key: key);

  const Provider.value({
    Key? key,
    required T value,
    required this.child,
  })  : lazy = false,
        _create = null,
        _value = value,
        super(key: key);

  final Widget child;
  final T Function()? _create;
  final T? _value;
  final bool lazy;

  @override
  State<Provider<T>> createState() => _ProviderState<T>();
}

class _ProviderState<T extends ChangeNotifier> extends State<Provider<T>> {
  T? notifier;
  T load() {
    if (notifier == null) {
      notifier = widget._create!.call();
      Future.delayed(Duration.zero, () => setState(() {}));
    }
    return notifier!;
  }

  @override
  void dispose() {
    if (widget._value == null) notifier?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.lazy) notifier ??= widget._value ?? widget._create!();
    return _InheritedNotifier(
      load: load,
      child: widget.child,
      notifier: notifier,
    );
  }
}
