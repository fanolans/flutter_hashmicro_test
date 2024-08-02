import 'dart:async';
import 'dart:ui';

class Debouncer {
  final int second;
  Timer? _timer;

  Debouncer({required this.second});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: second), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
