import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:astrologyapp/signup/SignUpPageModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'OTPVerifySignupPageWidgets.dart';

class OTPVerifySignupPage extends StatelessWidget {

  final String phoneNo;

  const OTPVerifySignupPage({Key? key, required this.phoneNo}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    debugPrint("$TAG phoneNo =========> $phoneNo");

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            bgImagecommon(context),
            Consumer<SignUpPageModel>(builder: (context, model, _) {
              return SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    sizedboxheight(
                      deviceheight(context, 0.15),
                    ),
                    Container(
                      padding: const EdgeInsets.all(padding20),
                      width: deviceWidth(context, 1.0),
                      decoration: decorationtoprounded(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizedboxheight(20.0),
                          iconTextWidget(context, "Enter Otp"),
                          sizedboxheight(62.0),
                          otpEnterWidget(context, model),
                          sizedboxheight(30.0),
                          otpVerifySignupBtn(context, model, phoneNo),
                          sizedboxheight(30.0),
                          reSandOTP(context, model, phoneNo),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
