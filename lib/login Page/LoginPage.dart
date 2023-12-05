import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/shimmereffect.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/login%20Page/loginModelPage.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:astrologyapp/signup/signuppage1.dart';
import 'package:astrologyapp/signup/signuppage2widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginModelPage>(builder: (context, model, _) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: WillPopScope(
          onWillPop: () {
            return onWillPop(context);
          },
          child: Scaffold(
            body: Stack(
              children: [
                bgImagecommon(context),
                MediaQuery(
                  data: mediaText(context),
                  child: Container(
                    child: SafeArea(
                      child: SingleChildScrollView(
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            sizedboxheight(40.0),
                            sizedboxheight(30.0),
                            Container(
                              padding: const EdgeInsets.all(padding20),
                              width: deviceWidth(context, 1.0),
                              height: deviceheight(context, 0.84),
                              decoration: decorationtoprounded(),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    headingContainer(context, 'Sign In', 'Welcome back!'),
                                    sizedboxheight(17.0),
                                    Container(
                                      padding: const EdgeInsets.only(right: 13.0),
                                      child: const Text(
                                        "Discover insights and seek advice from professional astrologers conveniently through our platform.",
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, letterSpacing: 0.5),
                                      ),
                                    ),
                                    sizedboxheight(32.0),
                                    model.isShimmer
                                        ? shimmersmall()
                                        : Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              loginEmail(model),
                                              sizedboxheight(20.0),
                                              loginPassword(model),
                                              forgotPassword(context),
                                              sizedboxheight(10.0),
                                            ],
                                          ),
                                    loginBtn(context, model),
                                    sizedboxheight(10.0),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: alreadyHaveAccount(context, "Don't have an account?", 'Sign Up', SignUpPage1()),
                                    ),
                                    sizedboxheight(10.0),
                                    continueAsGuest(context),
                                    sizedboxheight(50.0)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
