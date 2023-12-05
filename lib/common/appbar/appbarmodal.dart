import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../styles/const.dart';

class AppBarModalPage extends ChangeNotifier {

  String TAG = "AppBarModalPage";

  int _counter = 0;
  int get counter => _counter;
  int testCount = 400;

  setCount(int count) {
    _counter = count;
    notifyListeners();
  }

  resetCount() {
    _counter = 0;
    notifyListeners();
  }

  getNotificationList(BuildContext context, String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "user_id": userid,
      "type": type,
    });
    var response = await dio.post("${baseURL}view_notfication", data: formData);
    final responseData = json.decode(response.toString());
    debugPrint("$TAG responseData ========> $responseData");
    try {
      if (responseData['status'] == true) {
        setCount(responseData["count"]);
        notifyListeners();
      } else {
      }
    } catch (e) {
      debugPrint('$TAG Error getNotificationList =======> ${e.toString()}');
    }
  }
}
