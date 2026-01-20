import 'dart:async';
import 'package:flutter/material.dart';

class ActivityService with ChangeNotifier {
  Timer? _timer;
  int _seconds = 0;
  double _distance = 0.0;
  bool _isActive = false;
  bool _isPaused = false;

  int get seconds => _seconds;
  double get distance => _distance;
  bool get isActive => _isActive;
  bool get isPaused => _isPaused;

  void startActivity() {
    if (_isActive) return;
    _isActive = true;
    _isPaused = false;
    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        _seconds++;
        _distance += 0.0014; // Simulazione GPS
        notifyListeners(); // Notifica tutte le pagine che i numeri stanno cambiando
      }
    });
  }

  void togglePause() {
    _isPaused = !_isPaused;
    notifyListeners();
  }

  void stopActivity() {
    _timer?.cancel();
    _isActive = false;
    _isPaused = false;
    _seconds = 0;
    _distance = 0.0;
    notifyListeners();
  }

  String get formattedTime {
    int h = _seconds ~/ 3600;
    int m = (_seconds % 3600) ~/ 60;
    int s = _seconds % 60;
    return "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }
}