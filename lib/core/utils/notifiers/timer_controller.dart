import 'dart:async';

import 'package:flutter/foundation.dart';

class TimerController extends ChangeNotifier implements ValueListenable<String> {
  Timer? _timer;
  Duration _remainingTime;
  Duration _totalDuration;

  TimerController(this._totalDuration) : _remainingTime = _totalDuration;

  Duration get remainingTime => _remainingTime;
  Duration get totalDuration => _totalDuration;

  double get progress => (_totalDuration.inMilliseconds - _remainingTime.inMilliseconds) / _totalDuration.inMilliseconds;

  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_remainingTime > const Duration(milliseconds: 100)) {
        _remainingTime -= const Duration(milliseconds: 100);
        notifyListeners();
      } else {
        _remainingTime = Duration.zero;
        _timer?.cancel();
        notifyListeners();
      }
    });
  }

  void reset({Duration? duration}) {
    _totalDuration = duration ?? _totalDuration;
    _remainingTime = _totalDuration;
    _timer?.cancel();
    notifyListeners();
  }

  void stop() {
    _timer?.cancel();
  }

  bool get isCountingDown => _timer != null && _timer?.isActive == true;

  bool get hasCompleted => remainingTime == Duration.zero;

  String get _timerText {
    if (remainingTime.inSeconds > 600) {
      return "00";
    }
    final int minutesToInt = _minutes.floor();
    final String minute = minutesToInt.toString().length <= 1 ? "0$minutesToInt" : "$minutesToInt";
    final String second = _seconds.toString().length <= 1 ? "0$_seconds" : "$_seconds";
    return "$minute:$second";
  }

  int get _seconds {
    if (_remainingTime.inSeconds > 600) {
      return 0;
    }
    return _remainingTime.inSeconds % 60;
  }

  double get _minutes {
    return _remainingTime.inSeconds / 60;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  String get value => _timerText;
}
