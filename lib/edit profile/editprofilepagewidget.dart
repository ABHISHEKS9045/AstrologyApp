import 'dart:io';

import 'package:astrologyapp/common/commonwidgets/button.dart';
import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/formtextfield/myTextField.dart';
import 'package:astrologyapp/common/formtextfield/validations_field.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/dashboard/dashboardModelPage.dart';
import 'package:astrologyapp/edit%20profile/DocumentPage.dart';
import 'package:astrologyapp/edit%20profile/WorkHoursPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../GoogleSearchScreen.dart';
import 'editprofilemodel.dart';

String TAG = "EditProfilePageWidget";

void showPicker(BuildContext context, EditProfileModel model) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () {
                model.pickGalleryCameraImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                model.pickGalleryCameraImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget profilePic(BuildContext context, EditProfileModel model, DashboardModelPage dashBoardModel) {
  debugPrint("dashBoardModel =========> ${dashBoardModel.userdataMap.toString()}");
  return Align(
    alignment: Alignment.center,
    child: InkWell(
      onTap: () {
        showPicker(context, model);
      },
      child: SizedBox(
        width: 106,
        height: 115,
        child: Stack(
          children: [
            SizedBox(
              width: 90,
              height: 100,
              child: ClipRRect(
                borderRadius: borderRadiuscircular(15.0),
                child: model.image != null
                    ? Image.file(
                        model.image!,
                        fit: BoxFit.cover,
                      )
                    : dashBoardModel.userdataMap['profile_image'] != null
                        ? Image.network(
                            dashBoardModel.userdataMap['image_url'].toString(),
                            fit: BoxFit.cover,
                            errorBuilder: (context, exception, stackTrack) => const Center(
                              child: Text(
                                'Not found',
                              ),
                            ),
                          )
                        : const Image(
                            image: AssetImage(
                              'assets/images/user.png',
                            ),
                            fit: BoxFit.contain,
                          ),
              ),
            ),
            Positioned(
              top: 80,
              left: 68,
              child: InkWell(
                child: Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    color: colororangeLight,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: colororangeLight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 2,
                      bottom: 2,
                    ),
                    child: Center(
                      child: Image(
                        image: const AssetImage(
                          'assets/icons/edit.png',
                        ),
                        color: colorWhite,
                      ),
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
}

Widget dobEditWidget(BuildContext context, EditProfileModel model, DashboardModelPage dashBoardModel) {
  return InkWell(
    onTap: () {
      model.selectDate(context);
    },
    child: AllInputDesign(
      controller: model.dateController,
      key: const Key("dob"),
      enabled: false,
      inputHeaderName: 'Date Of Birth',
      labelText: model.onlyDate,
      fillColor: colorWhite,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      prefixIcon: const Icon(
        Icons.calendar_today_outlined,
        color: Colors.grey,
      ),
      focusedBorderColor: colororangeLight,
      enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
    ),
  );
}

Widget birthTimeEditWidget(BuildContext context, EditProfileModel model, DashboardModelPage dashBoardModel) {
  return InkWell(
    onTap: () {
      model.selectTime(context);
    },
    child: AllInputDesign(
      controller: model.timeController,
      key: const Key("dob"),
      enabled: false,
      inputHeaderName: 'Birth Time',
      labelText: model.onlyTime,
      fillColor: colorWhite,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      prefixIcon: const Icon(
        Icons.access_time_outlined,
        color: Colors.grey,
      ),
      focusedBorderColor: colororangeLight,
      enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
    ),
  );
}

Widget nameEditWidget(EditProfileModel model, DashboardModelPage dashBoardModel) {
  return AllInputDesign(
    controller: model.nameController,
    inputHeaderName: 'Name',
    fillColor: colorWhite,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    prefixIcon: const Image(
      image: AssetImage(
        'assets/icons/people.png',
      ),
    ),
    focusedBorderColor: colororangeLight,
    textInputAction: TextInputAction.next,
    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
    keyBoardType: TextInputType.name,
    inputFormatterData: [
      FilteringTextInputFormatter.allow(
        RegExp(r"[a-zA-Z]+|\s"),
      ),
    ],
    textCapitalization: TextCapitalization.words,
  );
}

Widget emailEditWidget(BuildContext context, EditProfileModel model, DashboardModelPage dashBoardModel) {
  return AllInputDesign(
    controller: model.emailController,
    inputHeaderName: "Email Address",
    fillColor: colorWhite,
    textInputAction: TextInputAction.next,
    floatingLabelBehavior: FloatingLabelBehavior.never,
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

Widget phoneEditWidget(EditProfileModel model, DashboardModelPage dashBoardModel) {
  return AllInputDesign(
    key: const Key("phone"),
    inputHeaderName: 'Phone',
    maxLength: 10,
    counterText: '',
    enabled: false,
    controller: model.phoneController,
    textInputAction: TextInputAction.next,
    fillColor: colorWhite,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    prefixIcon: const Image(
      image: AssetImage(
        'assets/icons/call.png',
      ),
    ),
    focusedBorderColor: colororangeLight,
    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
    keyBoardType: TextInputType.phone,
    validatorFieldValue: 'mobile',
    validator: validateMobile,
    inputFormatterData: [
      FilteringTextInputFormatter.allow(
        RegExp(r'[0-9]'),
      ),
    ],
  );
}

Widget addressWidget(EditProfileModel model, DashboardModelPage dashBoardModel) {
  return InkWell(
    onTap: () {
      Get.to(() => const GoogleSearchScreen());
    },
    child: AllInputDesign(
      key: const Key("address"),
      inputHeaderName: 'Address',
      enabled: false,
      fillColor: colorWhite,
      hintText: model.selectAddress,
      prefixIcon: const Icon(Icons.home),
      focusedBorderColor: colororangeLight,
      enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
      keyBoardType: TextInputType.text,
      // validatorFieldValue: 'name',
      // validator: validate,
    ),
  );
}

Widget genderWidget(BuildContext context, EditProfileModel model, DashboardModelPage dashBoardModel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Gender',
        style: textstyletitleHeading6(context),
      ),
      sizedboxheight(8.0),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: deviceWidth(context, 0.9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: colororangeLight.withOpacity(0.2),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            focusColor: Colors.white,
            value: model.selectGender,
            style: const TextStyle(color: Colors.white),
            iconEnabledColor: Colors.black,
            items: model.genderList.map<DropdownMenuItem<String>>((String valueGender) {
              return DropdownMenuItem<String>(
                value: valueGender,
                child: Text(
                  valueGender,
                  overflow: TextOverflow.ellipsis,
                  style: textstyletitleHeading6(context),
                ),
              );
            }).toList(),
            hint: dashBoardModel.userdataMap['gender'].toString() == 'null'
                ? const Text('Gender')
                : Text(
                    dashBoardModel.userdataMap['gender'].toString(),
                    style: textstyletitleHeading6(context),
                  ),
            onChanged: (String? value) {
              model.updateGender(value);
            },
          ),
        ),
      ),
    ],
  );
}

Widget perMinute(BuildContext context, EditProfileModel model, DashboardModelPage dashBoardModel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Per Minute Charge',
        style: textstyletitleHeading6(context),
      ),
      sizedboxheight(8.0),
      AllInputDesign(
        controller: model.perMinuteController,
        key: const Key("per_minute"),
        fillColor: colorWhite,
        maxLength: 4,
        prefixIcon: const Icon(
          Icons.watch_later_outlined,
          color: Colors.grey,
        ),
        textInputAction: TextInputAction.next,
        focusedBorderColor: colororangeLight,
        enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
        keyBoardType: TextInputType.number,
      ),
    ],
  );
}

Widget userExperience(BuildContext context, EditProfileModel model, DashboardModelPage dashBoardModel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Your Experience (in years only)',
        style: textstyletitleHeading6(context),
      ),
      sizedboxheight(8.0),
      AllInputDesign(
        controller: model.userExperienceController,
        key: const Key("user_experience"),
        fillColor: colorWhite,
        maxLength: 2,
        prefixIcon: const Icon(
          Icons.menu_book,
          color: Colors.grey,
        ),
        textInputAction: TextInputAction.next,
        focusedBorderColor: colororangeLight,
        enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
        validatorFieldValue: 'user_experience',
        keyBoardType: TextInputType.number,
      ),
    ],
  );
}

