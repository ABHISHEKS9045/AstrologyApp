import 'dart:convert';
import 'dart:io';

import 'package:astrologyapp/common/apiErroralertdiloge.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../../common/bottomnavbar/bottomnavbar.dart';
import '../../common/styles/const.dart';
import '../chat room/chatroomPage.dart';

class Chatlistmodelpage extends ChangeNotifier {
  String TAG = "Chatlistmodelpage";
  TextEditingController typingmessage = TextEditingController();
  ScrollController scrollController = ScrollController();
  TextEditingController nameCont = TextEditingController();
  TextEditingController dobCont = TextEditingController();
  TextEditingController timeCont = TextEditingController();
  TextEditingController placeCont = TextEditingController();

  Map _userdataMap = {};

  Map get userdataMap => _userdataMap;
  var walletAmount;
  String userType = '1';

  typingreset() {
    typingmessage.clear();
    notifyListeners();
  }

  toggelSenderId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _ourSanderid = prefs.getString('login_user_id');
    notifyListeners();
  }

  profileView(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "user_id": json.decode(userid!),
    });

    var response = await dio.post("${baseURL}view_users", data: formData);
    final responseData = json.decode(response.toString());
    try {
      if (responseData['status'] == true) {
        _userdataMap = responseData["data"];
        nameCont.text = userdataMap['name'];
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
    }
  }

  bool _noChatFound = true;

  bool get noChatFound => _noChatFound;

  String? _reseverid;

  String? get reseverid => _reseverid;

  String? _reseverSocketToken;

  String? get reseverSocketToken => _reseverSocketToken;

  String? _reseverName;

  String? get reseverName => _reseverName;

  String? _reseverImage;

  String? get reseverImage => _reseverImage;

  String? _reseverFtoken;

  String? get reseverFtoken => _reseverFtoken;

  String? _ourSanderid;

  String? get ourSanderid => _ourSanderid;

  String _onlineStatus = "";

  String get onlineStatus => _onlineStatus;

  List chatHistoryList = [];
  List Mylist1 = [];

  int? _chatTime;

  int? get chatTime => _chatTime;

  toggleChatAvailableTime(int availableTime) {
    _chatTime = availableTime;
    notifyListeners();
  }

  toggelreseverid(reseveridValue) {
    _reseverid = reseveridValue.toString();
    notifyListeners();
  }

  toggelreseverSocketToken(reseveridSocketToken) {
    _reseverSocketToken = reseveridSocketToken.toString();
    notifyListeners();
  }

  toggelresevername(reseverNameValue) {
    _reseverName = reseverNameValue;
    notifyListeners();
  }

  toggelreseverImage(reseverImageValue) {
    _reseverImage = reseverImageValue;
    notifyListeners();
  }

  toggelreseverdiveiceid(reseverdeviceid) {
    _reseverFtoken = reseverdeviceid;
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

  List _chatconversiondata = [];

  List get chatconversiondata => _chatconversiondata;

  setChatListData(messages) {
    _chatconversiondata.clear();
    _chatconversiondata = messages;
    notifyListeners();
  }

  insertMessage(message) {
    bool isDuplicate = false;
    chatconversiondata.forEach((element) {
      if (element['message_id'] == message['id'] && element['message'] == message['message']) {
        isDuplicate = true;
      }
    });
    if (!isDuplicate) {
      chatconversiondata.add({
        "chat_message": message['message'],
        "from_user_id": message['from_user_id'],
        "to_user_id": message['to_user_id'],
        "message_time": message['message_time'],
        "message_id": message['id'],
        "message_date": message['message_date'],
      });
      Future.delayed(const Duration(milliseconds: 400));
    }
    notifyListeners();
  }

  DateTime? newdob;
  DateTime currentDate = DateTime.now();

  selectDate(context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1950),
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
                  primary: colororangeLight, //
                ),
              ),
            ),
            child: child!,
          );
        },
        lastDate: DateTime(2050)) as DateTime;
    if (pickedDate != currentDate) {
      currentDate = pickedDate;
      _userdataMap['dob'] = DateFormat('dd-MM-yyyy').format(currentDate);
    }
    newdob = pickedDate;
    notifyListeners();
  }

  String? onlydate;

  String? gettext(modelprofileview) {
    if (newdob == null) {
      return onlydate = modelprofileview.userdataMap['dob'].toString();
    } else {
      onlydate = DateFormat('dd-MM-yyyy').format(currentDate);
      return onlydate;
    }
  }

  TimeOfDay selectedTime = TimeOfDay.now();

  selectTime(context) async {
    TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
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
                  primary: colororangeLight, //
                ),
              ),
            ),
            child: child!,
          );
        });
    if (timeOfDay != selectedTime) {
      selectedTime = timeOfDay as TimeOfDay;
      newTime = timeOfDay;
      final hours = selectedTime.hour.toString().padLeft(2, '0');
      final minutes = selectedTime.minute.toString().padLeft(2, '0');
      _userdataMap['birth_time'] = "$hours:$minutes";
      notifyListeners();
    }
  }

  TimeOfDay? newTime;
  String? onlytime; //TimeOfDay(15:30) remove timeof day

  String? gettimetext(modelprofileview) {
    if (newTime == null) {
      return onlytime = modelprofileview.userdataMap['birth_time'].toString();
    } else {
      final hours = selectedTime.hour.toString().padLeft(2, '0');
      final minutes = selectedTime.minute.toString().padLeft(2, '0');
      onlytime = "$hours:$minutes";
      return onlytime;
    }
  }

  walletRemoveBalance(coin, perMinute, astroId, DateTime startTime, name) async {
    toggleshemmerShow();
    await Future.delayed(const Duration(milliseconds: 300));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');

    var perMinutesvalue = perMinute != null ? perMinute : "0";
    Dio dio = Dio();

    FormData formData =
        FormData.fromMap({"user_id": userid, "astro_id": astroId, 'name': name, 'duration': coin, "current_used_bal": coin * int.parse(perMinutesvalue), 'start_time': DateFormat('dd-MM-yyyy hh:mm a').format(startTime), 'end_time': DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now())});

    var response = await dio.post("${baseURL}wallet_amount_deduct", data: formData);
    final responseData = json.decode(response.toString());
    try {
      if (responseData['status'] == true) {
        Fluttertoast.showToast(msg: '₹${coin * int.parse(perMinute)} deducted from your wallet..');
        notifyListeners();
        toggleshemmerdismis();
      } else {
        notifyListeners();
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
    }
  }

  conversionlist(receiverId) async {
    toggleshemmerShow();
    await Future.delayed(const Duration(milliseconds: 300));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "user_id": userid,
      "sender_id": userid,
      "receiver_id": receiverId,
    });

    var response = await dio.post("${baseURL}view_call_chat", data: formData);
    final responseData = json.decode(response.toString());
    try {
      if (responseData['status'] == true) {
        _chatconversiondata.clear();
        _chatconversiondata = responseData['data'];
        _reseverFtoken = chatconversiondata.last['device_id'];
        _ourSanderid = userid;
        _noChatFound = false;

        notifyListeners();
        toggleshemmerdismis();
        notifyListeners();
      } else {
        _noChatFound = true;
        notifyListeners();
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
    }
  }

  sendInitialMessage(context, socket) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');
    String? initialMessage = prefs.getString('initial_message');

    var time = DateFormat.jm().format(DateTime.now());
    var date = DateFormat('yyyy-MM-dd').format(DateTime.now());

    var map = {
      "from_user_id": userid,
      "to_user_id": reseverid,
      "message": initialMessage,
      'time': time,
      'message_date': date,
    };
    socket.emit("message", map);

    chatconversiondata.add({
      'chat_message': map['message'],
      "id": map['from_user_id'],
      "from_user_id": map['from_user_id'],
      "to_user_id": map['to_user_id'],
      "message_time": map['time'],
      'message_date': date,
    });
    notifyListeners();
    typingmessage.clear();
    notifyListeners();
  }

  conversiontypingsubmit(context, socket) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');

    var time = DateFormat.jm().format(DateTime.now());
    var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var map = {"from_user_id": userid, "to_user_id": reseverid, "message": typingmessage.text, 'time': time, 'message_date': date};

    if (typingmessage.text != '') {
      socket.emit("message", map);

      chatconversiondata.add({'chat_message': map['message'], "id": map['from_user_id'], "from_user_id": map['from_user_id'], "to_user_id": map['to_user_id'], "message_time": map['time'], 'message_date': date});
      notifyListeners();
    }
    typingmessage.clear();
    notifyListeners();
  }

  conversionInitialDetails(context) async {
    toggleshemmerShow();
    chatUserList(context: context, categoryId: 0);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');
    Dio dio = Dio();
    if (reseverFtoken == null) toggelreseverdiveiceid('cOZLTyavSjOvl6o05gNpZh:APA91bGLCWMH9oABWCXh573qvqoemevWtwhtpbXZAXB62MIPu6IoH9t7Qrdg4-if-p9n68e4aQul44IhyFaj8qoCl4hELOh7fIv7sXLGCG5CMRrCufpwu_V8bC88BkqNwVvvnNnEyugz');

    await dashboardprofileview(context);

    String name = senderDetails['name'] ?? '';
    String dob = senderDetails['dob'] ?? '';
    String birthTime = senderDetails['birth_time'] ?? '';
    String gender = senderDetails['gender'] ?? 'Male';
    String birthPlace = senderDetails['birth_place'] ?? '';
    String message = 'Hello $reseverName,\nBelow are my details:\n'
        'Name: $name\n'
        'DOB: $dob\n'
        'Gender: $gender\n'
        'Birth Time: $birthTime\n'
        'Birth Place: $birthPlace\n'
        'Martial Status: No\n';

    FormData formData = FormData.fromMap({
      "user_id": userid,
      "sender_id": userid,
      "receiver_id": reseverid,
      "message": message,
      "device_id": reseverFtoken,
    });
    // print('peram ${formData.fields}');
    var response = await dio.post("${baseURL}add_call_chat", data: formData);

    final responseData = json.decode(response.toString());

    try {
      if (responseData['status'] == true) {
        toggleshemmerdismis();
        FocusScope.of(context).unfocus();

        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
    }
  }

  var senderDetails;

  dashboardprofileview(context) async {
    await Future.delayed(const Duration(seconds: 1));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');

    var deviceToken = "deviceToken";
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceToken = androidInfo.id;
    }

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "user_id": userid,
      "device_id": deviceToken,
    });

    var response = await dio.post("${baseURL}view_users", data: formData);

    final responseData = json.decode(response.toString());

    try {
      if (responseData['status'] == true) {
        senderDetails = responseData["data"];
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
    }
  }

  List callHistoryList = [];
  List astrologerListdb = [];
  List categoryList = [];

  List waitListForAstrologer = [];
  List tempWaitListForAstrologer = [];

  int _diff = 0;

  // List get astrologerListdb => _astrologerListdb;

  int get diff => _diff;

  getChatStatus(BuildContext context, astroId) async {
    Dio dio = Dio();

    FormData formData = FormData.fromMap({
      'astro_id': astroId,
    });

    var response = await dio.post("${baseURL}get_chat_status", data: formData);

    final responseData = json.decode(response.toString()); //map is not a subtype of string error aaye to ye then apply
    debugPrint("$TAG getChatStatus responseData ========> $responseData");
    try {
      if (responseData['status'] == true) {
        if (responseData['data'] == null) {
          return true;
        }
        if (responseData['data']['chat_status'] == 1) {
          return false;
        } else {
          return true;
        }
      } else {
        toggleshemmerdismis();
        var messages = responseData["message"];
        if (context.mounted) {
          apiErrorAlertdialog(context, messages);
        }
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Astrologer is busy..');
      return false;
    }
  }

  callChatInitApi(context, time, perMinute, astroId, int isFree) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');

    Dio dio = Dio();

    FormData formData = FormData.fromMap({
      'sender_id': userid,
      'receiver_id': astroId,
      'is_free': isFree,
    });
    var response = await dio.post("${baseURL}send_request", data: formData);
    final responseData = json.decode(response.toString());
    debugPrint("$TAG call Chat Init Api ==========> ${responseData.toString()}");
    if (responseData['success'] == 1) {
    } else {
      toggleshemmerdismis();
      apiErrorAlertdialog(context, responseData['message']);
    }
  }

  rejectChatRequest(context, receiverId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');
    print("object=====>$userid");
    Dio dio = Dio();
    FormData formData = FormData.fromMap({'sender_id': userid, 'receiver_id': receiverId});
    var response = await dio.post("${baseURL}cancle_request", data: formData);
    final responseData = json.decode(response.toString());
    if (responseData['success'] == 1) {
      Future.delayed(const Duration(milliseconds: 100), () {
        Navigator.of(context).pop();
      });
    } else {
      toggleshemmerdismis();
      // var messages = responseData["message"];
      // apiErrorAlertdialog(context, messages);
      var messages1 = 'Unable to cancel chat request at this time';
      apiErrorAlertdialog(context, messages1);
    }
  }

  astrologerResponseApi(context, requestId, receiver_id, userName, userImage, perMinute) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      'id': requestId,
      'receiver_id': receiver_id, //3
      'sender_id': userid, //1
      'per_minute': perMinute
    });
    var response = await dio.post("${baseURL}approve_request", data: formData);
    final responseData = json.decode(response.toString());
    if (responseData['success'] == 1) {
      // comment by nilesh added delay on 14-04-2023
      Future.delayed(const Duration(milliseconds: 100), () {
        Get.to(() => ChatRoomPage(
              chatTime: 0,
              receiver_id: receiver_id,
              isForHistory: false,
              userName: userName,
              perMinute: perMinute,
            ));
      });
      toggelreseverid(receiver_id);
      toggelreseverImage(userImage);
      toggelresevername(userName);
    } else {
      toggleshemmerdismis();
      var messages1 = 'Unable to accept chat request at this time';
      apiErrorAlertdialog(context, messages1);
    }
  }

  updateChatStatus(context, astroId, duration, isStart) async {
    toggleshemmerShow();
    Dio dio = Dio();

    DateTime startTime = DateTime.now();
    DateTime endTime = startTime.add(Duration(minutes: duration));
    FormData formData = FormData.fromMap({
      "start_time": startTime,
      "end_time": endTime,
      'astro_id': astroId,
      'status': isStart ? 1 : 0,
    });

    try {
      var response = await dio.post("${baseURL}chat_status_update", data: formData);
    } catch (e) {
      debugPrint("$TAG catch e =========> $e");
    }
  }

  chatUserList({required BuildContext context, required int categoryId, String? status}) async {
    toggleshemmerShow();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usertype = prefs.getString('user_type');

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "user_type": usertype,
      "limit": '50',
      "offset": '0',
      'category_id': categoryId,
      "user_status": status,
    });

    debugPrint("$TAG chat User List form data =======> ${formData.fields}");

    var response = await dio.post("${baseURL}astrologer_list", data: formData);
    final responseData = json.decode(response.toString());

    debugPrint("$TAG chat User List responseData =======> $responseData");

    try {
      if (responseData['status'] == true) {
        astrologerListdb.clear();
        astrologerListdb = responseData['list'];
        // debugPrint('$TAG all astrologer list user ===========> ${astrologerListdb.toString()}');
        debugPrint('$TAG all astrologer list size ===========> ${astrologerListdb.length}');
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        var messages = responseData["message"];
        astrologerListdb.clear();
        notifyListeners();
        if(context.mounted) {
          apiErrorAlertdialog(context, messages);
        }
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      toggleshemmerdismis();
      notifyListeners();
    }
  }

  chatUserListForCall({required BuildContext context, required int categoryId, String? status}) async {
    toggleshemmerShow();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usertype = prefs.getString('user_type');

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "user_type": usertype,
      "limit": '50',
      "offset": '0',
      "type": "call",
      'category_id': categoryId,
      "user_status": status,
    });

    debugPrint("$TAG chat User List form data =======> ${formData.fields}");

    var response = await dio.post("${baseURL}astrologer_list", data: formData);
    final responseData = json.decode(response.toString());

    debugPrint("$TAG chat User List responseData =======> $responseData");

    try {
      if (responseData['status'] == true) {
        astrologerListdb.clear();
        astrologerListdb = responseData['list'];
        // debugPrint('$TAG all astrologer list user ===========> ${astrologerListdb.toString()}');
        debugPrint('$TAG all astrologer list size ===========> ${astrologerListdb.length}');
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        var messages = responseData["message"];
        if(context.mounted) {
          apiErrorAlertdialog(context, messages);
        }
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      toggleshemmerdismis();
      notifyListeners();
    }
  }

  chatUserListForChat({required BuildContext context, required int categoryId, String? status}) async {
    toggleshemmerShow();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usertype = prefs.getString('user_type');

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "user_type": usertype,
      "limit": '50',
      "offset": '0',
      "type": "chat",
      'category_id': categoryId,
      "user_status": status,
    });

    debugPrint("$TAG chat User List form data =======> ${formData.fields}");

    var response = await dio.post("${baseURL}astrologer_list", data: formData);
    final responseData = json.decode(response.toString());

    debugPrint("$TAG chat User List responseData =======> $responseData");

    try {
      if (responseData['status'] == true) {
        astrologerListdb.clear();
        astrologerListdb = responseData['list'];
        // debugPrint('$TAG all astrologer list user ===========> ${astrologerListdb.toString()}');
        debugPrint('$TAG all astrologer list size ===========> ${astrologerListdb.length}');
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        var messages = responseData["message"];
        if(context.mounted) {
          apiErrorAlertdialog(context, messages);
        }
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      toggleshemmerdismis();
      notifyListeners();
    }
  }

  getChatHistoryList(context) async {
    toggleshemmerShow();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('login_user_id');
    var user_Type = prefs.getString('user_type');

    userType = user_Type!;

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      'user_id': userid,
      'user_type': user_Type,
    });
    try {
      debugPrint("$TAG getChatHistoryList formData userid =======> $userid");
      var response = await dio.post("${baseURL}chat_histroy", data: formData);
      final responseData = json.decode(response.toString());
      debugPrint("$TAG Response Data ========> $responseData");
      if (response.statusCode == 200) {
        chatHistoryList = responseData['data'];
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        var messages = responseData["message"];
        apiErrorAlertdialog(context, messages);
      }
    } catch (e) {
      toggleshemmerdismis();
    }
  }

  getCategoryList(context) async {
    toggleshemmerShow();

    Dio dio = Dio();
    var response = await dio.get("${baseURL}view_all_category");
    final responseData = json.decode(response.toString()); //map is not a subtype of string error aaye to ye then apply
    try {
      if (response.statusCode == 200) {
        categoryList = responseData['data'];
        categoryList.insert(0, {'category_name': 'All', 'id': 0});

        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        var messages = responseData["message"];
        apiErrorAlertdialog(context, messages);
      }
    } catch (e) {
      toggleshemmerdismis();
    }
  }

  getCallHistoryList(context) async {
    toggleshemmerShow();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usertype = prefs.getString('user_type');
    String? userId = prefs.getString('login_user_id');

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "user_id": userId,
      "user_type": usertype,
    });

    debugPrint("$TAG get Call History List form data ========> ${formData.fields}");

    try {
      var response = await dio.post("${baseURL}call_history", data: formData);

      final responseData = json.decode(response.toString()); //map is not a subtype of string error aaye to ye then apply
      debugPrint("$TAG get Call History List response Data ========> $responseData");

      if (responseData['status']) {
        callHistoryList = responseData['data'];
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        var messages = responseData["message"];
        apiErrorAlertdialog(context, messages);
      }
    } catch (e) {
      toggleshemmerdismis();
    }
  }

  saveCallDetails(BuildContext context, userId, String astroId, callSid, callresponse, To, From, chargePerMinute, status) async {
    toggleshemmerShow();

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "user_id": userId,
      "astro_id": astroId,
      "call_sid": callSid,
      "call_data": callresponse.toString(),
      'to_number': From,
      'from_number': To,
      // 'current_used_bal': 0,
      'per_minute': chargePerMinute,
      'call_status': status,
    });
    var response = await dio.post("${baseURL}call_back", data: formData);
    final responseData = json.decode(response.toString()); //map is not a subtype of string error aaye to ye then apply
    try {
      if (response.statusCode == 200) {
        toggleshemmerdismis();
        updateFirebaseStatus(astroId);
        notifyListeners();
        callConnectingDialog(context);
      } else {
        toggleshemmerdismis();
        var messages = responseData["message"];
        apiErrorAlertdialog(context, messages);
      }
    } catch (e) {
      toggleshemmerdismis();
    }
  }

  initiateCall(BuildContext context, toNumber, String astro_id, chargePerMinute, selectedTime) async {
    // toggleshemmerShow();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('login_user_id');
    //Start
    await getWalletBalance(context);

    double time = walletAmount / int.parse(chargePerMinute);

    if (time.floor() <= 0) {
      Fluttertoast.showToast(msg: 'Insufficient balance to initiate call..');
      return;
    } else {
      selectedTime = time.floor();
    }
    //end
    Dio dio = Dio();
    String? fromNo = prefs.getString('loginmobile');
    // dio.options.headers["authorization"] = "Basic ZGMyYjhhNTQ3YjY3ZTQ1MjYwMWYxZmE4NTFhOGFjMjVjNzU4YmNmODc0NjExZDJhOmE5ODZhOTFhNDkzNmY1ZmE1NjgzNjc3NTJjYmMzZGIwNTk0YzMzYzJiYjA0NTNhZA==";
    dio.options.headers["authorization"] = "Basic MTc3M2RmZGQ5NDYxMmY1OWYwYTUwNTdlYjNlZjc2ZTdiN2JjNDkwOTlhNjEwNDE0OmRhNTIzOGUzNjEyYWFiOTA4ZmQ0NDVlOWQ1NTQwNzM3Mjk3ODkwZmRmM2UzNDRkZA==";

    FormData formData = FormData.fromMap({
      "From": toNumber,
      "To": fromNo,
      "CallerId": '08045888875',
      'TimeLimit': selectedTime >= 10 ? 600 : selectedTime * 60,
      'StatusCallback': "http://134.209.229.112/astrology_new/exotelCallBack.php",
    });

    debugPrint('$TAG params for call API =========> ${formData.fields}');

    try {
      var response = await dio.post("https://api.exotel.com/v1/Accounts/connectaastro1/Calls/connect.json", data: formData);
      final responseData = json.decode(response.toString());
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Connecting your call...');
        Map<String, dynamic> map = {"user_id": userId, "astro_id": astro_id, 'to_number': toNumber, 'from_number': fromNo, 'call_sid': responseData['Call']['Sid'], 'charge_per_minute': chargePerMinute};
        Workmanager().registerOneOffTask('taskName', 'backUpData', initialDelay: Duration(seconds: (selectedTime + 1) * 60), inputData: map);
        saveCallDetails(context, userId, astro_id, responseData['Call']['Sid'], response.toString(), toNumber, fromNo, chargePerMinute, responseData['Call']['Status']);
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        var messages = responseData["message"];
        apiErrorAlertdialog(context, messages);
      }
    } catch (e) {
      toggleshemmerdismis();
      if (e is DioError) {
        debugPrint("$TAG error =======> ${e.message.toString()}");
        if (e.response!.statusCode == 403) {
          Fluttertoast.showToast(msg: 'Call failed because of TRAI NDNC regulations.');
        } else if (e.response!.statusCode == 401) {
          Fluttertoast.showToast(msg: 'Insufficient balance...');
        } else {
          Fluttertoast.showToast(msg: 'Call Failed\nPlease try again later...');
        }
      }
    }
  }

  saveCallInQueue(toNumber, astro_id, time) async {
    // DateTime startTime = DateTime.now();
    // DateTime endTime = startTime.add(Duration(minutes: time));
    // Dio dio = Dio();
    // final formData = {
    //   'astro_id': astro_id,
    //   'mobile_no': toNumber,
    //   'start_time': startTime.toString(),
    //   'end_time': endTime.toString(),
    // };
    // var response = await dio.post("${baseURL}call_in_queue_save", data: formData);

    // print(response);
  }

  getWalletBalance(BuildContext? context) async {
    var deviceToken = "deviceToken";
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceToken = androidInfo.id;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('login_user_id');
    var userType = prefs.getString('user_type');
    Dio dio = Dio();
    final formData = {
      'user_id': userid,
      'user_type': userType,
      'device_id': deviceToken,
    };

    var response = await dio.post("${baseURL}view_wallet_bal", data: formData);
    final responseData = json.decode(response.data);
    try {
      if (responseData['status'] == true) {
        walletAmount = responseData['Amount'];
      } else {
        debugPrint("$TAG status == false for get wallet balance");
      }
    } catch (e) {
      debugPrint("$TAG error get wallet balance ========> ${e.toString()}");
    }
  }

  String? socketToken;

  Future<void> getSocketToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    socketToken = prefs.getString('socket_token');
    notifyListeners();
  }

  getWaitCustomersList({required BuildContext context, required String type, String? astroId}) async {
    toggleshemmerShow();
    waitListForAstrologer.clear();
    tempWaitListForAstrologer.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId;
    if(astroId == null || astroId == "") {
      userId = prefs.getString('login_user_id');
    } else {
      userId = astroId;
    }

    Dio dio = Dio();
    FormData formData = FormData.fromMap({"astro_id": userId, "type": type});
    var response = await dio.post("${baseURL}get_waiting_list", data: formData);
    final responseData = json.decode(response.toString());

    debugPrint("$TAG waiting list id responseData =======> $responseData");

    try {
      if (responseData['status']) {
        tempWaitListForAstrologer = responseData['data'];
        waitListForAstrologer.addAll(tempWaitListForAstrologer);
        debugPrint('$TAG astrologer wait list of users ===========> ${waitListForAstrologer.toString()}');
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        notifyListeners();
        var messages = responseData["message"];
        if (context.mounted) {
          apiErrorAlertdialog(context, messages);
        }
      }
    } catch (e) {
      toggleshemmerdismis();
      notifyListeners();
      debugPrint("$TAG error getWaitCustomersList =======> ${e.toString()}");
    }
  }

  addUserToAstrologerWaitList({required int astroId, required String type}) async {
    toggleshemmerShow();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('login_user_id');
    Dio dio = Dio();
    FormData formData = FormData.fromMap({"astro_id": astroId, "user_id": userId, "type": type});

    debugPrint("$TAG add to wait list fields =======> ${formData.fields}");

    // http://134.209.229.112/astrology/api/add_waiting_list
    var response = await dio.post("${baseURL}add_waiting_list", data: formData);
    final responseData = json.decode(response.toString());

    debugPrint("$TAG add to wait list =======> $responseData");

    try {
      if (responseData['status']) {
        notifyListeners();
        Fluttertoast.showToast(msg: "Your request has been added to wait list");
        toggleshemmerdismis();
      } else {
        debugPrint("$TAG add to wait list api error =======> $responseData");
        toggleshemmerdismis();
        notifyListeners();
        //var messages = responseData["message"];
        //apiErrorAlertdialog(context, messages);
      }
    } catch (e) {
      toggleshemmerdismis();
      debugPrint("$TAG add to wait list error =======> $e");
      notifyListeners();
    }
  }

  rejectWaitRequest(BuildContext context, int id, String type) async {
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "request_id": id,
    });
    // http://134.209.229.112/astrology/api/reject_user_chat_request
    var response = await dio.post("${baseURL}reject_user_chat_request", data: formData);
    final responseData = json.decode(response.toString());

    debugPrint("$TAG add to wait list =======> $responseData");

    try {
      if (responseData['success'] == 1) {
        if (waitListForAstrologer.isNotEmpty) {
          waitListForAstrologer.removeAt(0);
        }
        Fluttertoast.showToast(msg: "You rejected $type request");
        notifyListeners();
      } else {
        debugPrint("$TAG add to wait list api error =======> $responseData");
        //var messages = responseData["message"];
        //apiErrorAlertdialog(context, messages);
      }
    } catch (e) {
      debugPrint("$TAG add to wait list error =======> $e");
    }
  }

  acceptUserWaitChatRequest(BuildContext context, int id, String type) async {

    debugPrint("accept User's Wait Chat Request  ==========> $id");
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "request_id": id,
    });
    debugPrint("accept User Wait Chat Request formData ==========> ${formData.fields}");
    // http://134.209.229.112/astrology/api/send_user_chat_request
    var response = await dio.post("${baseURL}send_user_chat_request", data: formData);
    final responseData = json.decode(response.toString());

    debugPrint("$TAG accept User Wait Chat Response =======> $responseData");

    try {


      if (responseData['success'] == 1) {
        if (waitListForAstrologer.isNotEmpty) {
          waitListForAstrologer.removeAt(0);
        }
        Fluttertoast.showToast(msg: "You accepted $type request");
        notifyListeners();
      } else {
        debugPrint("$TAG add to wait list api error =======> $responseData");
        //var messages = responseData["message"];
        //apiErrorAlertdialog(context, messages);
      }
    } catch (e) {
      debugPrint("$TAG add to wait list error =======> $e");
    }
  }

  customerAcceptChatRequest(BuildContext context, int requestId, int receiverId, int perMinute, int time, String userName) async {
    debugPrint("customer Accept Chat Request ==========> $requestId");
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "request_id": requestId,
    });
    debugPrint("accept User Wait Chat Request formData ==========> ${formData.fields}");
    // http://134.209.229.112/astrology/api/approve_astro_chat_request
    var response = await dio.post("${baseURL}approve_astro_chat_request", data: formData);
    debugPrint("$TAG customer accept chat request =======> ${response.toString()}");
    final responseData = json.decode(response.toString());

    debugPrint("$TAG customer Accept Chat Request =======> $responseData");

    try {
      if (responseData['success'] == 1) {
        notifyListeners();
        if (context.mounted) {
          String name = userdataMap['name'];
          String dob = userdataMap['dob'];
          String birthTime = userdataMap['birth_time'];
          String birthPlace = userdataMap['birth_place'];

          String initialMessage = "Name: $name\nDOB: $dob\nBirth Time: $birthTime\nBirth Place: $birthPlace\nMartial Status: \nOccupation: \nConcern: ";

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('initial_message', initialMessage);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return ChatRoomPage(
                chatTime: time,
                isForHistory: false,
                perMinute: perMinute.toString(),
                userName: userName.toString(),
                receiver_id: receiverId.toString(),
              );
            },
          ));
        }
      } else {
        Fluttertoast.showToast(msg: responseData['message']);
      }
    } catch (e) {
      debugPrint("$TAG customer Accept Chat Request error =======> $e");
    }
  }

  customerRejectChatRequest(var id) async {
    debugPrint("Reject User Wait Chat Request id ==========> $id");
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "request_id": id,
    });
    debugPrint("Reject User Wait Chat Request formData ==========> ${formData.fields}");
    // http://134.209.229.112/astrology/api/reject_astro_chat_request
    var response = await dio.post("${baseURL}reject_astro_chat_request", data: formData);
    debugPrint("$TAG Reject User Wait Chat response =======> ${response.toString()}");
    final responseData = json.decode(response.toString());
    debugPrint("$TAG Reject User Wait Chat response =======> $responseData");

    try {
      if (responseData['success'] == 1) {
        notifyListeners();
        Get.offUntil(
          MaterialPageRoute(
            builder: (context) {
              return BottomNavBarPage();
            },
          ),
          (route) {
            return false;
          },
        );
      } else {
        Fluttertoast.showToast(msg: "Unable to reject request at this time.");
      }
    } catch (e) {
      debugPrint("$TAG add to wait list error =======> $e");
    }
  }

  searchUsersInChatWaitList(String text) {
    waitListForAstrologer.clear();
    waitListForAstrologer.addAll(tempWaitListForAstrologer);
    waitListForAstrologer.retainWhere((dynamic item) {
      return item["name"].toLowerCase().contains(text.toLowerCase());
    });
    notifyListeners();
  }

  setActualWaitChatList() {
    waitListForAstrologer.clear();
    waitListForAstrologer.addAll(tempWaitListForAstrologer);
    notifyListeners();
  }

  DatabaseReference ref = FirebaseDatabase.instance.ref();

  // update firebase login status of user added by nilesh on 09-06-2023
  // start
  Future<void> updateFirebaseStatus(String astroId) async {
    String? userKey = "users_$astroId";
    var postData = {"id": astroId, "is_busy": 1, "status": "Online"};
    FirebaseDatabase.instance.ref(userKey).set(postData);
    // List<dynamic> userList = [];
    // String? userKey = "";
    // ref.orderByChild('id').equalTo(astroId).once().then((DatabaseEvent value) {
    //   if (value.snapshot.children != null) {
    //     debugPrint("$TAG event value snapshot =======> ${value.snapshot.children}");
    //     for (DataSnapshot element in value.snapshot.children) {
    //       if (element.key != null) {
    //         debugPrint("$TAG element key =======> ${element.key}");
    //         debugPrint("$TAG element value =======> ${element.value}");
    //         userKey = element.key;
    //         userList.add(element.value);
    //       }
    //     }
    //
    //     if (userKey != null && userKey != "" && astroId != null && astroId != "") {
    //       FirebaseDatabase.instance.ref(userKey).set({"id": astroId, "is_busy": 1, "status": "Online"}).whenComplete(() {
    //         debugPrint("$TAG if user data updated");
    //       }).onError((error, StackTrace stackTrace) {
    //         debugPrint("$TAG if error on update =====> ${error.toString()}");
    //         debugPrint("$TAG if stackTrace on update =====> ${stackTrace.toString()}");
    //         FirebaseCrashlytics.instance.recordError(error, stackTrace);
    //       });
    //     } else {
    //       if(astroId != null && astroId != "") {
    //         final newPostKey = ref.push().key;
    //         final postData = {"id": astroId, "is_busy": 1, "status": "Online"};
    //         final Map<String, Map> updates = {};
    //         updates['$newPostKey'] = postData;
    //
    //         ref.update(updates).whenComplete(() {
    //           debugPrint("$TAG else user data updated");
    //         }).onError((error, stackTrace) {
    //           debugPrint("$TAG else error on update =====> ${error.toString()}");
    //           debugPrint("$TAG else stackTrace on update =====> ${stackTrace.toString()}");
    //           FirebaseCrashlytics.instance.recordError(error, stackTrace);
    //         });
    //       }
    //     }
    //   }
    // });
  }
  // end

  getWaitCustomersListForCheckJoinChat({required String type, String? astroId}) async {
    waitListForAstrologer.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId;
    if(astroId == null || astroId == "") {
      userId = prefs.getString('login_user_id');
    } else {
      userId = astroId;
    }

    Dio dio = Dio();
    FormData formData = FormData.fromMap({"astro_id": userId, "type": type});
    var response = await dio.post("${baseURL}get_waiting_list", data: formData);
    final responseData = json.decode(response.toString());

    debugPrint("$TAG waiting list id responseData =======> $responseData");

    try {
      if (responseData['status']) {
        waitListForAstrologer = responseData['data'];

        debugPrint('$TAG astrologer wait list of users ===========> ${waitListForAstrologer.toString()}');
        notifyListeners();
      } else {
        notifyListeners();
      }
    } catch (e) {
      notifyListeners();
      debugPrint("$TAG error getWaitCustomersList =======> ${e.toString()}");
    }
  }




}
