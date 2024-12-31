import 'dart:async';

class VochatEventBus {
  static VochatEventBus? _instance;
  static VochatEventBus get instance => _instance ??= VochatEventBus();

  final StreamController _streamController;
  StreamController get streamController => _streamController;

  VochatEventBus({bool sync = false})
      : _streamController = StreamController.broadcast(sync: sync);
  VochatEventBus.customController(StreamController controller)
      : _streamController = controller;

  Stream<T> on<T>() {
    if (T == dynamic) {
      return streamController.stream as Stream<T>;
    } else {
      return streamController.stream.where((event) => event is T).cast<T>();
    }
  }

  void fire(event) {
    streamController.add(event);
  }

  void destroy() {
    _streamController.close();
  }
}
