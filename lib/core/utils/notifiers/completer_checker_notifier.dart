import 'package:flutter/foundation.dart';

class CompleteCheckerNotifier extends ChangeNotifier implements ValueListenable<bool> {
  final bool Function() _checkerCallback;
  late bool _lastCheck = false;

  CompleteCheckerNotifier(this._checkerCallback) {
    _lastCheck = _checkerCallback();
  }

  @override
  bool get value => _lastCheck;

  void checkIsDataCompleted() {
    final bool currentCheck = _checkerCallback();

    if (_lastCheck != currentCheck) {
      _lastCheck = currentCheck;
      notifyListeners();
    }
  }
}
