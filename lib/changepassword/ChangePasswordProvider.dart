import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/Material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/apiErroralertdiloge.dart';
import '../forgetpass/password change page3/changepasspage.dart';

class ChangePasswordProvider extends ChangeNotifier {
  String TAG = "ChangePasswordProvider";
  bool isLoading = false;
  String? mobileNo = "";
  String? userId = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = "";
  String verificationCode = "";
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  showLoader() {
    isLoading = true;
    notifyListeners();
  }

  hideLoader() {
    isLoading = false;
    notifyListeners();
  }

  setOTP(String code) {
    verificationCode = code;
    notifyListeners();
  }

  Future<void> getMobileNo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    mobileNo = pref.getString("loginmobile");
    userId = pref.getString("login_user_id");
    debugPrint("$TAG mobileNo ==========> $mobileNo");
    debugPrint("$TAG userId ==========> $userId");
    notifyListeners();
    sendOTP();
  }

  Future<void> sendOTP() async {
    String phoneNumber = "+91$mobileNo";
    debugPrint("$TAG phoneNumber ==========> $phoneNumber");

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(milliseconds: 10000),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
    await _auth.signInWithCredential(phoneAuthCredential);
    debugPrint(" $TAG Phone number automatically verified and user signed in: ${_auth.currentUser!.uid}");
  }

  verificationFailed(FirebaseAuthException authException) {
    debugPrint('$TAG Phone number verification failed. Code ====> ${authException.code}. Message ======> ${authException.message}');
  }

  codeSent(String verificationId, [int? forceResendingToken]) async {
    debugPrint('$TAG Please check your phone for the verification code.');
    debugPrint('$TAG code sent force Resending Token =====> $forceResendingToken');
    debugPrint('$TAG code sent verificationId =====> $forceResendingToken');
    _verificationId = verificationId;
  }

  codeAutoRetrievalTimeout(String verificationId) {
    debugPrint("$TAG verificationId =======> $verificationId");
    _verificationId = verificationId;
  }

  void signInWithPhoneNumber(context) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: verificationCode,
      );
      await _auth.signInWithCredential(credential).then((UserCredential value) {

      }).onError((error, stackTrace) {
        FirebaseCrashlytics.instance.recordError(error, stackTrace);
      });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ChangePassPage(
              userid: userId,
            ),
          ),
              (route) => false);
    } catch (e) {
      debugPrint("$TAG sign In With Phone Number error =======> ${e.toString()}");
      apiErrorAlertdialog(context, 'Wrong OTP');
    }
  }
}
