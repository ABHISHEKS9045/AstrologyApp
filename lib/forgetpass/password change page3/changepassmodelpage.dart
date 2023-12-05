import 'dart:convert';

import 'package:astrologyapp/common/apiErroralertdiloge.dart';
import 'package:astrologyapp/login%20Page/LoginPage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/styles/const.dart';
import '../../login Page/social login/loginController.dart';

class ChangePassModelPage extends ChangeNotifier {

  static const String TAG = "ChangePassModelPage";

  bool _obscuretext1 = true;

  bool get obscuretext1 => _obscuretext1;

  bool _obscuretext2 = true;

  bool get obscuretext2 => _obscuretext2;

  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  toggle1() {
    _obscuretext1 = !_obscuretext1;
    notifyListeners();
  }

  toggle2() {
    _obscuretext2 = !_obscuretext2;
    notifyListeners();
  }

  bool _isShimmer = false;

  bool get isShimmer => _isShimmer;

  toggleshemmerShow() {
    _isShimmer = true;
    notifyListeners();
  }

  toggleshemmerdismis() {
    _isShimmer = false;
    notifyListeners();
  }


  changepasswordsubmit(BuildContext context, String userid) async {

    debugPrint("$TAG new password =======> ${newPassword.text.toString().trim()}");
    debugPrint("$TAG new password =======> $userid");

    toggleshemmerShow();
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "user_id": userid,
      "password": newPassword.text.toString().trim(),
    });
    var response = await dio.post("${baseURL}reset_password", data: formData);
    final responseData = json.decode(response.data);
    debugPrint("$TAG responseData ==========> $responseData");
    try {
      if (responseData['status'] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        toggleshemmerShow();

        Fluttertoast.showToast(msg: "Password changed successfully. Please login");

        final controller = Get.put(LoginController());
        controller.logout(context);

        toggleshemmerdismis();
        newPassword.clear();
        confirmPassword.clear();
        notifyListeners();
      } else {
        toggleshemmerShow();
        var messages = responseData["message"];
        apiErrorAlertdialog(context, messages);
        toggleshemmerdismis();
      }
    } catch (e) {
      // print('Error: ${e.toString()}');
    }
  }
}
