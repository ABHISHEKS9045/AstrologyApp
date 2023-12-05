import 'package:astrologyapp/common/commonwidgets/button.dart';
import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/formtextfield/myTextField.dart';
import 'package:astrologyapp/common/formtextfield/validations_field.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/dashboard/dashboardModelPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'feedbackpagemodel.dart';

Widget feedbackname(FeedbackPageModel model, DashboardModelPage dashboardModel) {
  return AllInputDesign(
    key: const Key("fullname"),
    controller: model.nameController,
    // labelText: 'Full Name',
    fillColor: colorWhite,
    enabled: false,
    hintText: dashboardModel.userdataMap['name'].toString(),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    textInputAction: TextInputAction.next,
    prefixIcon: const Image(image: AssetImage('assets/icons/people.png')),
    focusedBorderColor: colororangeLight,
    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
    keyBoardType: TextInputType.emailAddress,
    validatorFieldValue: 'name',
    // validator: validateName,
  );
}

Widget feedbackpmobile(FeedbackPageModel model, DashboardModelPage dashboardModel) {
  return AllInputDesign(
    key: const Key("fmobile"),
    controller: model.mobileController,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    fillColor: colorWhite,
    maxLength: 10,
    counterText: '',
    enabled: false,
    // labelText: 'Mobile Number',
    hintText: dashboardModel.userdataMap['phone_no'].toString(),
    //  autofillHints: [AutofillHints.telephoneNumberCountryCode],
    textInputAction: TextInputAction.next,
    prefixIcon: const Image(image: AssetImage('assets/icons/call.png')),
    focusedBorderColor: colororangeLight,
    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
    keyBoardType: TextInputType.number,
    validatorFieldValue: 'mobile',
    // validator: validateMobile,
  );
}

Widget feedbackemail(FeedbackPageModel model, DashboardModelPage dashboardModel) {
  return AllInputDesign(
    key: const Key("email"),
    controller: model.emailController,
    fillColor: colorWhite,
    enabled: false,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    hintText: dashboardModel.userdataMap['email'].toString(),
    textInputAction: TextInputAction.next,
    prefixIcon: const Image(image: AssetImage('assets/icons/email.png')),
    focusedBorderColor: colororangeLight,
    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
    keyBoardType: TextInputType.emailAddress,
    validatorFieldValue: 'email',
    // validator: validateEmailField,
  );
}

Widget messagebox(FeedbackPageModel model) {
  return Container(
    height: 110,
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), border: borderCustom()),
    child: TextFormField(
      controller: model.messageController,
      validator: validaterequired,
      maxLines: 3,
      style: TextStyle(
          color: colorblack, fontWeight: FontWeight.w500, fontSize: 18),
      decoration: InputDecoration(
        counterText: '',
        border: InputBorder.none,
        fillColor: colorWhite,
        filled: true,
        hintText: 'Your Message',
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintStyle: TextStyle(
          color: colorblack,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}

Widget feedbacktypewidget(BuildContext context, FeedbackPageModel model) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    width: deviceWidth(context, 1.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: colororangeLight.withOpacity(0.2))),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        focusColor: Colors.white,
        value: model.feedbacktype,
        iconSize: 30,
        //elevation: 5,
        style: const TextStyle(color: Colors.white),
        iconEnabledColor: Colors.black,
        items:
            model.feedbacktypeList.map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: textstyletitleHeading6(context),
            ),
          );
        }).toList(),
        hint: Text(
          "Type",
          style: textstyletitleHeading6(context),
        ),
        onChanged: (value1) {
          model.togglefeedbacktype(value1);
        },
      ),
    ),
  );
}

Container ratingwidget(BuildContext context, FeedbackPageModel model) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: borderCustom(),
      borderRadius: borderRadiuscircular(8.0),
    ),
    child: Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rate the App',
          style: textstyletitleHeading6(context),
        ),
        sizedboxheight(10.0),
        RatingBar.builder(
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            model.togglerateapp(rating);
          },
        ),
      ],
    ),
  );
}

Button sendfeedbackbtn(context, formKey, FeedbackPageModel model) {
  return Button(
      btnWidth: deviceWidth(context, 1.0),
      btnHeight: 55,
      buttonName: 'SEND FEEDBACK',
      key: const Key('pay'),
      borderRadius: BorderRadius.circular(15.0),
      btnColor: colororangeLight,
      onPressed: () {
        model.feedbacksubmit(context);
      });
}
