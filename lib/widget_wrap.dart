import 'package:flutter/material.dart';

class WidgetWrap extends StatelessWidget {
  const WidgetWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Wrap(
          spacing: 10.0,
          runSpacing: 50.0,
          children: List.generate(
            10,
            (index) => Chip(
              avatar: const CircleAvatar(
                backgroundColor: Colors.orangeAccent,
                child: Icon(Icons.person),
              ),
              label: const Text('wrap'),
              deleteIcon: const Icon(Icons.delete),
              onDeleted: () {},
              deleteIconColor: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}

class FrogColor extends InheritedWidget {
  const FrogColor({
    super.key,
    required this.color,
    required super.child,
  });
  final Color color;

  static FrogColor? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FrogColor>();
  }

  static FrogColor? ofInitState(BuildContext context) {
    return context.getElementForInheritedWidgetOfExactType<FrogColor>()?.widget
        as FrogColor;
  }

  static FrogColor of(BuildContext context) {
    final FrogColor? result = maybeOf(context);
    return result!;
  }

  @override
  bool updateShouldNotify(FrogColor oldWidget) {
    return color != oldWidget.color;
  }
}