Widget languageWidget(BuildContext context, EditProfileModel model, DashboardModelPage dashBoardModel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Languages',
        style: textstyletitleHeading6(context),
      ),
      sizedboxheight(8.0),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: deviceWidth(context, 0.9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: colororangeLight.withOpacity(0.2),
          ),
        ),
        child: Autocomplete<String>(
          optionsBuilder: (textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable<String>.empty();
            }
            return model.languageList.where((String option) {
              return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (String selection) {
            debugPrint('$TAG You just selected =========> $selection');
            model.onSuggestionSelected(selection);
          },
          displayStringForOption: (String option) {
            return option;
          },
        ),
      ),
      sizedboxheight(8.0),
      model.selectedLanguageTags.isEmpty
          ? Container()
          : Container(
              alignment: Alignment.topLeft,
              child: Tags(
                alignment: WrapAlignment.center,
                itemCount: model.selectedLanguageTags.length,
                itemBuilder: (index) {
                  return ItemTags(
                    index: index,
                    title: model.selectedLanguageTags[index],
                    color: colororangeLight,
                    activeColor: colororangeLight,
                    onPressed: (Item item) {
                      print('pressed');
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    elevation: 0.0,
                    borderRadius: const BorderRadius.all(Radius.circular(7.0)),
                    textColor: Colors.white,
                    textActiveColor: Colors.white,
                    removeButton: ItemTagsRemoveButton(
                      color: Colors.black,
                      backgroundColor: Colors.transparent,
                      size: 14,
                      onRemoved: () {
                        model.onSuggestionRemoved(model.selectedLanguageTags[index]);
                        return true;
                      },
                    ),
                    textOverflow: TextOverflow.ellipsis,
                  );
                },
              ),
            ),
    ],
  );
}

