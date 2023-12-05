import 'package:astrologyapp/common/commonwidgets/button.dart';
import 'package:astrologyapp/common/formtextfield/myTextField.dart';
import 'package:astrologyapp/common/formtextfield/validations_field.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../verify otp page2/OtpVeryfyPage.dart';
import 'forgetpassModelpage.dart';

Widget forgetpassphone(ForgetPassModelPage model) {
  return AllInputDesign(
    key: Key("mobile"),
    controller: model.forgetpassMobile,
    fillColor: colorWhite,
    maxLength: 10,
    counterText: '',
    labelText: 'Mobile Number',
    hintText: 'Enter your number',
    textInputAction: TextInputAction.next,
    prefixIcon: Image(image: AssetImage('assets/icons/call.png')),
    focusedBorderColor: colororangeLight,
    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
    keyBoardType: TextInputType.number,
    validatorFieldValue: 'mobile',
    validator: validateMobile,
    inputFormatterData: [ FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
  );
}

Widget sandotpbtn(BuildContext context, formKey, ForgetPassModelPage model) {
  return Button(
    btnWidth: deviceWidth(context, 1.0),
    btnHeight: 45,
    buttonName: 'SEND OTP',
    key: Key('forget_submit'),
    borderRadius: BorderRadius.circular(15.0),
    btnColor: colororangeLight,
    onPressed: () async {
      debugPrint("model forgetpassMobile ===========> ${model.forgetpassMobile.text.toString().trim()}");
      if (formKey.currentState.validate()) {
        await model.resendOTP(context, model.forgetpassMobile.text.toString().trim());
        Get.to(() => OtpVeryfyPage(model.forgetpassMobile.text.toString().trim()));
      }
    },
  );
}
