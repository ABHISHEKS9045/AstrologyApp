import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPageModel extends ChangeNotifier {
  bool _switchVal = false;
  bool get switchVal => _switchVal;

  toggleSwitchbtn() {
    _switchVal = !_switchVal;
    notifyListeners();
  }

 
}
