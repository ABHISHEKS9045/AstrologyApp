import 'package:astrologyapp/common/commonwidgets/button.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../common/commonwidgets/TimerButton.dart';
import '../SignUpPageModel.dart';

const String TAG = "OTPScreenWidgets";

Widget iconTextWidget(context, title) {
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
      Text(
        title,
        style: textstyleHeading2(context),
      ),
      sizedboxheight(10.0),
      Text(
        'OTP is sent on your phone number',
        style: textstylesubtitle1(context),
      )
    ],
  );
}

Widget reSandOTP(BuildContext context, SignUpPageModel model, String phoneNo) {
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
        disabledTextStyle: const TextStyle(
          fontSize: 16.0,
          color: Colors.grey,
        ),
        activeTextStyle: const TextStyle(
          fontSize: 16.0,
          color: Colors.blue,
        ),
      ),
    ],
  );
}

Widget otpEnterWidget(BuildContext context, SignUpPageModel model) {
  return OtpTextField(
    keyboardType: TextInputType.number,
    numberOfFields: 6,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    borderColor: colororangeLight,
    focusedBorderColor: colororangeLight,
    borderRadius: BorderRadius.circular(15.0),
    fieldWidth: 45.0,
    showFieldAsBox: true,
    onCodeChanged: (String code) {},
    onSubmit: (String verificationCode) {
      model.updateVerificationCode(verificationCode);
    },
  );
}

Widget otpVerifySignupBtn(BuildContext context, SignUpPageModel model, String phoneNo) {
  return Button(
    btnWidth: deviceWidth(context, 1.0),
    btnHeight: 55,
    buttonName: 'VERIFY OTP',
    key: const Key('forget_submit'),
    borderRadius: BorderRadius.circular(15.0),
    btnColor: colororangeLight,
    onPressed: () async {

      debugPrint("$TAG phone number =========> $phoneNo");

      if(phoneNo != null && phoneNo != "") {
        model.verifyOTPServer(context, phoneNo);
      } else {
        model.verifyOTPServer(context, model.signupMobile.text.toString().trim());
      }
    },
  );
}
