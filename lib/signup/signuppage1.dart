import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:astrologyapp/signup/signuppage1Widget.dart';
import 'package:astrologyapp/signup/SignUpPageModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage1 extends StatefulWidget {
  SignUpPage1({Key? key}) : super(key: key);

  @override
  State<SignUpPage1> createState() => _SignUpPage1State();
}

class _SignUpPage1State extends State<SignUpPage1> {

  @override
  void initState() {
    var model = Provider.of<SignUpPageModel>(context, listen: false);
    model.getFCMToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    sizedboxheight(78.0),
                    Container(
                      padding: const EdgeInsets.all(padding20),
                      width: deviceWidth(context, 1.0),
                      decoration: decorationtoprounded(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headingContainer(context, 'Sign Up', 'Create your account'),
                          sizedboxheight(50.0),
                          signupFullName(model),
                          sizedboxheight(20.0),
                          signupMobile(model),
                          sizedboxheight(20.0),
                          signupEmail(model),
                          sizedboxheight(20.0),
                          signPassword(model),
                          sizedboxheight(40.0),
                          signupContinueBtn(context, model),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}