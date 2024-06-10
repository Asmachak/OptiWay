import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountdownTimerNotifier extends StateNotifier<int> {
  CountdownTimerNotifier(int duration) : super(duration);

  Timer? _timer;

  void initialize() {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        state--;
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final countdownTimerProvider =
    StateNotifierProvider.family<CountdownTimerNotifier, int, int>(
        (ref, duration) => CountdownTimerNotifier(duration));
