import 'package:astrologyapp/common/commonwidgets/button.dart';
import 'package:astrologyapp/common/formtextfield/myTextField.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/signup/SignUpPageModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/commonwidgets/toast.dart';

Widget signupFullName(SignUpPageModel model) {
  return AllInputDesign(
    controller: model.signupName,
    labelText: 'Full Name',
    fillColor: colorWhite,
    hintText: 'Enter your Name',
    textInputAction: TextInputAction.next,
    prefixIcon: const Image(
      image: AssetImage(
        'assets/icons/people.png',
      ),
    ),
    focusedBorderColor: colororangeLight,
    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
    keyBoardType: TextInputType.name,
    validatorFieldValue: 'name',
    inputFormatterData: [
      FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
    ],
    textCapitalization: TextCapitalization.words,
  );
}

Widget signupMobile(SignUpPageModel model) {
  return AllInputDesign(
    controller: model.signupMobile,
    fillColor: colorWhite,
    maxLength: 10,
    counterText: '',
    labelText: 'Mobile Number',
    hintText: 'Enter your number',
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
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    ],
  );
}

Widget signPassword(SignUpPageModel model) {
  return AllInputDesign(
    controller: model.signupPassword,
    labelText: 'Password',
    fillColor: colorWhite,
    hintText: 'Password',
    obsecureText: model.obscureText,
    maxLines: 1,
    textInputAction: TextInputAction.done,
    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
    focusedBorderColor: colororangeLight,
    prefixIcon: const Image(
      image: AssetImage(
        'assets/icons/Lock.png',
      ),
    ),
    suffixIcon: IconButton(
      onPressed: () {
        model.updatePasswordVisibility(!model.obscureText);
      },
      icon: model.obscureText
          ? const Icon(
              Icons.visibility_off,
              size: 20.0,
              color: Colors.black45,
            )
          : const Icon(
              Icons.visibility,
              size: 20.0,
              color: Colors.blue,
            ),
    ),
    keyBoardType: TextInputType.text,
  );
}

Widget signupEmail(SignUpPageModel model) {
  return AllInputDesign(
    fillColor: colorWhite,
    hintText: 'Email',
    controller: model.signupEmail,
    textInputAction: TextInputAction.next,
    prefixIcon: const Image(
      image: AssetImage(
        'assets/icons/email.png',
      ),
    ),
    focusedBorderColor: colororangeLight,
    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
    keyBoardType: TextInputType.emailAddress,
  );
}

Widget signupContinueBtn(BuildContext context, SignUpPageModel model) {
  return Button(
    btnWidth: deviceWidth(context, 1.0),
    btnHeight: 45,
    buttonName: 'CONTINUE',
    borderRadius: BorderRadius.circular(15.0),
    btnColor: colororangeLight,
    onPressed: () async {
      model.validateEmail(model.signupEmail.text.toString().trim());
      if (model.signupName.text.toString().trim().isEmpty) {
        Constants.showToast('Please provide full name');
      } else if (model.signupMobile.text.toString().trim().isEmpty) {
        Constants.showToast('Please provide mobile number');
      } else if (model.signupMobile.text.toString().trim().length < 10) {
        Constants.showToast('Please provide 10 digit mobile number');
      } else if (model.signupEmail.text.toString().trim().isEmpty) {
        Constants.showToast('Please provide email address');
      } else if (!model.emailValid) {
        Constants.showToast('Please provide correct email address');
      } else if (model.signupPassword.text.toString().trim().isEmpty) {
        Constants.showToast('Please provide password');
      } else if (model.signupPassword.text.toString().trim().length < 6 || model.signupPassword.text.toString().trim().length > 12) {
        Constants.showToast('Password length is 6 to 12 characters');
      } else {
        model.checkExistingUser(context);
      }
    },
  );
}
