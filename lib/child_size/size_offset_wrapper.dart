import 'package:flutter/material.dart';
import 'package:study_dart/child_size/render_size_object.dart';

class SizeOffsetWrapper extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onWidgetSizeChange;
  const SizeOffsetWrapper({
    Key? key,
    required this.onWidgetSizeChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSizeObject(onWidgetSizeChange: onWidgetSizeChange);
  }
}
