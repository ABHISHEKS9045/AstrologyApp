import 'dart:convert';
import 'dart:io';

import 'package:astrologyapp/common/apiErroralertdiloge.dart';
import 'package:astrologyapp/forgetpass/password%20change%20page3/changepasspage.dart';
import 'package:astrologyapp/forgetpass/verify%20otp%20page2/OtpVeryfyPage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../common/styles/const.dart';

class ForgetPassModelPage extends ChangeNotifier {

  String TAG = "ForgetPassModelPage";

  TextEditingController forgetpassMobile = TextEditingController();
  String _verificationCode = '';

  String get verificationCode => _verificationCode;

  verificationfun(verification) {
    _verificationCode = verification;
    notifyListeners();
  }

  forgetpasssubmit(String phoneNo) async {

  }

  Future<void> verifyOTP(BuildContext context, String phoneNo) async {
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "phone_no": phoneNo,
      "otp": verificationCode,
    });

    var response = await dio.post("${baseURL}otp_verify", data: formData);
    debugPrint('$TAG signup response =========> $response');
    final responseData = json.decode(response.toString());
    debugPrint('$TAG signup responseData =========> $responseData');

    try {
      if(responseData['status']) {
        if(context.mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ChangePassPage(
                      userid: responseData["id"].toString(),
                    ),
              ),
                  (route) => false);
        }
      } else {
        var messages = responseData["message"];
        apiErrorAlertdialog(context, messages);
      }
    } catch (e) {
      //toggleShimmerDismiss();
    }
  }



  Future<void> resendOTP(BuildContext context, String phoneNo) async {
    Dio dio = Dio();
    var response = await dio.get("${baseURL}resend?phone_no=$phoneNo");
    debugPrint('$TAG signup response =========> $response');
    final responseData = json.decode(response.toString());
    try {
      var messages = responseData["message"];
      forgetpassMobile.clear();

      if(context.mounted) {
        apiErrorAlertdialog(context, messages);
      }
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }


  // final FirebaseAuth _auth = FirebaseAuth.instance;
  //
  // var _verificationId;
  //
  // final SmsAutoFill _autoFill = SmsAutoFill();
  //
  // Future<void> submitPhoneNumber() async {
  //   String phoneNumber = "+91${forgetpassMobile.text}";
  //   // print(phoneNumber);
  //
  //   PhoneVerificationCompleted verificationCompleted = (PhoneAuthCredential phoneAuthCredential) async {
  //     await _auth.signInWithCredential(phoneAuthCredential);
  //     // print("Phone number automatically verified and user signed in: ${_auth.currentUser!.uid}");
  //   };
  //
  //   PhoneVerificationFailed verificationFailed = (FirebaseAuthException authException) {
  //     // print('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
  //   };
  //
  //   PhoneCodeSent codeSent = (String verificationId, [int? forceResendingToken]) async {
  //     // print('Please check your phone for the verification code.');
  //     _verificationId = verificationId;
  //   };
  //   Get.to(() => OtpVeryfyPage());
  //   //  Navigator.push(context, MaterialPageRoute(builder: (context) =>OtpVeryfyPage()));
  //   // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OtpVeryfyPage()), (route) => false);
  //
  //   PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
  //     // print("verification code: " + verificationId);
  //     _verificationId = verificationId;
  //   };
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     timeout: const Duration(milliseconds: 10000),
  //     verificationCompleted: verificationCompleted,
  //     verificationFailed: verificationFailed,
  //     codeSent: codeSent,
  //     codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
  //   ); // All the callbacks are above
  // }

  // void signInWithPhoneNumber(context) async {
  //   try {
  //     final AuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: _verificationId,
  //       smsCode: verificationCode,
  //     );
  //     final User? user = (await _auth.signInWithCredential(credential)).user;
  //     var deviceToken = "deviceToken";
  //     if (Platform.isAndroid) {
  //       DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //       deviceToken = androidInfo.id;
  //     }
  //
  //     Dio dio = Dio();
  //     FormData formData = FormData.fromMap({
  //       "mobile": forgetpassMobile.text,
  //       // "device_token": deviceToken,
  //     });
  //
  //     var response = await dio.post("${baseURL}forgot", data: formData);
  //     debugPrint("$TAG response =======> $response");
  //     var userid = response.data["user_id"];
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => ChangePassPage(
  //             userid: userid,
  //           ),
  //         ),
  //             (route) => false);
  //   } catch (e) {
  //     debugPrint("$TAG error sign In With Phone Number ========> ${e.toString()}");
  //     apiErrorAlertdialog(context, 'Wrong OTP');
  //   }
  // }
}
