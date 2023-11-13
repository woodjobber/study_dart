import 'package:flutter/material.dart';
import 'package:study_dart/child_widget.dart';

import 'logger/logger.dart';

class FartherWidget extends StatefulWidget {
  const FartherWidget({super.key});

  @override
  State<FartherWidget> createState() => _FartherWidgetState();
}

class _FartherWidgetState extends State<FartherWidget> {
  @override
  void initState() {
    super.initState();
    logger.d('initState = _FartherWidgetState');
    Future.delayed(Duration(seconds: 5)).then((value) {
      /// 执行1万次，仅仅会 build 一次。原因是 markNeedsBuild() 中 dirty 为 true时，会直接返回.
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    logger.d('didChangeDependencies = _FartherWidgetState');
  }

  @override
  void didUpdateWidget(covariant FartherWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    logger.d('didUpdateWidget = _FartherWidgetState');
  }

  @override
  void deactivate() {
    logger.d('deactivate _FartherWidgetState');
    super.deactivate();
  }

  @override
  void dispose() {
    logger.d('deactivate _FartherWidgetState');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logger.d('build  _FartherWidgetState');
    return Scaffold(
      body: ChildWidget(),
    );
  }
}