Widget skillWidget(BuildContext context, EditProfileModel model, DashboardModelPage dashBoardModel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Skills',
        style: textstyletitleHeading6(context),
      ),
      sizedboxheight(8.0),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: deviceWidth(context, 0.9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: colororangeLight.withOpacity(0.2),
          ),
        ),
        child: Autocomplete<String>(
          optionsBuilder: (textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable<String>.empty();
            }

            debugPrint("$TAG model selectedSkillTags ====> ${model.skillList}");

            return model.skillList.where((String option) {
              debugPrint("$TAG textEditingValue text ======> ${textEditingValue.text.toLowerCase()}");
              debugPrint("$TAG option toLowerCase ======> ${option.toLowerCase()}");
              return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (String selection) {
            debugPrint('$TAG You just selected =========> $selection');
            model.onSkillSuggestionSelected(selection);
          },
          displayStringForOption: (String option) {
            return option;
          },
        ),
      ),
      sizedboxheight(8.0),
      model.selectedSkillTags.isEmpty
          ? Container()
          : Container(
              alignment: Alignment.topLeft,
              child: Tags(
                alignment: WrapAlignment.center,
                itemCount: model.selectedSkillTags.length,
                itemBuilder: (index) {
                  return ItemTags(
                    index: index,
                    title: model.selectedSkillTags[index],
                    color: colororangeLight,
                    activeColor: colororangeLight,
                    onPressed: (Item item) {
                      print('pressed');
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    elevation: 0.0,
                    borderRadius: const BorderRadius.all(Radius.circular(7.0)),
                    textColor: Colors.white,
                    textActiveColor: Colors.white,
                    removeButton: ItemTagsRemoveButton(
                      color: Colors.black,
                      backgroundColor: Colors.transparent,
                      size: 14,
                      onRemoved: () {
                        model.onSkillSuggestionRemoved(model.selectedSkillTags[index]);
                        return true;
                      },
                    ),
                    textOverflow: TextOverflow.ellipsis,
                  );
                },
              ),
            ),
    ],
  );
}

