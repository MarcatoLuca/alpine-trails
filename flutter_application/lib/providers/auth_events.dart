import 'dart:async';

class AuthEvents {
  static final _controller = StreamController<bool>.broadcast();
  static Stream<bool> get onLogout => _controller.stream;

  static void emitLogout() => _controller.add(true);
}