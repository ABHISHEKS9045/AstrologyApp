import 'dart:convert';
import 'dart:io';

import 'package:astrologyapp/common/apiErroralertdiloge.dart';
import 'package:astrologyapp/common/bottomnavbar/bottomnavbar.dart';
import 'package:astrologyapp/common/commonwidgets/toast.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/styles/const.dart';
import '../config.dart';

class LoginModelPage extends ChangeNotifier {

  String TAG = "LoginModelPage";

  String? _tokan;

  String? get tokan => _tokan;

  bool _autovalidate = false;

  bool get autovalidate => _autovalidate;

  bool _isTapVissible = false;

  bool get isTapVissible => _isTapVissible;

  bool _obscuretext = true;

  bool get obscuretext => _obscuretext;

  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  toggle() {
    _obscuretext = !_obscuretext;
    _isTapVissible = !_isTapVissible;
    notifyListeners();
  }

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

  String phoneNumber = "";

  signInSubmit(context) async {
    String? deviceToken;
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceToken = androidInfo.id;
    }
    await FirebaseMessaging.instance.getToken().then((value) {
      _tokan = value;
      debugPrint("$TAG sign In submit get Token _tokan =====> $_tokan");
      notifyListeners();
    });

    debugPrint("$TAG sign In submit get Token tokan =====> $tokan");

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "phone_no": loginEmail.text,
      "password": loginPassword.text,
      'device_token': tokan,
      "device_id": deviceToken,
    });
    debugPrint('$TAG login params =========> ${formData.fields}');
    toggleshemmerShow();
    var response = await dio.post("${baseURL}login_user", data: formData);
    final responseData = json.decode(response.toString());
    debugPrint('$TAG login response =========> $response');
    try {
      phoneNumber = loginEmail.text.toString().trim();
      notifyListeners();
      if (responseData['status']) {
        debugPrint('$TAG login response =========> $responseData');

        Utils.setStringSharedPreference('login_user_id', responseData["id"].toString());
        Utils.setStringSharedPreference('name', responseData["name"].toString());
        Utils.setStringSharedPreference('loginmobile', loginEmail.text.toString().trim());
        Utils.setStringSharedPreference('user_type', responseData['user_type'].toString());
        Utils.setStringSharedPreference('profile_image', responseData['profile_image'].toString());
        Utils.setStringSharedPreference('is_free', responseData['is_free'].toString());
        Utils.setBoolSharedPreference("isLoggedIn", true);

        await setUserOnlineFirebase();
        Constants.showToast('Login Successful');
        toggleshemmerdismis();
        loginEmail.clear();
        loginPassword.clear();
        notifyListeners();

        Get.offUntil(MaterialPageRoute(builder: (context) {
          return const BottomNavBarPage();
        },), (route) => false);

      } else {
        toggleshemmerdismis();
        notifyListeners();
        if(responseData['status_code'] == 204) {
          debugPrint("$TAG response code =========> 204");
          apiRedirectToVerifyOTP(context, responseData['message'], phoneNumber);
          loginEmail.clear();
          loginPassword.clear();
          notifyListeners();
        } else {
          debugPrint("$TAG response ==========> ");
          apiErrorAlertdialog(context, responseData['message']);
        }
      }
    } catch (e) {
      toggleshemmerdismis();
      debugPrint('$TAG login response error =========> ${e.toString()}');
    }
  }

  // update firebase login status of user added by nilesh on 17-05-2023
  // start
  Future<void> setUserOnlineFirebase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');

    String? userKey = "users_$userid";
    var postData = {"id": userid, "is_busy": 0, "status": "Online"};
    FirebaseDatabase.instance.ref(userKey).set(postData);
    // List<dynamic> userList = [];
    // String? userKey = "";
    // ref.orderByChild('id').equalTo(userid).once().then((DatabaseEvent value) {
    //   if(value.snapshot.children != null) {
    //     debugPrint("$TAG event value snapshot =======> ${value.snapshot.children}");
    //     for (DataSnapshot element in value.snapshot.children) {
    //       if (element.key != null) {
    //         debugPrint("$TAG element key =======> ${element.key}");
    //         debugPrint("$TAG element value =======> ${element.value}");
    //         userKey = element.key;
    //         userList.add(element.value);
    //       }
    //     }
    //
    //     if(userKey != null && userKey != "" && userid != null && userid != "") {
    //       FirebaseDatabase.instance.ref(userKey).set({
    //         "id": userid,
    //         "is_busy": 0,
    //         "status": "Online"
    //       }).whenComplete(() {
    //         debugPrint("$TAG if user data updated");
    //       }).onError((error, StackTrace stackTrace) {
    //         debugPrint("$TAG if error on update =====> ${error.toString()}");
    //         debugPrint("$TAG if stackTrace on update =====> ${stackTrace.toString()}");
    //         FirebaseCrashlytics.instance.recordError(error, stackTrace);
    //       });
    //     } else {
    //       if(userid != null && userid != "") {
    //         final newPostKey = ref.push().key;
    //         final postData = {"id": userid, "is_busy": 0, "status": "Online"};
    //         final Map<String, Map> updates = {};
    //         updates['$newPostKey'] = postData;
    //
    //         ref.update(updates).whenComplete(() {
    //           debugPrint("$TAG else user data updated");
    //         }).onError((error, stackTrace) {
    //           debugPrint("$TAG else error on update =====> ${error.toString()}");
    //           debugPrint("$TAG else stackTrace on update =====> ${stackTrace.toString()}");
    //           FirebaseCrashlytics.instance.recordError(error, stackTrace);
    //         });
    //       }
    //     }
    //   }
    // });
  }
  // end
}
