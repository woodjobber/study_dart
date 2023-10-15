import 'package:flutter/material.dart';

typedef Destroy = void Function();

/// https://stackoverflow.com/questions/57840704/how-do-i-correctly-mixin-on-state
mixin EffectState<T extends StatefulWidget> on State<T> {
  List<Destroy> destroys = [];
  EffectState useEffect(Destroy? Function() effect) {
    final destroy = effect.call();
    if (destroy != null) {
      destroys.add(destroy);
    }
    return this;
  }

  EffectState autoDispose(Destroy destroy) {
    destroys.add(destroy);
    return this;
  }

  @override
  void dispose() {
    destroys.forEach((destroy) {
      destroy.call();
    });
    destroys.clear();
    super.dispose();
  }
}