Widget aboutWidget(BuildContext context, EditProfileModel model, DashboardModelPage dashBoardModel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Tell Us About You',
        style: textstyletitleHeading6(context),
      ),
      sizedboxheight(8.0),
      AllInputDesign(
        controller: model.aboutUsController,
        key: const Key("about_us"),
        fillColor: colorWhite,
        maxLength: 4000,
        minLines: 6,
        maxLines: 6,
        textInputAction: TextInputAction.next,
        focusedBorderColor: colororangeLight,
        enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
        keyBoardType: TextInputType.text,
      ),
      sizedboxheight(8.0),
    ],
  );
}

Widget updateWorkingHoursWidget(BuildContext context, EditProfileModel model, DashboardModelPage dashBoardModel) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 1,
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const WorkHoursPage();
              },
            ));
          },
          child: const Text(
            'Set Availability',
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const DocumentPage();
              },
            ));
          },
          child: const Text(
            'Update Document',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    ],
  );
}

Button updateNowBtn(BuildContext context, EditProfileModel model, GlobalKey<FormState> formKey) {
  return Button(
    btnWidth: deviceWidth(context, 1.0),
    btnHeight: 55,
    buttonName: 'SAVE',
    key: const Key('savepay'),
    borderRadius: BorderRadius.circular(15.0),
    btnColor: colororangeLight,
    onPressed: () {
      model.editProfileUpdate(context);
    },
  );
}

// added for bank details update by nilesh on 05-07-2023

Widget panCardWidget(BuildContext context, EditProfileModel model, DashboardModelPage dashBoardModel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Pan Card Number',
        style: textstyletitleHeading6(context),
      ),
      sizedboxheight(8.0),
      AllInputDesign(
        controller: model.panController,
        textCapitalization: TextCapitalization.characters,
        key: const Key("pan_card"),
        fillColor: colorWhite,
        prefixIcon: const Icon(
          Icons.info_outline,
          color: Colors.grey,
        ),
        textInputAction: TextInputAction.next,
        focusedBorderColor: colororangeLight,
        enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
        keyBoardType: TextInputType.text,
      ),
    ],
  );
}

Widget aadharCardWidget(BuildContext context, EditProfileModel model, DashboardModelPage dashBoardModel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Aadhar Card Number',
        style: textstyletitleHeading6(context),
      ),
      sizedboxheight(8.0),
      AllInputDesign(
        controller: model.aadharController,
        key: const Key("aadhar_card"),
        fillColor: colorWhite,
        prefixIcon: const Icon(
          Icons.info_outline,
          color: Colors.grey,
        ),
        textInputAction: TextInputAction.next,
        focusedBorderColor: colororangeLight,
        enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
        keyBoardType: TextInputType.number,
        maxLength: 12,
        maxLines: 1,
      ),
    ],
  );
}

Widget accountHolderNameWidget(BuildContext context, EditProfileModel model, DashboardModelPage dashBoardModel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Account Holder Name',
        style: textstyletitleHeading6(context),
      ),
      sizedboxheight(8.0),
      AllInputDesign(
        controller: model.holderNameController,
        key: const Key("account_holder"),
        fillColor: colorWhite,
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.grey,
        ),
        textInputAction: TextInputAction.next,
        focusedBorderColor: colororangeLight,
        enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
        keyBoardType: TextInputType.name,
      ),
    ],
  );
}

Widget accountNumberWidget(BuildContext context, EditProfileModel model, DashboardModelPage dashBoardModel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Account Number',
        style: textstyletitleHeading6(context),
      ),
      sizedboxheight(8.0),
      AllInputDesign(
        controller: model.accountNumberController,
        key: const Key("account_number"),
        fillColor: colorWhite,
        prefixIcon: const Icon(
          Icons.info_outline,
          color: Colors.grey,
        ),
        textInputAction: TextInputAction.next,
        focusedBorderColor: colororangeLight,
        enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
        keyBoardType: TextInputType.text,
      ),
    ],
  );
}

