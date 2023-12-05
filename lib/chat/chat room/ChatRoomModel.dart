import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:astrologyapp/common/apiErroralertdiloge.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/src/socket.dart';

import '../../common/styles/const.dart';

class ChatRoomModel extends ChangeNotifier {
  String TAG = "ChatRoomModel";

  TextEditingController typingmessage = TextEditingController();

  List _chatconversiondata = [];

  List get chatconversiondata => _chatconversiondata;

  String? _reseverid;

  String? get reseverid => _reseverid;

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

  bool _isShimmer = false;

  bool get isShimmer => _isShimmer;

  int? _chatTime;

  int? get chatTime => _chatTime;

  var walletAmount;

  toggleShimmerShow() {
    _isShimmer = true;
    notifyListeners();
  }

  toggleShimmerDismiss() {
    _isShimmer = false;
    notifyListeners();
  }

  toggleReceiverName(String receiverNameValue) {
    _reseverName = receiverNameValue;
    notifyListeners();
  }

  toggleReceiverId(String receiverId) {
    _reseverid = receiverId;
    notifyListeners();
  }

  toggleSenderId(String senderId) {
    _ourSanderid = senderId;
    notifyListeners();
  }

  toggleChatAvailableTime(int availableTime) {
    _chatTime = availableTime;
    notifyListeners();
  }

