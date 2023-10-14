import 'package:flutter/material.dart';

typedef Destroy = void Function();

/// https://stackoverflow.com/questions/57840704/how-do-i-correctly-mixin-on-state
mixin EffectState<T extends StatefulWidget> on State<T> {
  Destroy? destroy;
  void useEffect(Destroy? Function() effect) {
    destroy = effect.call();
  }

  @override
  void dispose() {
    destroy?.call();
    super.dispose();
  }
}
