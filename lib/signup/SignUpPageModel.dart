import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:astrologyapp/common/apiErroralertdiloge.dart';
import 'package:astrologyapp/common/commonwidgets/toast.dart';
import 'package:astrologyapp/config.dart';
import 'package:astrologyapp/signup/verifysignupotp/OTPVerifySignupPage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/bottomnavbar/bottomnavbar.dart';
import '../common/styles/const.dart';
import 'SignUpPage2.dart';

class SignUpPageModel extends ChangeNotifier {
  static const String TAG = "SignUpPageModel";

  TextEditingController signupName = TextEditingController();
  TextEditingController signupMobile = TextEditingController();
  TextEditingController signupEmail = TextEditingController();
  TextEditingController signupPassword = TextEditingController();

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController signUpAddress = TextEditingController();

  bool _isShimmer = false;

  bool get isShimmer => _isShimmer;

  String? onlyTime;
  String? onlyDate;
  String? selectAddress;
  String token = "";
  String verificationCode = "";
  String verificationId = "";
  String deviceToken = "deviceToken";

  bool autoValidate = false;
  bool checkBoxValue = false;
  bool obscureText = true;
  bool emailValid = false;
  var areaName = '';

  TimeOfDay? newTime;
  DateTime? newDoB;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  toggleShimmerShow() {
    _isShimmer = true;
    notifyListeners();
  }

  toggleShimmerDismiss() {
    _isShimmer = false;
    notifyListeners();
  }

