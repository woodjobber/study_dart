import 'package:flutter/material.dart';

class KeepAlivePage extends StatefulWidget {
  const KeepAlivePage({
    Key? key,
    required this.child,
    this.keepAlive = true,
  }) : super(key: key);
  final Widget child;
  final bool keepAlive;
  @override
  State<KeepAlivePage> createState() => _KeepAliveState();
}

class _KeepAliveState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepAlivePage oldWidget) {
    if (oldWidget != widget.child || oldWidget.keepAlive != widget.keepAlive) {
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
