import 'dart:convert';
import 'dart:io';

import 'package:astrologyapp/common/apiErroralertdiloge.dart';
import 'package:astrologyapp/common/bottomnavbar/bottomnavbar.dart';
import 'package:astrologyapp/common/commonwidgets/toast.dart';
import 'package:astrologyapp/dashboard/dashboardModelPage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/styles/const.dart';

class FeedbackPageModel extends ChangeNotifier {
  bool _autovalidate = false;

  bool get autovalidate => _autovalidate;

  toggleautovalidate() {
    _autovalidate = !_autovalidate;
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

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  String? _feedbacktype;

  String? get feedbacktype => _feedbacktype;

  double? _ratingappcount = 3.0;

  double? get ratingappcount => _ratingappcount;

  List _feedbacktypeList = ['hiii', 'Good', 'Error'];

  List get feedbacktypeList => _feedbacktypeList;

  togglefeedbacktype(valueftype) {
    _feedbacktype = valueftype;
    notifyListeners();
  }

  togglerateapp(value) {
    if (value == null)
      _ratingappcount = 3;
    else
      _ratingappcount = value;
    notifyListeners();
  }

  Map _userviewdata = {};

  Map get userviewdata => _userviewdata;

  feedbacksubmit(context) async {
    var modelviewprofile = Provider.of<DashboardModelPage>(context, listen: false);

    _userviewdata = modelviewprofile.userdataMap;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('login_user_id');

    final modelprofileview = Provider.of<DashboardModelPage>(context, listen: false);

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "user_id": userid,
      "name": nameController.text.isEmpty ? modelprofileview.userdataMap['name'].toString() : nameController.text,
      "email": emailController.text.isEmpty ? modelprofileview.userdataMap['email'].toString() : emailController.text,
      "phone": mobileController.text.isEmpty ? modelprofileview.userdataMap['phone_no'].toString() : mobileController.text,
      "message": messageController.text,
      "user_rating": ratingappcount,
    });
    toggleshemmerShow();
    var response = await dio.post("${baseURL}feedback", data: formData);

    final responseData = json.decode(response.toString());

    try {
      if (responseData['status'] == true) {
        toggleshemmerdismis();
        Constants.showToast('Feedback shared successfully');
        await Future.delayed(const Duration(seconds: 1));

        Get.offAll(() => const BottomNavBarPage());

        nameController.clear();
        emailController.clear();
        messageController.clear();
        _ratingappcount = 3;
        notifyListeners();
      } else {
        toggleshemmerdismis();
        var messages = responseData["message"];
        apiErrorAlertdialog(context, messages);
      }
    } catch (e) {
      toggleshemmerdismis();
    }
  }
}
