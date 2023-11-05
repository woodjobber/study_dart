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

    /// 如果有状态小部件在小部件树中移动，请使用 Flutter UniqueKey 来保留它们的状态。
    children = [
      ColorStateWidget(key: UniqueKey(), text: '1'),
      ColorStateWidget(key: UniqueKey(), text: '2'),
      // Container(key: UniqueKey(), child: ColorStateWidget(text: '1')),
      // Container(key: UniqueKey(), child: ColorStateWidget(text: '2')),
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
