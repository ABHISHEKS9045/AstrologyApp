import 'package:astrologyapp/common/commonwidgets/button.dart';
import 'package:astrologyapp/common/commonwidgets/toast.dart';
import 'package:astrologyapp/common/formtextfield/myTextField.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/signup/SignUpPageModel.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../GoogleSearchScreen.dart';

Widget signUpAddress(SignUpPageModel model) {
  return InkWell(
    onTap: () {
      Get.to(() => const GoogleSearchScreen());
    },
    child: AllInputDesign(
      controller: model.signUpAddress,
      enabled: false,
      fillColor: colorWhite,
      inputHeaderName: 'Birth Place',
      hintText: 'Select Birth Place',
      prefixIcon: const Icon(Icons.home),
      focusedBorderColor: colororangeLight,
      enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
      keyBoardType: TextInputType.text,
    ),
  );
}

Widget checkboxTC(BuildContext context, SignUpPageModel model) {
  return Row(
    children: [
      Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.padded,
          value: model.checkBoxValue,
          onChanged: (bool? value) {
            model.updateCheckBox(value!);
          },
          activeColor: colororangeLight,
        ),
      ),
      sizedboxwidth(5.0),
      SizedBox(
        width: deviceWidth(context, 0.7),
        child: Text(
          'I agree to the terms and conditions',
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: textstyletitleHeading6(context)!.copyWith(fontSize: 16),
        ),
      ),
    ],
  );
}

Widget alreadyHaveAccount(BuildContext context, String leadingText, String trailingText, onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        leadingText,
        style: textstyletitleHeading6(
          context,
        ),
      ),
      TextButton(
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) => onTap));
        },
        child: Text(
          trailingText,
          style: textstyletitleHeading6(context)!.copyWith(
            color: colororangeLight,
            fontWeight: fontWeight600,
          ),
        ),
      ),
    ],
  );
}

Widget signupDoB(BuildContext context, SignUpPageModel model) {
  return InkWell(
    onTap: () {
      model.selectDate(context);
    },
    child: AllInputDesign(
      controller: model.dateController,
      enabled: false,
      inputHeaderName: 'Date Of Birth',
      fillColor: colorWhite,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintText: 'DD-MM-YYYY',
      prefixIcon: const Icon(
        Icons.calendar_today_outlined,
        color: Colors.grey,
      ),
      focusedBorderColor: colororangeLight,
      enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
    ),
  );
}

Widget signupBirthTime(BuildContext context, SignUpPageModel model) {
  return InkWell(
    onTap: () {
      model.selectTime(context);
    },
    child: AllInputDesign(
      controller: model.timeController,
      enabled: false,
      inputHeaderName: 'Birth Time',
      fillColor: colorWhite,
      textInputAction: TextInputAction.next,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintText: 'Enter your Birth Time',
      prefixIcon: const Icon(
        Icons.access_time_outlined,
        color: Colors.grey,
      ),
      focusedBorderColor: colororangeLight,
      enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
    ),
  );
}

Widget signupBtn(BuildContext context, SignUpPageModel model) {
  return Button(
    btnWidth: deviceWidth(context, 1.0),
    btnHeight: 45,
    buttonName: 'SIGN UP',
    key: const Key('signup_submit'),
    borderRadius: BorderRadius.circular(15.0),
    btnColor: colororangeLight,
    onPressed: () async {
      if (model.onlyDate == null || model.onlyDate == "") {
        Constants.showToast('Please select date of birth');
      } else if (model.onlyTime == null || model.onlyTime == "") {
        Constants.showToast('Please select birth time');
      } else if (model.selectAddress == null || model.selectAddress == "") {
        Constants.showToast('Please select birth place');
      } else if (model.checkBoxValue == false) {
        Constants.showToast('Please accept terms & conditions');
      } else {
        await model.signupUser(context);
      }
    },
  );
}
