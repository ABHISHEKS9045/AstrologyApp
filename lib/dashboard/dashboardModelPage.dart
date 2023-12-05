import 'dart:convert';

import 'package:astrologyapp/common/apiErroralertdiloge.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardModelPage extends ChangeNotifier {
  static const String TAG = "DashboardModelPage";

  bool _astro = false;

  bool get astro => _astro;

  var rashiDetails;

  var previousRashiDetails;

  var nextRashiDetails;

  List bannerDataList = [];
  List clientTestimonialList = [];
  List astroNewsList = [];


  String? usertype;

  bool astrologerOnline = false;
  bool astrologerCall = false;
  bool isSetAvailability = false;
  bool astrologerChat = false;

  int onlineStatus = 0;
  int callStatus = 0;
  int chatStatus = 0;
  int availableStatus = 0;

  String? availability;

  List<String> freeAvailability = [
    "1 min",
    "2 min",
    "3 min",
    "4 min",
    "5 min",
  ];

  void updateAvailability(String? value) {
    availability = value;
    updateStatus();
    notifyListeners();
  }

  Future<void> updateAstrologerStatus(bool status) async {
    astrologerOnline = status;
    notifyListeners();
    if(status) {
      setUserOnlineFirebase();
    } else {
      setUserOfflineFirebase();
    }
    updateStatus();
  }

  void updateAstrologerCallStatus(bool status) {
    astrologerCall = status;
    notifyListeners();
    updateStatus();
  }

  void isSetAvailabilityStatus(bool status) {
    isSetAvailability = status;
    notifyListeners();
    updateStatus();
  }

  void updateAstrologerChatStatus(bool status) {
    astrologerChat = status;
    notifyListeners();
    updateStatus();
  }

  userTypeFind() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usertype = prefs.getString('user_type');

    if (usertype == '2') {
      _astro = true;
      notifyListeners();
    }
    notifyListeners();
  }

  bool _isGeustLoggedIn = false;

  bool get isGeustLoggedIn => _isGeustLoggedIn;

  getgeustLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? geustuserid = prefs.getString('login_user_id');
    //String? usertype = prefs.getString('user_type');
    if (geustuserid == '0') {
      _isGeustLoggedIn = true;
      usertype = '1';
      notifyListeners();
    }
    notifyListeners();
  }

  geustloginfalse() {
    _isGeustLoggedIn = false;
    notifyListeners();
  }

  bool _isShimmer = false;

  bool get isShimmer => _isShimmer;

  int _activeindex = 0;

  int get activeindex => _activeindex;
  CarouselController buttonCarouselController = CarouselController();

  valueset(index) {
    _activeindex = index;
    notifyListeners();
  }

  toggleshemmerShow() {
    _isShimmer = true;
    notifyListeners();
  }

  toggleshemmerdismis() {
    _isShimmer = false;
    notifyListeners();
  }

  List _astrologerListdb = [];

  List get astrologerListdb => _astrologerListdb;

  Map _userdataMap = {};

  Map get userdataMap => _userdataMap;

  userdatareset() {
    _userdataMap = {};
    astrologerBankData = {};
    notifyListeners();
  }

  dashboardAstrologerList(context) async {
    toggleshemmerShow();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userType = prefs.getString('user_type');
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "user_type": userType,
      "limit": '25',
      "offset": '0',
      "user_status": "Online",
    });
    var response = await dio.post("${baseURL}astrologer_list", data: formData);
    final responseData = json.decode(response.toString());
    debugPrint("$TAG dashboard Astrologer List responseData ======> $responseData");
    try {
      if (responseData['status'] == true) {
        _astrologerListdb = responseData['list'];
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        var messages = responseData["message"];
        // apiErrorAlertdialog(context, messages);
      }
    } catch (e) {
      toggleshemmerdismis();
    }
  }

  dashboardBannerList(context) async {
    toggleshemmerShow();
    Dio dio = Dio();
    var response = await dio.post("${baseURL}get_banner_images");
    final responseData = json.decode(response.toString());
    debugPrint("$TAG dashboard Banner List responseData ======> $responseData");
    try {
      if (responseData['status'] == true) {
        bannerDataList = responseData['live_events'];
        debugPrint("$TAG bannerDataList ======> $bannerDataList");
        toggleshemmerdismis();
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

  dashboardClientTestimonialList(context) async {
    toggleshemmerShow();
    Dio dio = Dio();
    var response = await dio.get("${baseURL}client_testimonial");
    final responseData = json.decode(response.toString());
    debugPrint("$TAG dashboard Client Testimonial List responseData ======> $responseData");
    try {
      if (responseData['status'] == true) {
        clientTestimonialList = responseData['Client'];
        toggleshemmerdismis();
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

  dashboardAstroNewsList(context) async {
    toggleshemmerShow();
    Dio dio = Dio();
    var response = await dio.get("${baseURL}astro_news");
    final responseData = json.decode(response.toString());
    debugPrint("$TAG dashboard Astro News List responseData ======> $responseData");
    try {
      if (responseData['status'] == true) {
        astroNewsList = responseData['news'];
        toggleshemmerdismis();
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

  rashiDetailsAPI(context, String name) async {
    toggleshemmerShow();
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "timezone": 5.5,
    });
    dio.options.headers["authorization"] = "Basic $encodedKey";
    try {
      var response = await dio.post("https://json.astrologyapi.com/v1/sun_sign_prediction/daily/${name.toLowerCase()}", data: formData);
      debugPrint("$TAG rashi Details API responseData ======> $response");
      if (response.statusCode == 200) {
        rashiDetails = response.data['prediction'];
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
    }
  }

  previousRashiDetailsAPI(context, String name) async {
    toggleshemmerShow();
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "timezone": 5.5,
    });
    dio.options.headers["authorization"] = "Basic $encodedKey";
    try {
      var response = await dio.post("https://json.astrologyapi.com/v1/sun_sign_prediction/daily/previous/${name.toLowerCase()}", data: formData);
      debugPrint("$TAG previous rashi Details API responseData ======> $response");
      if (response.statusCode == 200) {
        previousRashiDetails = response.data['prediction'];
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
    }
  }

  nextRashiDetailsAPI(context, String name) async {
    toggleshemmerShow();
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "timezone": 5.5,
    });
    dio.options.headers["authorization"] = "Basic $encodedKey";
    try {
      var response = await dio.post("https://json.astrologyapi.com/v1/sun_sign_prediction/daily/next/${name.toLowerCase()}", data: formData);
      debugPrint("$TAG next rashi Details API responseData ======> $response");
      if (response.statusCode == 200) {
        nextRashiDetails = response.data['prediction'];
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
    }
  }

  dashboardProfileView(context, bool show) async {
    if (show) {
      toggleshemmerShow();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "user_id": userid!,
    });

    var response = await dio.post("${baseURL}view_users", data: formData);
    final responseData = json.decode(response.toString());
    debugPrint("$TAG get profile response =======> $responseData");
    try {
      if (responseData['status'] == true) {
        _userdataMap = responseData["data"];
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
    }
  }

  var astrologerBankData = {};

  getAstrologerBankData() async {
    // http://134.209.229.112/astrology_new/api/get_bank_details?astro_id=1
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');
    Dio dio = Dio();

    var response = await dio.get("${baseURL}get_bank_details?astro_id=$userid");
    final responseData = json.decode(response.toString());
    // debugPrint("$TAG get bank details response =======> $responseData");
    try {
      if (responseData['status']) {
        astrologerBankData = responseData["data"];
        notifyListeners();
      }
    } catch (e) {
      debugPrint("$TAG getAstrologerBankData error =======> ${e.toString()}");
    }
  }

  updateAstroChatStatus(int onlineStatus, int chatStatus, int callStatus, int freeAvailable, int availableTime) async {
    // http://134.209.229.112/astrology_new/api/change_status?astro_id=1
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "astro_id": userid!,
      "user_status": onlineStatus,
      "chat_active": chatStatus,
      "call_active": callStatus,
      "free_redeem": freeAvailable,
      "free_time": availableTime,
    });

    debugPrint("$TAG updateAstroChatStatus params =========> ${formData.fields}");

    var response = await dio.post("${baseURL}change_status", data: formData);
    final responseData = json.decode(response.toString());
    debugPrint("$TAG get bank details response =======> $responseData");
    try {
      if (responseData['status']) {
        Fluttertoast.showToast(msg: "your status is updated");
        notifyListeners();
      }
    } catch (e) {
      debugPrint("$TAG getAstrologerBankData error =======> ${e.toString()}");
    }
  }

  Future<void> updateStatus() async {
    if (astrologerOnline) {
      onlineStatus = 1;
    } else {
      onlineStatus = 0;
    }

    if (astrologerCall) {
      callStatus = 1;
    } else {
      callStatus = 0;
    }

    if (astrologerChat) {
      chatStatus = 1;
    } else {
      chatStatus = 0;
    }

    if (isSetAvailability) {
      availableStatus = 1;
    } else {
      availableStatus = 0;
    }

    int time = 0;

    switch (availability) {
      case "1 min":
        time = 1;
        break;
      case "2 min":
        time = 2;
        break;
      case "3 min":
        time = 3;
        break;
      case "4 min":
        time = 4;
        break;
      case "5 min":
        time = 5;
        break;
      default:
        time = 5;
        break;
    }

    notifyListeners();
    await updateAstroChatStatus(onlineStatus, chatStatus, callStatus, availableStatus, time);
  }

  void setData() {
    // debugPrint("$TAG call active =========> ${_userdataMap["call_active"]}");
    // debugPrint("$TAG chat active =========> ${_userdataMap["chat_active"]}");
    // debugPrint("$TAG online offline =========> ${_userdataMap["user_status"]}");

    if (_userdataMap["chat_active"] == "1") {
      debugPrint("$TAG chat active =========> ${_userdataMap["chat_active"]}");
      astrologerChat = true;
      chatStatus = 1;
    } else {
      astrologerChat = false;
      chatStatus = 0;
    }

    if (_userdataMap["call_active"] == "1") {
      debugPrint("$TAG call active =========> ${_userdataMap["call_active"]}");
      astrologerCall = true;
      callStatus = 1;
    } else {
      astrologerCall = false;
      callStatus = 0;
    }

    if (_userdataMap["user_status"] == "Online") {
      astrologerOnline = true;
      onlineStatus = 1;
    } else {
      astrologerOnline = false;
      onlineStatus = 0;
    }

    if (_userdataMap["free_redeem"] == 0) {
      isSetAvailability = false;
      availableStatus = 0;
    } else {
      isSetAvailability = true;
      availableStatus = 1;
    }

    switch (_userdataMap["free_time"]) {
      case 1:
        availability = "1 min";
        break;
      case 2:
        availability = "2 min";
        break;
      case 3:
        availability = "3 min";
        break;
      case 4:
        availability = "4 min";
        break;
      case 5:
        availability = "5 min";
        break;
      default:
        availability = "5 min";
        break;
    }

    debugPrint("$TAG call active =========> $astrologerCall");
    debugPrint("$TAG chat active =========> $astrologerChat");
    debugPrint("$TAG online offline =========> $astrologerOnline");
    debugPrint("$TAG free available =========> $isSetAvailability");

    notifyListeners();
  }

  Future<void> setUserOfflineFirebase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');

    String? userKey = "users_$userid";
    var postData = {"id": userid, "is_busy": 0, "status": "Offline"};
    FirebaseDatabase.instance.ref(userKey).set(postData);
  }

  Future<void> setUserOnlineFirebase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');

    String? userKey = "users_$userid";
    var postData = {"id": userid, "is_busy": 0, "status": "Online"};
    FirebaseDatabase.instance.ref(userKey).set(postData);
  }
}