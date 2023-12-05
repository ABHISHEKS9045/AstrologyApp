import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constants {
  static showToast(String toast) {
    return Fluttertoast.showToast(
      msg: toast,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      
      timeInSecForIosWeb: 1,
      backgroundColor: colororangeLight,
      textColor: Colors.white,
    );
  }
}
