import 'package:astrologyapp/common/commonwidgets/button.dart';
import 'package:astrologyapp/common/formtextfield/myTextField.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/forgetpass/verify%20otp%20page2/otpverifywidgetPage.dart';
import 'package:flutter/material.dart';

import 'changepassmodelpage.dart';

Widget otptextpasswidget(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      iconTextWidget1(context, 'Reset Password'),
      sizedboxheight(17.0),
      Container(
        padding: const EdgeInsets.only(right: 13.0),
        child: const Column(
          children: [
            Text(
              "Eenter the OTP we just to your phone",
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

var confirmPass;

Widget newPasswordwidget(model) {
  return AllInputDesign(
    key: const Key("cpassword"),
    inputHeaderName: 'New Password',
    obsecureText: model.obscuretext1,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    fillColor: colorWhite,
    hintText: 'New Password',
    textInputAction: TextInputAction.next,
    controller: model.newPassword,
    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
    focusedBorderColor: colororangeLight,
    maxLines: 1,
    prefixIcon: const Image(
      image: AssetImage(
        'assets/icons/Lock.png',
      ),
    ),
    suffixIcon: GestureDetector(
      key: const Key('password_visibility'),
      child: const Icon(
        Icons.visibility,
        size: 20.0,
      ),
      onTap: () {
        model.toggle1();
      },
    ),
    validatorFieldValue: 'password',
    validator: (value) {
      confirmPass = value;
      if (value.isEmpty) {
        return "Please Enter New Password";
      } else if (value.length < 6) {
        return "Password must be atleast 6 characters long";
      } else {
        return null;
      }
    },
    keyBoardType: TextInputType.text,
  );
}

Widget confirmPasswordwidget(model) {
  return AllInputDesign(
    key: const Key("cnpassword"),
    inputHeaderName: 'Confirm Password',
    obsecureText: model.obscuretext2,
    fillColor: colorWhite,
    hintText: 'Confirm Password',
    floatingLabelBehavior: FloatingLabelBehavior.never,
    textInputAction: TextInputAction.done,
    controller: model.confirmPassword,
    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
    focusedBorderColor: colororangeLight,
    maxLines: 1,
    prefixIcon: const Image(
      image: AssetImage(
        'assets/icons/Lock.png',
      ),
    ),
    suffixIcon: GestureDetector(
      key: const Key('password_visibility'),
      child: const Icon(
        Icons.visibility,
        size: 20.0,
      ),
      onTap: () {
        model.toggle2();
      },
    ),
    validatorFieldValue: 'password',
    validator: (value) {
      if (value.isEmpty) {
        return "Please Re-Enter New Password";
      } else if (value.length < 6) {
        return "Password must be atleast 6 characters long";
      } else if (value != confirmPass) {
        return "Password must be same as above";
      } else {
        return null;
      }
    },
    keyBoardType: TextInputType.text,
  );
}

Widget newpasssavebtn(BuildContext context, ChangePassModelPage model, GlobalKey<FormState> _formkey, String userid) {
  return Button(
    btnWidth: deviceWidth(context, 1.0),
    btnHeight: 55,
    buttonName: 'SAVE',
    key: const Key('forget_submit'),
    borderRadius: BorderRadius.circular(15.0),
    btnColor: colororangeLight,
    onPressed: () {
      if (_formkey.currentState!.validate()) model.changepasswordsubmit(context, userid);
    },
  );
}
