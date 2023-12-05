import 'package:astrologyapp/common/commonwidgets/button.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../common/commonwidgets/TimerButton.dart';
import '../../signup/verifysignupotp/OTPVerifySignupPageWidgets.dart';
import '../enter mobile number page1/forgetpassModelpage.dart';

Widget iconTextWidget1(context, title) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        width: 76,
        height: 76,
        child: Image(
          image: AssetImage(
            'assets/icons/phone.png',
          ),
        ),
      ),
      sizedboxheight(10.0),
      Text(title, style: textstyleHeading2(context))
    ],
  );
}

Widget resandotprowforget(BuildContext context, ForgetPassModelPage model, String phoneNo) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TimerButton(
        buttonType: ButtonType.TextButton,
        label: "Send OTP Again",
        timeOutInSeconds: 60,
        onPressed: () {
          model.resendOTP(context, phoneNo);
        },
        disabledColor: Colors.white,
        color: Colors.white,
        disabledTextStyle: const TextStyle(fontSize: 16.0, color: Colors.grey),
        activeTextStyle: const TextStyle(fontSize: 16.0, color: Colors.blue),
      )
    ],
  );
}

Widget otptextwidget(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      iconTextWidget(context, 'Enter OTP'),
      sizedboxheight(17.0),
      Container(
        padding: const EdgeInsets.only(right: 13.0),
        child: const Column(
          children: [
            Text(
              "OTP is sent on your phone number",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
            Text(
              "then start reset your new password",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ],
        ),
      ),
    ],
  );
}

var otphitcode;

Widget otptypeWidget(BuildContext context, ForgetPassModelPage model) {
  return OtpTextField(
    keyboardType: TextInputType.number,
    numberOfFields: 6,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    borderColor: colororangeLight,
    focusedBorderColor: colororangeLight,
    borderRadius: BorderRadius.circular(15.0),
    fieldWidth: 45.0,
    showFieldAsBox: true,
    //set to true to show as box or false to show as dash
    onCodeChanged: (String code) {
      //handle validation or checks here
    },
    onSubmit: (String verificationCode) {
      // print("submit otp...." + verificationCode);
      model.verificationfun(verificationCode);
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //         title: Text("Verification Code"),
      //         content: Text('Code entered is $verificationCode'),
      //       );
      //     });
    }, // end onSubmit
  );
}

Widget otpverifybtn(BuildContext context, ForgetPassModelPage model, String phoneNo) {
  return Button(
    btnWidth: deviceWidth(context, 1.0),
    btnHeight: 55,
    buttonName: 'VERIFY OTP',
    key: const Key('forget_submit'),
    borderRadius: BorderRadius.circular(15.0),
    btnColor: colororangeLight,
    onPressed: () {
      // model.signInWithPhoneNumber(context);
      model.verifyOTP(context, phoneNo);
    },
  );
}
