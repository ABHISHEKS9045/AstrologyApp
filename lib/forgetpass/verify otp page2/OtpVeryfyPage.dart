import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/forgetpass/enter%20mobile%20number%20page1/forgetpassModelpage.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'otpverifywidgetPage.dart';

class OtpVeryfyPage extends StatelessWidget {

  String phoneNo;

  OtpVeryfyPage(this.phoneNo, {Key? key})
      : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
         onTap:()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            bgImagecommon(context),
            Consumer<ForgetPassModelPage>(builder: (context, model, _) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                     keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      sizedboxheight(deviceheight(context, 0.12),),
                      sizedboxheight(deviceheight(context, 0.03),),
                      Container(
                          padding: const EdgeInsets.all(padding20),
                          width: deviceWidth(context, 1.0),
                          decoration: decorationtoprounded(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              otptextwidget(context),
                              sizedboxheight(32.0),
                              otptypeWidget(context, model),
                              sizedboxheight(30.0),
                              otpverifybtn(context, model, phoneNo),
                              sizedboxheight(20.0),
                              resandotprowforget(context, model, phoneNo),
                            ],
                          ),
                      ),
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
