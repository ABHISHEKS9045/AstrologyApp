import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/shimmereffect.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/login%20Page/LoginPage.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:astrologyapp/signup/signuppage2widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'SignUpPageModel.dart';

class SignUpPage2 extends StatefulWidget {
  const SignUpPage2({Key? key}) : super(key: key);

  @override
  State<SignUpPage2> createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpPageModel>(builder: (context, model, _) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Stack(
            children: [
              bgImagecommon(context),
              SafeArea(
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      sizedboxheight(30.0),
                      sizedboxheight(18.0),
                      Container(
                        padding: const EdgeInsets.all(padding20),
                        width: deviceWidth(context, 1.0),
                        height: deviceheight(context, 0.8),
                        decoration: decorationtoprounded(),
                        child: SingleChildScrollView(
                          child: model.isShimmer
                              ? shimmer()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    sizedboxheight(20.0),
                                    signupDoB(context, model),
                                    sizedboxheight(20.0),
                                    signupBirthTime(context, model),
                                    sizedboxheight(20.0),
                                    signUpAddress(model),
                                    sizedboxheight(20.0),
                                    checkboxTC(context, model),
                                    sizedboxheight(30.0),
                                    signupBtn(context, model),
                                    sizedboxheight(deviceheight(context, 0.1)),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: alreadyHaveAccount(context, "You already Have an Account?", 'Sign In', LoginPage()),
                                    ),
                                    sizedboxheight(10.0),
                                    dividerCustom(2.0, 6.0, 110.0, 110.0)
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
