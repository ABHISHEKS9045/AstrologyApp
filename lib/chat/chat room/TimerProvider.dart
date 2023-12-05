
import 'package:flutter/foundation.dart';

class TimerProvider extends ChangeNotifier {


  int _remainingTime = 0;

  int getRemainingTime() => _remainingTime;

  setRemainingTime(int availableTime) {
    _remainingTime = availableTime;
    notifyListeners();
  }

  updateRemainingTime() {
    _remainingTime--;
    notifyListeners();
  }
}