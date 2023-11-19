import 'package:flutter/material.dart';
import 'package:study_dart/child_widget.dart';

import 'logger/logger.dart';

/// 第一次构建时调用顺序：initState -> didChangeDependencies -> build
/// 执行 父 setState 函数时，父build -> 子 didUpdateWidget -> 子build
/// hot reload , 父/子 reassemble -> 父 didUpdateWidget -> 父build -> 子didUpdateWidget -> 子build
///
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
      logger.d('setState....');
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    logger.d('didChangeDependencies = _FartherWidgetState');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FartherWidget oldWidget) {
    logger.d('didUpdateWidget = _FartherWidgetState');
    super.didUpdateWidget(oldWidget);

    // 在这里调用 setState 无意义，因为build 始终会执行.
  }

  @override
  void reassemble() {
    logger.d('reassemble = _FartherWidgetState');
    super.reassemble();
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
