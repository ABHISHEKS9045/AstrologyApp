import 'dart:convert';
import 'dart:io';

import 'package:astrologyapp/common/apiErroralertdiloge.dart';
import 'package:astrologyapp/common/bottomnavbar/bottomnavbar.dart';
import 'package:astrologyapp/common/commonwidgets/toast.dart';
import 'package:astrologyapp/dashboard/dashboardModelPage.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/styles/const.dart';
import 'WorkingHoursModel.dart';

class EditProfileModel extends ChangeNotifier {
  String TAG = "EditProfileModel";

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController perMinuteController = TextEditingController();
  TextEditingController userExperienceController = TextEditingController();
  TextEditingController aboutUsController = TextEditingController();

  TextEditingController panController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController holderNameController = TextEditingController();

  bool _autovalidate = false;

  bool get autovalidate => _autovalidate;

  toggleautovalidate() {
    _autovalidate = !_autovalidate;
    notifyListeners();
  }

  bool _isShimmer = false;

  bool get isShimmer => _isShimmer;

  toggleshemmerShow() {
    _isShimmer = true;
    notifyListeners();
  }

  toggleshemmerdismis() {
    _isShimmer = false;
    notifyListeners();
  }

  List<String> genderList = ['Select Gender', 'male', 'female'];

  List<String> languageList = [];
  List<String> selectedLanguageTags = [];

  List<String> skillList = [];
  List<String> selectedSkillTags = [];

  String? selectAddress;

  String? selectGender;

  String? onlyTime;
  String? onlyDate;

  TimeOfDay? newTime;
  DateTime? newDoB;
  File? image;
  var imageName;

  List<String> weekDay = [];
  List<String> weekStartTime = [];
  List<String> weekEndTime = [];

  List<WorkingHoursModel> workingHours = [];

