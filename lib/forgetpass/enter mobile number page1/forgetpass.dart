import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/forgetpass/enter%20mobile%20number%20page1/forgetpassModelpage.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'forgetpasswidgetPage.dart';

class ForgetPassPage extends StatelessWidget {
  ForgetPassPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: deviceWidth(context, 1.0),
              height: deviceheight(context, 1.0),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/BackGround.png',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            bgImagecommon(context),
            Consumer<ForgetPassModelPage>(builder: (context, model, _) {
              return Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Container(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        sizedboxheight(60.0),
                        sizedboxheight(18.0),
                        Container(
                          padding: const EdgeInsets.all(padding20),
                          width: deviceWidth(context, 1.0),
                          decoration: decorationtoprounded(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              iconTextWidget(context, 'Enter Phone Number'),
                              sizedboxheight(17.0),
                              // Container(
                              //   padding: const EdgeInsets.only(right: 13.0),
                              //   child: const Text(
                              //     "Lorem Ipsum is simply industry.Lorem Ipsum has been the industry's Lorem Ipsum has been the industry's ",
                              //     maxLines: 2,
                              //     overflow: TextOverflow.ellipsis,
                              //     softWrap: false,
                              //   ),
                              // ),
                               sizedboxheight(32.0),
                              forgetpassphone(model),
                              sizedboxheight(32.0),
                              sandotpbtn(context, formKey, model),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // Widget forgetpassemail() {
  //   return AllInputDesign(
  //     key: Key("femail"),
  //     fillColor: colorWhite,
  //     hintText: 'Enter Email',
  //     labelText: 'Email',
  //     textInputAction: TextInputAction.next,
  //     prefixIcon: Image(image: AssetImage('assets/icons/email.png')),
  //     focusedBorderColor: colororangeLight,
  //     enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
  //     keyBoardType: TextInputType.emailAddress,
  //     validatorFieldValue: 'email',
  //     validator: validateEmailField,
  //   );
  // }

  Widget iconTextWidget(context, title) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 76,
            height: 76,
            child: const Image(
              image: AssetImage(
                'assets/icons/phone.png',
              ),
            ),
          ),
          sizedboxheight(10.0),
          Text(
            title,
            style: textstyleHeading2(context),
          )
        ],
      ),
    );
  }
}
