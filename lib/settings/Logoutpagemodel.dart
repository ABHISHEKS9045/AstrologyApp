import 'dart:convert';
import 'package:astrologyapp/common/apiErroralertdiloge.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/styles/const.dart';

class LogoutModelPage extends ChangeNotifier {
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

  List _notificationList = [];
  List get notificationList => _notificationList;

  List _notificationListsignup = [];
  List get notificationListsignup => _notificationListsignup;

  var _signupdate;
  get signupdate => _signupdate;

  var _notificationdate;
  get notificationdate => _notificationdate;

  var _notificationdatestring;
  get notificationdatestring => _notificationdatestring;

  var _notificationdatebool;
  get notificationdatebool => _notificationdatebool;

  getclear() {
   // print('vvk dispose');
    _notificationListsignup = [];
    notifyListeners();
   // print('vinay $notificationListsignup');
  }

  Logoutuser(context) async {
    toggleshemmerShow();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');
    String? reseverFtoken = prefs.getString('firebase_device_id');

    // var useridconvertint = userid?.substring(
    //     1,
    //     userid.length -
    //         1); //shareprefrence se " "46" " ese aa rha tha ise convert se "46 kiya"
    var reseverFtokenInt = reseverFtoken?.substring(
        1,
        reseverFtoken.length -
            1); //shareprefrence se " "46" " ese aa rha tha ise convert se "46 kiya"

    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "user_id": userid,
      "device_id": reseverFtokenInt,
    });
   // print('perameter ${formData.fields}');
    var response = await dio.post(
        baseURL+"view_notfication",
        data: formData);

    final responseData = json.decode(response.toString());
    //map is not a subtype of string error aaye to ye then apply

    //// print('vinayresponse $responseData');
    //// print('vinayresponse11 ${responseData['status']}');

    try {
      if (responseData['status'] == true) {
       // print('vkglistall $notificationList');
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