  selectDate(context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
      firstDate: DateTime(1900),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: colororangeLight, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              // onSurface: Colors.white, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: colororangeLight, //
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      newDoB = pickedDate;
      onlyDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      dateController.text = onlyDate.toString();
    }
    notifyListeners();
  }

  selectTime(context) async {
    TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: colororangeLight, // <-- SEE HERE
                onPrimary: Colors.white, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: colororangeLight, //
                ),
              ),
            ),
            child: child!,
          );
        });
    if (timeOfDay != null) {
      newTime = timeOfDay;
      final hours = timeOfDay.hour.toString().padLeft(2, '0');
      final minutes = timeOfDay.minute.toString().padLeft(2, '0');
      onlyTime = "$hours:$minutes";
      timeController.text = onlyTime.toString();
      notifyListeners();
    }
  }

  Future pickGalleryCameraImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imagePermanent = await saveImagePermanently(image.path);

      this.image = imagePermanent;
      notifyListeners();

      imageName = image.path.split('/').last;
      // print('final image name $imageName');
      // print('final image full path ${image.path}');
    } on PlatformException catch (e) {
      // print('Failed to pick image: $e');
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    File image = File(imagePath);
    final size = image.lengthSync() / 1024;
    File compressedFile = await FlutterNativeImage.compressImage(image.path, quality: 100, percentage: 10);
    notifyListeners();
    final sizecompresss = compressedFile.lengthSync() / 1024;
    return File(imagePath).copy(compressedFile.path);
  }

  editProfileUpdate(BuildContext context) async {
    toggleshemmerShow();
    final modelprofileview = Provider.of<DashboardModelPage>(context, listen: false);
    String? deviceToken = '';
    await FirebaseMessaging.instance.getToken().then((String? value) {
      print("$TAG instance getToken ======> $value");
      deviceToken = value;
    });
    var response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('login_user_id');
    var userType = prefs.getString('user_type');
    debugPrint("$TAG deviceToken ======> $deviceToken");

    if (selectGender == "Select Gender") {
      selectGender = "";
    }

    Dio dio = Dio();
    if (userType == "1") {
      FormData formData = FormData.fromMap({
        "user_id": userid,
        "device_id": deviceToken,
        "name": nameController.text.isEmpty ? modelprofileview.userdataMap['name'].toString() : nameController.text,
        "phone_no": phoneController.text.isEmpty ? modelprofileview.userdataMap['phone_no'].toString() : phoneController.text,
        "dob": onlyDate,
        'birth_time': onlyTime,
        "address": selectAddress ?? modelprofileview.userdataMap['address'].toString(),
        "profile_image": image == null ? null : await MultipartFile.fromFile(image!.path, filename: imageName),
        "gender": selectGender ?? modelprofileview.userdataMap['gender'].toString(),
      });
      response = await dio.post("${baseURL}edit_user", data: formData);
    } else {
      FormData formData = FormData.fromMap({
        "id": userid,
        "name": nameController.text.isEmpty ? modelprofileview.userdataMap['name'].toString() : nameController.text,
        "email": emailController.text.isEmpty ? modelprofileview.userdataMap['email'].toString() : emailController.text,
        "dob": onlyDate,
        'birth_time': onlyTime,
        "address": selectAddress ?? modelprofileview.userdataMap['birth_place'].toString(),
        "birth_place": selectAddress ?? modelprofileview.userdataMap['birth_place'].toString(),
        "profile_image": image == null ? null : await MultipartFile.fromFile(image!.path, filename: imageName),
        "gender": selectGender ?? modelprofileview.userdataMap['gender'].toString(),
        "user_language": selectedLanguageTags.join(","),
        "user_expertise": selectedSkillTags.join(","),
        "user_experience": userExperienceController.text.isEmpty ? modelprofileview.userdataMap['user_experience'].toString() : userExperienceController.text,
        "per_minute": perMinuteController.text.isEmpty ? modelprofileview.userdataMap['per_minute'].toString() : perMinuteController.text,
        "user_aboutus": aboutUsController.text.isEmpty ? modelprofileview.userdataMap['user_aboutus'].toString() : aboutUsController.text,
        "week_day": weekDay.join(","),
        "week_start_time": weekStartTime.join(","),
        "week_end_time": weekEndTime.join(","),
        // new keys need to add in update astrologer profile comment by nilesh on 20-05-2023
        // "image_url": "multiple file type",
      });

      debugPrint("$TAG formData ======> ${formData.fields}");

      response = await dio.post("${baseURL}astro_profile_update", data: formData);
    }

    debugPrint("$TAG response ======> $response");
    final responseData = json.decode(response.toString());
    debugPrint("$TAG responseData ======> $responseData");
    try {
      if (responseData['status'] == true) {
        Constants.showToast('Profile Updated Successfully');
        notifyListeners();
        toggleshemmerdismis();
        await Future.delayed(const Duration(seconds: 1));
        Get.off(() => BottomNavBarPage());
      } else {
        toggleshemmerdismis();
        var messages = responseData["message"];
        apiErrorAlertdialog(context, messages);
      }
    } catch (e) {
      toggleshemmerdismis();
    }
  }

  getLanguages(DashboardModelPage dashboardModel) async {
    toggleshemmerShow();
    try {
      var response = await Dio().get('${baseURL}static_data?key=language');
      var responseData = json.decode(response.toString());
      debugPrint('$TAG Language List Data ======> $responseData');

      if (responseData['status']) {
        languageList.clear();
        for (int i = 0; i < responseData['data'].length; i++) {
          languageList.add(responseData['data'][i]["value"].toString());
        }
        setSelectedLanguage(dashboardModel);

        toggleshemmerdismis();
      } else {
        toggleshemmerdismis();
        debugPrint('Language Error${responseData['status'].toString()} ');
      }
    } catch (e) {
      toggleshemmerdismis();
      debugPrint('Language Exception : ${e.toString()} ');
    }
  }

  getSkill(DashboardModelPage dashboardModel) async {
    toggleshemmerShow();
    try {
      var response = await Dio().get('${baseURL}static_data?key=skill');
      var responseData = json.decode(response.toString());
      debugPrint('$TAG Skill List Data =========> $responseData');

      if (responseData['status']) {
        skillList.clear();
        for (int i = 0; i < responseData['data'].length; i++) {
          skillList.add(responseData['data'][i]["value"].toString());
        }

        setSelectedSkills(dashboardModel);

        toggleshemmerdismis();
      } else {
        toggleshemmerdismis();
        debugPrint('Skill Error${responseData['status'].toString()} ');
      }
    } catch (e) {
      toggleshemmerdismis();
      debugPrint('Skill (e) : ${e.toString()} ');
    }
  }

  void setSelectedLanguage(DashboardModelPage dashboardModel) {
    debugPrint("$TAG dashBoardModel selected language ========> ${dashboardModel.userdataMap["user_language"]}");
    List<String> list = dashboardModel.userdataMap["user_language"].toString().split(",");
    selectedLanguageTags.clear();
    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        selectedLanguageTags.add(list[i]);
      }
      notifyListeners();
    }
  }

  void setSelectedSkills(DashboardModelPage dashboardModel) {
    debugPrint("$TAG dashBoardModel selected skill ========> ${dashboardModel.userdataMap["user_expertise"]}");
    List<String> list = dashboardModel.userdataMap["user_expertise"].toString().split(",");
    selectedSkillTags.clear();
    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        selectedSkillTags.add(list[i]);
      }
      notifyListeners();
    }
  }

  void onSuggestionSelected(String value) {
    final String exists = languageList.firstWhere((text) => text.toLowerCase() == value.toLowerCase(), orElse: () {
      return "";
    });
    if (exists != "") {
      final String isAlreadyInSelectedList = selectedLanguageTags.firstWhere((text) => text.toLowerCase() == value.toLowerCase(), orElse: () {
        return "";
      });

      if (isAlreadyInSelectedList == "") {
        selectedLanguageTags.add(value);
        languageList.remove(value);
        notifyListeners();
      }
    }
  }

  void onSuggestionRemoved(String value) {
    final String exists = selectedLanguageTags.firstWhere((text) => text.toLowerCase() == value.toLowerCase(), orElse: () {
      return "";
    });
    if (exists != "") {
      selectedLanguageTags.remove(value);
      languageList.add(value);
      notifyListeners();
    }
  }

  void onSkillSuggestionSelected(String value) {
    final String exists = skillList.firstWhere((text) => text.toLowerCase() == value.toLowerCase(), orElse: () {
      return "";
    });
    if (exists != "") {
      final String isAlreadyInSelectedList = selectedSkillTags.firstWhere((text) => text.toLowerCase() == value.toLowerCase(), orElse: () {
        return "";
      });

      if (isAlreadyInSelectedList == "") {
        selectedSkillTags.add(value);
        skillList.remove(value);
        notifyListeners();
      }
    }
  }

  void onSkillSuggestionRemoved(String value) {
    final String exists = selectedSkillTags.firstWhere((text) => text.toLowerCase() == value.toLowerCase(), orElse: () {
      return "";
    });
    if (exists != "") {
      selectedSkillTags.remove(value);
      skillList.add(value);
      notifyListeners();
    }
  }

  void updateAddress(String address) {
    selectAddress = address;
    notifyListeners();
  }

  void updateGender(String? gender) {
    selectGender = gender;
    notifyListeners();
  }

  void setAstrologerAvailability(var astroAvailability) {
    List<String> days = [];
    List<String> startTime = [];
    List<String> endTime = [];
    workingHours.clear();

    for (int i = 0; i < astroAvailability["days"].length; i++) {
      days.add(astroAvailability["days"][i].toString());
    }

    for (int i = 0; i < astroAvailability["start_time"].length; i++) {
      startTime.add(astroAvailability["start_time"][i].toString());
    }

    for (int i = 0; i < astroAvailability["end_time"].length; i++) {
      endTime.add(astroAvailability["end_time"][i].toString());
    }

    if (days.isNotEmpty) {
      for (int i = 0; i < days.length; i++) {
        Timeslot timeslot = Timeslot(start: startTime[i], end: endTime[i]);
        workingHours.add(WorkingHoursModel(day: days[i], timeslot: [timeslot]));
      }
    }
  }

  void setUserData(DashboardModelPage model) {
    setAstrologerAvailability(model.userdataMap['astro_availability']);

    if (model.userdataMap['name'] != null && model.userdataMap['name'] != "" && model.userdataMap['name'].toString() != "null") {
      nameController.text = model.userdataMap['name'].toString();
    } else {
      nameController.text = "";
    }

    if (model.userdataMap['phone_no'] != null && model.userdataMap['phone_no'] != "" && model.userdataMap['phone_no'].toString() != "null") {
      phoneController.text = model.userdataMap['phone_no'].toString();
    } else {
      phoneController.text = "";
    }

    if (model.userdataMap['email'] != null && model.userdataMap['email'] != "" && model.userdataMap['email'].toString() != "null") {
      emailController.text = model.userdataMap['email'].toString();
    } else {
      emailController.text = "";
    }

    if (model.userdataMap['per_minute'] != null && model.userdataMap['per_minute'] != "" && model.userdataMap['per_minute'].toString() != "null") {
      perMinuteController.text = model.userdataMap['per_minute'].toString();
    } else {
      perMinuteController.text = "0";
    }

    if (model.userdataMap['gender'] != null && model.userdataMap['gender'] != "" && model.userdataMap['gender'].toString() != "null") {
      selectGender = model.userdataMap['gender'].toString();
    } else {
      selectGender = "Select Gender";
    }

    if (model.userdataMap['user_experience'] != null && model.userdataMap['user_experience'] != "" && model.userdataMap['user_experience'].toString() != "null") {
      userExperienceController.text = model.userdataMap['user_experience'].toString();
    } else {
      userExperienceController.text = "";
    }

    if (model.userdataMap['birth_place'] != null && model.userdataMap['birth_place'] != "" && model.userdataMap['birth_place'].toString() != "null") {
      selectAddress = model.userdataMap['birth_place'].toString();
    } else {
      selectAddress = "";
    }

    debugPrint("$TAG user date of birth ====> ${model.userdataMap['dob']}");
    debugPrint("$TAG user time of birth ====> ${model.userdataMap['birth_time']}");

    if (model.userdataMap['dob'] != null) {
      onlyDate = model.userdataMap['dob'].toString();
      dateController.text = onlyDate.toString();
    } else {
      dateController.text = "Select Date Of Birth";
    }

    if (model.userdataMap['birth_time'] != null && model.userdataMap['birth_time'] != "null") {
      onlyTime = model.userdataMap['birth_time'].toString();
      timeController.text = onlyTime.toString();
    } else {
      timeController.text = "Select Birth Time";
    }

    if (model.userdataMap['user_aboutus'] != null && model.userdataMap['user_aboutus'] != "" && model.userdataMap['user_aboutus'] != "null") {
      aboutUsController.text = model.userdataMap['user_aboutus'].toString();
    } else {
      aboutUsController.text = "";
    }

    notifyListeners();
  }

  ImagePicker imagePicker = ImagePicker();
  XFile? panCardImage, aadharImage, bankImage;
  File? panCardImageFinal, aadharImageFinal, bankImageFinal;
  String? panCardImageName, aadharImageName, bankImageName;

  void selectImageForPanCard(String imageSource) async {
    if (imageSource == 'Gallery') {
      panCardImage = await imagePicker.pickImage(source: ImageSource.gallery);
    } else {
      panCardImage = await imagePicker.pickImage(source: ImageSource.camera);
    }
    final imagePermanent = await saveImagePermanently(panCardImage!.path);

    panCardImageFinal = imagePermanent;
    notifyListeners();

    panCardImageName = panCardImageFinal!.path.split('/').last;
    notifyListeners();
    Get.back();
  }

  void selectImageForAadharCard(String imageSource) async {
    if (imageSource == 'Gallery') {
      aadharImage = await imagePicker.pickImage(source: ImageSource.gallery);
    } else {
      aadharImage = await imagePicker.pickImage(source: ImageSource.camera);
    }

    final imagePermanent = await saveImagePermanently(aadharImage!.path);

    aadharImageFinal = imagePermanent;
    notifyListeners();

    aadharImageName = aadharImageFinal!.path.split('/').last;
    notifyListeners();
    Get.back();
  }

  void selectImageForBankCard(String imageSource) async {
    if (imageSource == 'Gallery') {
      bankImage = await imagePicker.pickImage(source: ImageSource.gallery);
    } else {
      bankImage = await imagePicker.pickImage(source: ImageSource.camera);
    }

    final imagePermanent = await saveImagePermanently(bankImage!.path);

    bankImageFinal = imagePermanent;
    notifyListeners();

    bankImageName = bankImageFinal!.path.split('/').last;
    notifyListeners();
    Get.back();
  }

  void setAstrologerBankData(DashboardModelPage model) {
    debugPrint("$TAG astrologer Bank Data =======> ${model.astrologerBankData}");

    if (model.astrologerBankData['pan_card_no'] != null && model.astrologerBankData['pan_card_no'] != "" && model.astrologerBankData['pan_card_no'] != "null") {
      panController.text = model.astrologerBankData['pan_card_no'].toString();
    } else {
      panController.text = "";
    }

    if (model.astrologerBankData['aadhar_no'] != null && model.astrologerBankData['aadhar_no'] != "" && model.astrologerBankData['aadhar_no'] != "null") {
      aadharController.text = model.astrologerBankData['aadhar_no'].toString();
    } else {
      aadharController.text = "";
    }

    if (model.astrologerBankData['acc_holder_name'] != null && model.astrologerBankData['acc_holder_name'] != "" && model.astrologerBankData['acc_holder_name'] != "null") {
      holderNameController.text = model.astrologerBankData['acc_holder_name'].toString();
    } else {
      holderNameController.text = "";
    }

    if (model.astrologerBankData['acc_no'] != null && model.astrologerBankData['acc_no'] != "" && model.astrologerBankData['acc_no'] != "null") {
      accountNumberController.text = model.astrologerBankData['acc_no'].toString();
    } else {
      accountNumberController.text = "";
    }

    if (model.astrologerBankData['ifsc_code'] != null && model.astrologerBankData['ifsc_code'] != "" && model.astrologerBankData['ifsc_code'] != "null") {
      ifscController.text = model.astrologerBankData['ifsc_code'].toString();
    } else {
      ifscController.text = "";
    }

    if (model.astrologerBankData['bank_name'] != null && model.astrologerBankData['bank_name'] != "" && model.astrologerBankData['bank_name'] != "null") {
      bankNameController.text = model.astrologerBankData['bank_name'].toString();
    } else {
      bankNameController.text = "";
    }
  }

  Future<void> updateBankDetails(BuildContext context, DashboardModelPage modelPage) async {
    toggleshemmerShow();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('login_user_id');
    Dio dio = Dio();

    // http://134.209.229.112/astrology_new/api/save_bank_details

    FormData formData = FormData.fromMap({
      "astro_id": userid,
      "pan_card_no": panController.text.isEmpty ? modelPage.astrologerBankData['pan_card_no'].toString() : panController.text,
      "aadhar_no": aadharController.text.isEmpty ? modelPage.astrologerBankData['aadhar_no'].toString() : aadharController.text,
      "acc_holder_name": holderNameController.text.isEmpty ? modelPage.astrologerBankData['acc_holder_name'].toString() : holderNameController.text,
      "acc_no": accountNumberController.text.isEmpty ? modelPage.astrologerBankData['acc_no'].toString() : accountNumberController.text,
      "ifsc_code": ifscController.text.isEmpty ? modelPage.astrologerBankData['ifsc_code'].toString() : ifscController.text,
      "bank_name": bankNameController.text.isEmpty ? modelPage.astrologerBankData['bank_name'].toString() : bankNameController.text,
      "pan_doc": panCardImage == null ? null : await MultipartFile.fromFile(panCardImageFinal!.path, filename: panCardImageName),
      "passbook_img": bankImage == null ? null : await MultipartFile.fromFile(bankImageFinal!.path, filename: aadharImageName),
      "aadhar_doc": aadharImage == null ? null : await MultipartFile.fromFile(aadharImageFinal!.path, filename: bankImageName),
    });

    debugPrint("$TAG updateBankDetails formData ======> ${formData.fields}");

    var response = await dio.post("${baseURL}save_bank_details", data: formData);
    final responseData = json.decode(response.toString());
    debugPrint("$TAG responseData ======> $responseData");
    try {
      toggleshemmerdismis();
      if (responseData["status"]) {
        modelPage.getAstrologerBankData();
        resetFields();
        Fluttertoast.showToast(msg: responseData["message"]);
        Get.back();
      } else {
        Fluttertoast.showToast(msg: responseData["message"]);
      }
    } catch (e) {
      toggleshemmerdismis();
      debugPrint("$TAG response error from API ======> ${e.toString()}");
    } finally {
      toggleshemmerdismis();
    }
  }

  void resetFields() {
    panController.clear();
    aadharController.clear();
    holderNameController.clear();
    accountNumberController.clear();
    ifscController.clear();
    bankNameController.clear();

    panCardImage == null;
    bankImage == null;
    aadharImage == null;
    panCardImageFinal == null;
    bankImageFinal == null;
    aadharImageFinal == null;

    panCardImageName = null;
    aadharImageName = null;
    bankImageName = null;
  }
}
