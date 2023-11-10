import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

class CustomTapGestureRecognizer extends TapGestureRecognizer {
  CustomTapGestureRecognizer._();
  @override
  void rejectGesture(int pointer) {
    // 强制接受
    super.acceptGesture(pointer);
  }

  static RawGestureDetector detector({
    GestureTapCallback? onTap,
    GestureTapDownCallback? onTapDown,
    Widget? child,
    HitTestBehavior? behavior,
    bool excludeFromSemantics = false,
    SemanticsGestureDelegate? semantics,
  }) {
    return RawGestureDetector(
      child: child,
      behavior: behavior,
      excludeFromSemantics: excludeFromSemantics,
      semantics: semantics,
      gestures: {
        CustomTapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<CustomTapGestureRecognizer>(
                () => CustomTapGestureRecognizer._(), (detector) {
          detector
            ..onTapDown = onTapDown
            ..onTap = onTap;
        }),
      },
    );
  }
}