Widget ifscCodeWidget(BuildContext context, EditProfileModel model, DashboardModelPage dashBoardModel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'IFSC Code',
        style: textstyletitleHeading6(context),
      ),
      sizedboxheight(8.0),
      AllInputDesign(
        controller: model.ifscController,
        key: const Key("ifsc_code"),
        fillColor: colorWhite,
        prefixIcon: const Icon(
          Icons.info_outline,
          color: Colors.grey,
        ),
        textInputAction: TextInputAction.next,
        focusedBorderColor: colororangeLight,
        enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
        keyBoardType: TextInputType.text,
      ),
    ],
  );
}

Widget bankNameWidget(BuildContext context, EditProfileModel model, DashboardModelPage dashBoardModel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Bank Name',
        style: textstyletitleHeading6(context),
      ),
      sizedboxheight(8.0),
      AllInputDesign(
        controller: model.bankNameController,
        key: const Key("bank_name"),
        fillColor: colorWhite,
        prefixIcon: const Icon(
          Icons.info_outline,
          color: Colors.grey,
        ),
        textInputAction: TextInputAction.done,
        focusedBorderColor: colororangeLight,
        enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
        keyBoardType: TextInputType.text,
      ),
    ],
  );
}

Widget panCard(BuildContext context, EditProfileModel model, DashboardModelPage dashBoardModel) {
  return InkWell(
    onTap: () {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return Container(
                height: 150,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CupertinoButton(
                      color: colororangeLight,
                      child: const Text("Open Gallery"),
                      onPressed: () {
                        model.selectImageForPanCard("Gallery");
                      },
                    ),
                    sizedboxheight(5.0),
                    CupertinoButton(
                      color: colororangeLight,
                      child: const Text("Open Camera"),
                      onPressed: () {
                        model.selectImageForPanCard("camera");
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    },
    child: Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Pan",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          setImageIntoView(model.panCardImage, dashBoardModel.astrologerBankData["pan_doc"]),
          // model.panCardImage == null
          //     ? Container(
          //         margin: const EdgeInsets.only(top: 10),
          //         height: 80,
          //         width: 80,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10),
          //           border: Border.all(
          //             color: Colors.grey.withOpacity(0.5),
          //           ),
          //         ),
          //         child: Icon(
          //           Icons.image,
          //           color: Colors.grey.withOpacity(0.8),
          //         ),
          //       )
          //     : Container(
          //         margin: const EdgeInsets.only(top: 10),
          //         height: 80,
          //         width: 80,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10),
          //           border: Border.all(
          //             color: Colors.grey.withOpacity(0.5),
          //           ),
          //           image: DecorationImage(
          //             image: FileImage(File(model.panCardImage!.path)),
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //       ),
        ],
      ),
    ),
  );
}

Widget aadharCard(BuildContext context, EditProfileModel model, DashboardModelPage dashBoardModel) {
  return InkWell(
    onTap: () {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return Container(
                height: 150,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CupertinoButton(
                      color: colororangeLight,
                      child: const Text("Open Gallery"),
                      onPressed: () {
                        model.selectImageForAadharCard("Gallery");
                      },
                    ),
                    sizedboxheight(5.0),
                    CupertinoButton(
                      color: colororangeLight,
                      child: const Text("Open Camera"),
                      onPressed: () {
                        model.selectImageForAadharCard("camera");
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    },
    child: Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Aadhar",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          setImageIntoView(model.aadharImage, dashBoardModel.astrologerBankData["aadhar_doc"]),
          // model.aadharImage == null
          //     ? Container(
          //         margin: const EdgeInsets.only(top: 10),
          //         height: 80,
          //         width: 80,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10),
          //           border: Border.all(
          //             color: Colors.grey.withOpacity(0.5),
          //           ),
          //         ),
          //         child: Icon(
          //           Icons.image,
          //           color: Colors.grey.withOpacity(0.8),
          //         ),
          //       )
          //     : Container(
          //         margin: const EdgeInsets.only(top: 10),
          //         height: 80,
          //         width: 80,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10),
          //           border: Border.all(
          //             color: Colors.grey.withOpacity(0.5),
          //           ),
          //           image: DecorationImage(
          //             image: FileImage(
          //               File(model.aadharImage!.path),
          //             ),
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //       ),
        ],
      ),
    ),
  );
}

