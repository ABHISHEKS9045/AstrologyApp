import 'dart:convert';
import 'package:astrologyapp/common/apiErroralertdiloge.dart';
import 'package:astrologyapp/common/commonwidgets/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/styles/const.dart';

class GoogleSignUpModelPage extends ChangeNotifier {
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

  exsitingUserCheck(context) async {
   // print("vinayexist");
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "email_id": 'vinay@gmail.com',
    });
    toggleshemmerShow();
    var response = await dio.post(baseURL+"check_exsists", data: formData);
    final responseData = json.decode(response.data);
   // print('vinay1 $responseData');
    try {
      if (responseData['status'] == true) {
        toggleshemmerdismis();
       // print('vinay login response userid ${responseData['id']}');
        // // print('vinay login response userid split  ${responseData['id']?.substring(1, responseData['id'].length - 1)}');
        Constants.showToast('Login Successfull');
        await Future.delayed(Duration(seconds: 1));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
          'login_user_id',
          json.encode(
            // responseData['data']['id'],
            responseData['id'],
          ),
        );

        // Get.offAll(() => BottomNavBarPage());

        notifyListeners();
      } else {
        toggleshemmerdismis();
       // print('Error: ${responseData["message"]}');

        var messages = responseData["message"];
        apiErrorAlertdialog(context, messages);
      }
    } catch (e) {
      toggleshemmerdismis();
     // print('Error: ${e.toString()}');
    }
  }
}
