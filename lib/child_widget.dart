import 'package:flutter/material.dart';
import 'package:study_dart/logger/logger.dart';

class ChildWidget extends StatefulWidget {
  const ChildWidget({super.key});

  @override
  State<ChildWidget> createState() => _ChildWidgetState();
}

class _ChildWidgetState extends State<ChildWidget> {
  @override
  void initState() {
    super.initState();
    logger.d('initState = _ChildWidgetState');
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    logger.d('didChangeDependencies = _ChildWidgetState');
  }

  @override
  void didUpdateWidget(covariant ChildWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    logger.d('didUpdateWidget = _ChildWidgetState');
  }

  @override
  void deactivate() {
    logger.d('deactivate _ChildWidgetState');
    super.deactivate();
  }

  @override
  void dispose() {
    logger.d('dispose _ChildWidgetState');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logger.d('build _ChildWidgetState');
    return Center(
      child: Text('我是 Child'),
    );
  }
}
