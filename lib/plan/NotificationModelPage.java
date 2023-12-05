import 'dart:convert';
import 'package:astrologyapp/common/apiErroralertdiloge.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationModelPage extends ChangeNotifier {
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

  List _notificationList = [];
  List get notificationList => _notificationList;

  List _notificationListsignup = [];
  List get notificationListsignup => _notificationListsignup;

  var _signupdate;
  get signupdate => _signupdate;

  var _notificationdate;
  get notificationdate => _notificationdate;

  var _notificationdatestring;
  get notificationdatestring => _notificationdatestring;

  var _notificationdatebool;
  get notificationdatebool => _notificationdatebool;

  getnotificationdate(date) {
    _notificationdatestring = date;
    notifyListeners();
   // print('vinay notificationdatestring1 $notificationdatestring');
  }

  getnotificationsignup() async {
    _signupdate = DateTime.now();

    _notificationdate = DateTime.tryParse(notificationdatestring);
    _notificationdatebool = signupdate.isBefore(notificationdate!);
    notifyListeners();

   // print('signupdate $signupdate');
   // print('_notificationdate $notificationdate');
   // print('notificationdatebool $notificationdatebool');
  }

  Map _signlenotificationmap = {};
  Map get signlenotificationmap => _signlenotificationmap;

  getnotificationsignupafter(value) {
   // print('vinay---- value $value');
    notificationListsignup.add(value);
    _signlenotificationmap = value;
    // _notificationListsignup = value;
    // for (var value in _notificationListsignup) {
    //  // print('vinay set $value');
    //  // print('vinay set $notificationListsignup');
    // }
    // _notificationListsignup.forEach(value);
   // print('vinay set $notificationListsignup');
   // print('vinay map set $signlenotificationmap');
    // _notificationListsignup = value;
    notifyListeners();
    //// print('vinay notification $_notificationListsignup');
  }

  getloopdata() {
    for (var i = 0; i < notificationList.length; i++) {
      _notificationdatestring = notificationList[i]['currents_date'];
   
     // print('vinay notificationdatestring1 $notificationdatestring');

      _signupdate = DateTime.now();
      _notificationdate = DateTime.tryParse(notificationdatestring);
      _notificationdatebool = signupdate.isBefore(notificationdate!);
      notifyListeners();

     // print('signupdate $signupdate');
     // print('notificationdate $notificationdate');
     // print('notificationdatebool $notificationdatebool');

      if (notificationdatebool == false) {
       // print('helllo');
        _notificationListsignup.add(notificationList[i]);
        notifyListeners();
       // print('notificationListsignup $notificationListsignup');
      }
    }
  }

  getclear() {
   // print('vvk dispose');
    _notificationListsignup=[];
    notifyListeners();
   // print('vinay $notificationListsignup');
  }

  notificationlist(context) async {
    toggleshemmerShow();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');
    String? reseverFtoken = prefs.getString('firebase_device_id');

    var useridconvertint =
        userid?.substring(1, userid.length - 1); //shareprefrence se " "46" " ese aa rha tha ise convert se "46 kiya"
    var reseverFtokenInt = reseverFtoken?.substring(
        1, reseverFtoken.length - 1); //shareprefrence se " "46" " ese aa rha tha ise convert se "46 kiya"

    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "user_id": useridconvertint,
      "device_id": reseverFtokenInt,
    });
   // print('perameter ${formData.fields}');
    var response = await dio.post("http://tenspark.com/astrologer/api/view_notfication", data: formData);

    // final responseData = json.decode(response.data);
    final responseData = json.decode(response.toString());
    //map is not a subtype of string error aaye to ye then apply
    //// print('vinayresponse $responseData');
    //// print('vinayresponse11 ${responseData['status']}');

    try {
      if (responseData['status'] == true) {
       // print('true');
        // var iduser = responseData['astro_list'][0]['id'];

        _notificationList = responseData["data"];
       // print('vkglistall $notificationList');
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
       // print('Error: ${responseData["message"]}');
        var messages = responseData["message"];
        apiErrorAlertdialog(context, messages);
      }
    } catch (e) {
      toggleshemmerdismis();
     // print('Error: ${e.toString()}');
    }
  }
}
