import 'dart:async';

final shareBus = EventBus();

class EventBus {
  EventBus({bool sync = true}) : _controller = StreamController(sync: sync);

  late final StreamController _controller;

  StreamController get controller => _controller;

  void fire<T>(T event) {
    _controller.sink.add(event);
  }

  Stream<T> on<T>() {
    if (T == dynamic) {
      return _controller.stream as Stream<T>;
    }
    return _controller.stream.where((event) => event is T).cast<T>();
  }

  void destroy() {
    _controller.close();
  }
}

typedef void EventCallback(arg);

class EventBusPlus {
  EventBusPlus._();
  static final EventBusPlus _eventBus = EventBusPlus._();
  factory EventBusPlus() => _eventBus;

  final _queue = Map<Object, List<EventCallback>?>();

  //添加订阅者
  void on(String eventName, EventCallback f) {
    _queue[eventName] ??= <EventCallback>[];
    _queue[eventName]!.add(f);
  }

  //移除订阅者
  void off(String eventName, [EventCallback? f]) {
    var list = _queue[eventName];
    if (eventName.isEmpty || list == null) return;
    if (f == null) {
      _queue[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  //触发事件，事件触发后该事件所有订阅者会被调用
  void emit(String eventName, [arg]) {
    var list = _queue[eventName];
    if (list == null) return;
    int len = list.length - 1;
    //反向遍历，防止订阅者在回调中移除自身带来的下标错位
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}