Widget bankImage(BuildContext context, EditProfileModel model, DashboardModelPage dashBoardModel) {
  return InkWell(
    onTap: () {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return Container(
                height: 150,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CupertinoButton(
                      color: colororangeLight,
                      child: const Text("Open Gallery"),
                      onPressed: () {
                        model.selectImageForBankCard("Gallery");
                      },
                    ),
                    sizedboxheight(5.0),
                    CupertinoButton(
                      color: colororangeLight,
                      child: const Text("Open Camera"),
                      onPressed: () {
                        model.selectImageForBankCard("camera");
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    },
    child: Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: const Text(
              "Passbook",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          setImageIntoView(model.bankImage, dashBoardModel.astrologerBankData["passbook_img"]),
          // model.bankImage == null
          //     ? Container(
          //         margin: const EdgeInsets.only(top: 10),
          //         height: 80,
          //         width: 80,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10),
          //           border: Border.all(
          //             color: Colors.grey.withOpacity(0.5),
          //           ),
          //         ),
          //         child: Icon(Icons.image, color: Colors.grey.withOpacity(0.8)),
          //       )
          //     : Container(
          //         margin: const EdgeInsets.only(top: 10),
          //         height: 80,
          //         width: 80,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10),
          //           border: Border.all(
          //             color: Colors.grey.withOpacity(0.5),
          //           ),
          //           image: DecorationImage(
          //             image: FileImage(File(model.bankImage!.path)),
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //       ),
        ],
      ),
    ),
  );
}

Button updateDocument(BuildContext context, EditProfileModel model, DashboardModelPage modelPage) {
  return Button(
    btnWidth: deviceWidth(context, 1.0),
    btnHeight: 55,
    buttonName: 'Submit',
    key: const Key('doc'),
    borderRadius: BorderRadius.circular(15.0),
    btnColor: colororangeLight,
    onPressed: () {
      if (model.panController.text.toString().trim().isEmpty) {
        Fluttertoast.showToast(msg: "Please provide Pan Card number");
      } else if (model.aadharController.text.toString().trim().isEmpty) {
        Fluttertoast.showToast(msg: "Please provide Aadhar Card number");
      } else if (model.holderNameController.text.toString().trim().isEmpty) {
        Fluttertoast.showToast(msg: "Please provide account holder name");
      } else if (model.accountNumberController.text.toString().trim().isEmpty) {
        Fluttertoast.showToast(msg: "Please provide account number");
      } else if (model.ifscController.text.toString().trim().isEmpty) {
        Fluttertoast.showToast(msg: "Please provide ifsc code");
      } else if (model.bankNameController.text.toString().trim().isEmpty) {
        Fluttertoast.showToast(msg: "Please provide bank name");
      } else if (model.panCardImage == null) {
        Fluttertoast.showToast(msg: "Please provide Pan Card image");
      } else if (model.bankImage == null) {
        Fluttertoast.showToast(msg: "Please provide Passbook image");
      } else if (model.aadharImage == null) {
        Fluttertoast.showToast(msg: "Please provide Aadhar Card image");
      } else {
        model.updateBankDetails(context, modelPage);
      }
    },
  );
}

Widget setImageIntoView(XFile? file, String? image) {
  debugPrint("$TAG setImageIntoView file ========> ${file?.path}");
  debugPrint("$TAG setImageIntoView image ========> $image");
  debugPrint("$TAG setImageIntoView image ========> ${image?.length}");

  if (file != null) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
        ),
        image: DecorationImage(
          image: FileImage(File(file.path)),
          fit: BoxFit.cover,
        ),
      ),

    );
  } else if (image != null && image != "" && image.isNotEmpty) {
    debugPrint("$TAG image is not null");
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
        ),
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  } else {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
      child: Icon(
        Icons.image,
        color: Colors.grey.withOpacity(0.8),
      ),
    );
  }
}
