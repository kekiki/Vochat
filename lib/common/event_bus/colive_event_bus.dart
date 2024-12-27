import 'dart:async';

class ColiveEventBus {
  static ColiveEventBus? _instance;
  static ColiveEventBus get instance => _instance ??= ColiveEventBus();

  final StreamController _streamController;
  StreamController get streamController => _streamController;

  ColiveEventBus({bool sync = false})
      : _streamController = StreamController.broadcast(sync: sync);
  ColiveEventBus.customController(StreamController controller)
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
