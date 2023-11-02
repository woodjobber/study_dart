import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef void OnWidgetSizeChange(Size size);

class RenderSizeObject extends RenderProxyBox {
  Size currentSize = Size.zero;
  final OnWidgetSizeChange onWidgetSizeChange;
  RenderSizeObject({
    required this.onWidgetSizeChange,
  });

  @override
  void performLayout() {
    super.performLayout();
    Size? newSize = child?.size;
    if (newSize != null && currentSize != newSize) {
      currentSize = newSize;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        onWidgetSizeChange.call(newSize);
      });
    }
  }
}
