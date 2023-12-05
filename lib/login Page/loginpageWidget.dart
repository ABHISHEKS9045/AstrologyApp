
import 'package:astrologyapp/common/bottomnavbar/bottomnavbar.dart';
import 'package:astrologyapp/common/commonwidgets/button.dart';
import 'package:astrologyapp/common/formtextfield/myTextField.dart';
import 'package:astrologyapp/common/formtextfield/validations_field.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/forgetpass/enter%20mobile%20number%20page1/forgetpass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/commonwidgets/toast.dart';
import 'loginModelPage.dart';

Widget bgImagecommon(context) {
  return Container(
    width: deviceWidth(context, 1.0),
    height: 260,
    child: Image.asset(
      'assets/images/bg.jpg',
      fit: BoxFit.cover,
    ),
  );
}

Widget headingContainer(BuildContext context, String heading, String title) {
  return SizedBox(
    height: 70,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: textstyleHeading1(context),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget loginEmail(LoginModelPage model) {
  return AllInputDesign(
    fillColor: colorWhite,
    maxLength: 10,
    counterText: '',
    hintText: 'Phone',
    controller: model.loginEmail,
    autofillHints: const [AutofillHints.telephoneNumberCountryCode],
    textInputAction: TextInputAction.next,
    prefixIcon: const Image(
      image: AssetImage(
        'assets/icons/call.png',
      ),
    ),
    focusedBorderColor: colororangeLight,
    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
    keyBoardType: TextInputType.phone,
    inputFormatterData: [
      FilteringTextInputFormatter.allow(
        RegExp(r'[0-9]'),
      ),
    ],
  );
}

Widget loginPassword(LoginModelPage model) {
  return AllInputDesign(
    obsecureText: model.obscuretext,
    fillColor: colorWhite,
    hintText: 'Password',
    textInputAction: TextInputAction.done,
    autofillHints: const [AutofillHints.password],
    controller: model.loginPassword,
    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
    focusedBorderColor: colororangeLight,
    maxLines: 1,
    prefixIcon: const Image(
      image: AssetImage(
        'assets/icons/Lock.png',
      ),
    ),
    suffixIcon: IconButton(
      onPressed: () {
        model.toggle();
      },
      icon: model.isTapVissible
          ? const Icon(
              Icons.visibility,
              size: 20.0,
              color: Colors.blue,
            )
          : const Icon(
              Icons.visibility_off,
              size: 20.0,
              color: Colors.black45,
            ),
    ),
    keyBoardType: TextInputType.text,
  );
}

Widget forgotPassword(BuildContext context) {
  return Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ForgetPassPage(),
          ),
        );
      },
      child: Text(
        'Forgot Password?',
        style: textstylesubtitle1(context)?.copyWith(
          color: Colors.blue
        ),
      ),
    ),
  );
}

Widget loginBtn(BuildContext context, LoginModelPage model) {
  return Button(
    btnWidth: deviceWidth(context, 1.0),
    btnHeight: 45,
    buttonName: 'LOG IN',
    borderRadius: BorderRadius.circular(15.0),
    btnColor: colororangeLight,
    onPressed: () async {
      if(model.loginEmail.text.toString().isEmpty) {
        Constants.showToast('Please provide mobile number');
      } else if (model.loginEmail.text.toString().trim().length < 10) {
        Constants.showToast('Please provide 10 digit mobile number');
      } else if (model.loginPassword.text.toString().trim().isEmpty) {
        Constants.showToast('Please provide password');
      } else if (model.loginPassword.text.toString().trim().length < 6 || model.loginPassword.text.toString().trim().length > 12) {
        Constants.showToast('Password length is 6 to 12 characters');
      } else {
        await model.signInSubmit(context);
      }
    },
  );
}

Widget continueAsGuest(BuildContext context) {
  return Center(
    child: TextButton(
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('login_user_id', "0");
        prefs.setString('user_type', "1");

        if(context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavBarPage(),
            ),
          );
        }
      },
      child: Text(
        'CONTINUE AS GUEST',
        style: textstyletitleHeading6(context)?.copyWith(
          color: colororangeLight,
          fontWeight: FontWeight.w600,
          fontSize: 18
        ),
      ),
    ),
  );
}