  sendOnline(socket) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');
    var map = {"from_user_id": userid, "to_user_id": reseverid, "socket_id": socket.id};
    socket.emit("user_data", map);
  }

  setChatListData(dynamic message) {
    _chatconversiondata.clear();
    _chatconversiondata = message;
    notifyListeners();
  }

  sendInitialMessage(BuildContext context, Socket? socket) async {
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
      'message_type': 'text',
    };
    socket?.emit("message", map);

    chatconversiondata.add({
      'chat_message': map['message'],
      "id": map['from_user_id'],
      "from_user_id": map['from_user_id'],
      "to_user_id": map['to_user_id'],
      "message_time": map['time'],
      'message_date': date,
      'message_type': 'text',
    });
    notifyListeners();
    typingmessage.clear();
    notifyListeners();
  }

  insertMessage(dynamic message) {
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
        "message_type": message['message_type'],
      });
      Future.delayed(const Duration(milliseconds: 400));
    }
    notifyListeners();
  }

  Future<void> updateChatStatus(receiverId, int chatTime, bool isStart) async {
    Dio dio = Dio();

    DateTime startTime = DateTime.now();
    DateTime endTime = startTime.add(Duration(minutes: chatTime));
    FormData formData = FormData.fromMap({
      "start_time": startTime,
      "end_time": endTime,
      'astro_id': receiverId,
      'status': isStart ? 1 : 0,
    });
    try {
      var response = await dio.post("${baseURL}chat_status_update", data: formData);
    } catch (e) {
      debugPrint("$TAG catch e =========> $e");
    }
  }

  walletRemoveBalance(int min, perMinute, receiverId, DateTime startTime, receiverName) async {
    // toggleShimmerShow();
    await Future.delayed(Duration(milliseconds: 300));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');

    var perMinutesvalue = perMinute != null ? perMinute : "0";
    Dio dio = Dio();

    FormData formData = FormData.fromMap({
      "user_id": userid,
      "astro_id": receiverId,
      'name': receiverName,
      'duration': min,
      "current_used_bal": min * int.parse(perMinutesvalue),
      'start_time': DateFormat.Hms().format(startTime),
      'end_time': DateFormat.Hms().format(DateTime.now()),
    });

    var response = await dio.post("${baseURL}wallet_amount_deduct", data: formData);
    final responseData = json.decode(response.toString());
    try {
      if (responseData['status'] == true) {
        Fluttertoast.showToast(msg: '₹${min * int.parse(perMinute)} deducted from your wallet..');
        notifyListeners();
        // toggleShimmerDismiss();
      } else {
        notifyListeners();
        // toggleShimmerDismiss();
      }
    } catch (e) {
      // toggleShimmerDismiss();
    }
  }

  Future<void> getCustomerWalletBalance(BuildContext context, String customerId, var perMinute) async {
    var deviceToken = "deviceToken";
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceToken = androidInfo.id;
    }

    Dio dio = Dio();
    final formData = {'user_id': customerId, 'user_type': "1", 'device_id': deviceToken};

    var response = await dio.post("${baseURL}view_wallet_bal", data: formData);
    final responseData = json.decode(response.data);
    try {
      if (responseData['status'] == true) {
        var walletAmount = responseData['Amount'];
        int availableTime = (int.parse(walletAmount.toString()) / int.parse(perMinute.toString())).toInt();
        toggleChatAvailableTime(availableTime);
      } else {
        debugPrint('$TAG Error =========> ${responseData["message"]}');
      }
    } catch (e) {
      print('$TAG Error =========> ${e.toString()}');
    }
  }

  getWalletBalance(BuildContext context) async {
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
    final formData = {'user_id': userid, 'user_type': userType, 'device_id': deviceToken};

    var response = await dio.post("${baseURL}view_wallet_bal", data: formData);
    final responseData = json.decode(response.data);
    try {
      if (responseData['status'] == true) {
        walletAmount = responseData['Amount'];
      } else {
        debugPrint('$TAG Error =========> ${responseData["message"]}');
      }
    } catch (e) {
      print('$TAG Error =========> ${e.toString()}');
    }
  }

  Future<void> conversionTypingSubmit(BuildContext context, socket) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');

    var time = DateFormat.jm().format(DateTime.now());
    var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var map = {
      "from_user_id": userid,
      "to_user_id": reseverid,
      "message": typingmessage.text,
      'time': time,
      'message_date': date,
      'message_type': "text",
    };

    if (typingmessage.text != '') {
      socket.emit("message", map);

      chatconversiondata.add({
        'chat_message': map['message'],
        "id": map['from_user_id'],
        "from_user_id": map['from_user_id'],
        "to_user_id": map['to_user_id'],
        "message_time": map['time'],
        'message_date': date,
        'message_type': "text",
      });
      notifyListeners();
    }
    typingmessage.clear();
    notifyListeners();
  }

  ImagePicker imagePicker = ImagePicker();
  XFile? images;
  String? imageName;

  void selectImages(String imageSource, socket) async {
    if (imageSource == 'Gallery') {
      images = await imagePicker.pickImage(source: ImageSource.gallery);
    } else {
      images = await imagePicker.pickImage(source: ImageSource.camera);
    }

    imageName = images!.path.split('/').last;
    socket!.emit('typing', {'user_id': ourSanderid, 'is_type': 1});
    debugPrint("$TAG image =========> ${images!.path}");
    debugPrint("$TAG image Name =========> $imageName");
    notifyListeners();
    if (images != null && images!.path != null) {
      sendImage(socket);
    }
  }

  getWaitList(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userId = pref.getString("login_user_id");

    Dio dio = Dio();
    FormData formData = FormData.fromMap({"astro_id": userId});
    var response = await dio.post("${baseURL}get_waiting_list", data: formData);
    final responseData = json.decode(response.toString());

    debugPrint("$TAG waiting list id responseData =======> $responseData");

    try {
      if (responseData['status']) {
        List<dynamic> dataList = [];
        for (int i = 0; i < responseData['data'].length; i++) {
          dataList.add(responseData['data'][i]);
        }

        if (dataList.length > 0) {
          waitListCountDialog(context, "Currently 0 users are waiting");
        } else {
          waitListCountDialog(context, "Currently ${dataList.length} users are waiting");
        }
        debugPrint('$TAG astrologer wait list count ===========> ${dataList.length}');
        notifyListeners();
      } else {
        notifyListeners();
      }
    } catch (e) {
      notifyListeners();
      debugPrint("$TAG error getWaitCustomersList =======> ${e.toString()}");
    }
  }

  Future<void> sendImage(socket) async {
    // http://134.209.229.112/astrology_new/api/message_image
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');
    Dio dio = Dio();
    Fluttertoast.showToast(msg: "Sending image...");
    FormData formData = FormData.fromMap({
      "from_user_id": ourSanderid,
      "to_user_id": reseverid,
      "message_image": await MultipartFile.fromFile(images!.path, filename: imageName),
    });

    debugPrint("$TAG form data =========> ${formData.fields}");

    var response = await dio.post("${baseURL}message_image", data: formData);
    final responseData = json.decode(response.toString());
    debugPrint("$TAG responseData ======> $responseData");
    try {
      if (responseData["status"]) {
        String imageURL = responseData["data"]["image"];
        socket!.emit('typing', {'user_id': ourSanderid, 'is_type': 1});
        var time = DateFormat.jm().format(DateTime.now());
        var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
        var map = {
          "from_user_id": userid,
          "to_user_id": reseverid,
          "message": imageURL,
          'time': time,
          'message_date': date,
          'message_type': "image",
        };

        if (imageURL != '') {
          socket.emit("message", map);
          Fluttertoast.showToast(msg: "Image sent");
          chatconversiondata.add({
            'chat_message': map['message'],
            "id": map['from_user_id'],
            "from_user_id": map['from_user_id'],
            "to_user_id": map['to_user_id'],
            "message_time": map['time'],
            'message_date': date,
            'message_type': "image",
          });
          notifyListeners();
        }
      } else {
        debugPrint("$TAG image upload failed ======> $responseData");
      }
    } catch (e) {
      debugPrint("$TAG error in image upload ======> ${e.toString()}");
    }
  }
}
