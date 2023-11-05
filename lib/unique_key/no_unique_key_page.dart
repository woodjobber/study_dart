import 'package:flutter/material.dart';
import 'color_state_widget.dart';

class UniqueKeyPage extends StatefulWidget {
  @override
  _UniqueKeyPageState createState() => _UniqueKeyPageState();
}

class _UniqueKeyPageState extends State<UniqueKeyPage> {
  late List<Widget> children;

  @override
  void initState() {
    super.initState();

    children = [
      ColorStateWidget(text: '1'),
      ColorStateWidget(text: '2'),
    ];
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.swap_horiz, size: 32),
          onPressed: swapTiles,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );

  void swapTiles() => setState(() {
        final child = children.removeAt(0);
        children.insert(1, child);
      });
}
