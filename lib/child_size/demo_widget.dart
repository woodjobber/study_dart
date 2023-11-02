import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

abstract class DemoWidget extends StatefulWidget {
  String get title;
  const DemoWidget();
  @override
  DemoWidgetState createState();
}

abstract class DemoWidgetState extends State<DemoWidget> {
  Widget buildContent();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Opacity(
        opacity: 1,
        child: Padding(
          padding: EdgeInsets.all(32),
          child: buildContent(),
        ),
      ),
    );
  }
}