  Future<void> getFCMToken() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceToken = androidInfo.id;
      debugPrint("$TAG androidInfo id ======> $deviceToken");
    } else if (Platform.isIOS) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      deviceToken = iosDeviceInfo.identifierForVendor.toString();
      debugPrint("$TAG iosDeviceInfo identifierForVendor ======> $deviceToken");
    }
    await FirebaseMessaging.instance.getToken().then((value) {
      token = value!;
      notifyListeners();
    });
  }

  void validateEmail(String email) {
    emailValid = RegExp("[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})").hasMatch(email);
    notifyListeners();
  }

  void updateAddress(String address) {
    selectAddress = address;
    signUpAddress.text = address;
    notifyListeners();
  }

  void updatePasswordVisibility(bool value) {
    obscureText = value;
    notifyListeners();
  }

  void updateVerificationCode(String code) {
    verificationCode = code;
    notifyListeners();
  }

  void updateCheckBox(bool value) {
    checkBoxValue = value;
    notifyListeners();
  }

  selectDate(context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
      firstDate: DateTime(1900),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: colororangeLight, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              // onSurface: Colors.white, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: colororangeLight, //
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      newDoB = pickedDate;
      onlyDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      dateController.text = onlyDate.toString();
    }
    notifyListeners();
  }

  selectTime(context) async {
    TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: colororangeLight, // <-- SEE HERE
                onPrimary: Colors.white, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: colororangeLight, //
                ),
              ),
            ),
            child: child!,
          );
        });
    if (timeOfDay != null) {
      newTime = timeOfDay;
      final hours = timeOfDay.hour.toString().padLeft(2, '0');
      final minutes = timeOfDay.minute.toString().padLeft(2, '0');
      onlyTime = "$hours:$minutes";
      timeController.text = onlyTime.toString();
      notifyListeners();
    }
  }

  checkExistingUser(context) async {
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "email_id": signupEmail.text,
    });
    var response = await dio.post("${baseURL}check_exsists", data: formData);
    final responseData = json.decode(response.toString());
    debugPrint("$TAG responseData ========> $responseData");
    try {
      if (responseData["status"] == true) {
        var messages = responseData["message"];
        apiErrorAlertdialog(context, messages);
        notifyListeners();
      } else {
        toggleShimmerDismiss();
        Get.to(() => const SignUpPage2());
      }
    } catch (e) {
      toggleShimmerDismiss();
    }
  }

  Future<void> verifyOTPServer(BuildContext context, String phoneNo) async {
    toggleShimmerShow();
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "phone_no": phoneNo,
      "otp": verificationCode,
    });

    debugPrint('$TAG signup response =========> ${formData.fields}');

    var response = await dio.post("${baseURL}otp_verify", data: formData);
    debugPrint('$TAG signup response =========> $response');
    final responseData = json.decode(response.toString());
    debugPrint('$TAG signup responseData =========> $responseData');

    try {
      if (responseData['status']) {
        Utils.setStringSharedPreference('login_user_id', responseData["id"].toString());
        Utils.setStringSharedPreference('name', responseData["name"].toString());
        Utils.setStringSharedPreference('loginmobile', phoneNo);
        Utils.setStringSharedPreference('email', responseData['email'].toString());
        Utils.setStringSharedPreference('user_type', responseData['user_type'].toString());
        Utils.setStringSharedPreference('profile_image', responseData['profile_image'].toString());
        Utils.setStringSharedPreference('is_free', responseData['is_free'].toString());
        Utils.setBoolSharedPreference("isLoggedIn", true);
        toggleShimmerDismiss();
        await setUserOnlineFirebase();
        Constants.showToast(responseData['message']);
        Get.offUntil(MaterialPageRoute(
          builder: (context) {
            return BottomNavBarPage();
          },
        ), (route) => false);
      } else {
        toggleShimmerDismiss();
        var messages = responseData["message"];
        apiErrorAlertdialog(context, messages);
      }
    } catch (e) {
      toggleShimmerDismiss();
    }
  }



  Future<void> signupUser(BuildContext context) async {
    toggleShimmerShow();
    String phoneNo = "";
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "name": signupName.text.toString().trim(),
      "email_id": signupEmail.text.toString().trim(),
      "phone_no": signupMobile.text.toString().trim(),
      "password": signupPassword.text.toString().trim(),
      "dob": onlyDate,
      "birth_time": onlyTime,
      "birth_place": selectAddress,
      "device_id": deviceToken,
      "user_type": 1,
      'device_token': token,
      "address": selectAddress,
    });

    var response = await dio.post("${baseURL}registration", data: formData);
    debugPrint('$TAG signup response =========> $response');
    final responseData = json.decode(response.toString());

    try {
      if (responseData["status"]) {
        toggleShimmerDismiss();

        phoneNo = signupMobile.text.toString().trim();

        signupName.clear();
        signupEmail.clear();
        signupMobile.clear();
        signupPassword.clear();
        dateController.clear();
        timeController.clear();
        signUpAddress.clear();
        onlyTime = null;
        onlyDate = null;
        selectAddress = null;

        Get.offAll(() => OTPVerifySignupPage(phoneNo: phoneNo,));
      } else {
        toggleShimmerDismiss();
        var messages = responseData["message"];
        apiErrorAlertdialog(context, messages);
      }
    } catch (e) {
      toggleShimmerDismiss();
      notifyListeners();
    }
  }

  Future<void> resendOTP(BuildContext context, String phoneNo) async {
    Dio dio = Dio();
    var response = await dio.get("${baseURL}resend?phone_no=$phoneNo");
    debugPrint('$TAG signup response =========> $response');
    final responseData = json.decode(response.toString());
    try {
      var messages = responseData["message"];
      if(context.mounted) {
        apiErrorAlertdialog(context, messages);
      }
      notifyListeners();
    } catch (e) {
      notifyListeners();
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

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? userid = prefs.getString('login_user_id');
    // List<dynamic> userList = [];
    // String? userKey = "";
    // ref.orderByChild('id').equalTo(userid).once().then((DatabaseEvent value) {
    //   if (value.snapshot.children != null) {
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
    //     if (userKey != null && userKey != "" && userid != null && userid != "") {
    //       FirebaseDatabase.instance.ref(userKey).set({"id": userid, "is_busy": 0, "status": "Online"}).whenComplete(() {
    //         debugPrint("$TAG if user data updated");
    //       }).onError((error, StackTrace stackTrace) {
    //         debugPrint("$TAG if error on update =====> ${error.toString()}");
    //         debugPrint("$TAG if stackTrace on update =====> ${stackTrace.toString()}");
    //         FirebaseCrashlytics.instance.recordError(error, stackTrace);
    //       });
    //     } else {
    //       if (userid != null && userid != "") {
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
