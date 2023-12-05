import 'dart:convert';
import 'dart:core';

import 'package:astrologyapp/chat/chatlist/ChatingListpage.dart';
import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/dashboard/dashboardModelPage.dart';
import 'package:astrologyapp/dashboard/dashboardPage.dart';
import 'package:astrologyapp/generate%20kundli/generatekundliPage.dart';
import 'package:astrologyapp/settings/settingPage.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../chat/callList/CallListPage.dart';
import '../styles/const.dart';

class BottomNavbarModelPage extends ChangeNotifier {
  static const String TAG = "BottomNavbarModelPage";

  int _bottombarzindex = 0;

  int get bottombarzindex => _bottombarzindex;

  final List _bottombarScreens = [
    DashboardPage(),
    CallListPage(isCall: true),
    GenerateKundliPage(showBackButton: false),
    const ChatingListPage(isCall: false),
    SettingPage(),
  ];

  List get bottombarScreens => _bottombarScreens;

  updateSelectedIndex(int index) {
    _bottombarzindex = index;
    notifyListeners();
  }

  toggle(BuildContext context, int index) async {
    var dashboardModel = Provider.of<DashboardModelPage>(context, listen: false);
    if (index == 1 || index == 3) {
      if (dashboardModel.isGeustLoggedIn) {
        await geustloginfirst(context);
      } else {
        _bottombarzindex = index;
        notifyListeners();
      }
    } else {
      _bottombarzindex = index;
    }
    notifyListeners();
  }

  togglebottomindexreset() {
    _bottombarzindex = 0;
    notifyListeners();
  }

  updateUserStatus(String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('login_user_id');

    Dio dio = Dio();
    // http://134.209.229.112/astrology_new/api/update_status?id=8&status=Offline
    var response = await dio.get(
      "${baseURL}update_status?id=$id&status=$status",
    );
    final responseData = json.decode(response.toString());

    debugPrint("$TAG Update User Status =======> $responseData");

    try {
      if (responseData['status'] == true) {
        await setUserOnlineFirebase(id, status);
        notifyListeners();
      } else {
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  setUserOnlineFirebase(String? userid, String status) {
    String? userKey = "users_$userid";
    var postData = {"id": userid, "is_busy": 0, "status": status};
    FirebaseDatabase.instance.ref(userKey).set(postData);

    // List<dynamic> userList = [];
    // String? userKey = "";
    // ref.orderByChild('id').equalTo(userid).once().then((DatabaseEvent value) {
    //   if(value.snapshot.children != null) {
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
    //     if(userKey != null && userKey != "" && userid != null && userid != "") {
    //       FirebaseDatabase.instance.ref(userKey).set({
    //         "id": userid,
    //         "is_busy": 0,
    //         "status": status
    //       }).whenComplete(() {
    //         debugPrint("$TAG if user data updated");
    //       }).onError((error, StackTrace stackTrace) {
    //         debugPrint("$TAG if error on update =====> ${error.toString()}");
    //         debugPrint("$TAG if stackTrace on update =====> ${stackTrace.toString()}");
    //         FirebaseCrashlytics.instance.recordError(error, stackTrace);
    //       });
    //     } else {
    //       if(userid != null && userid != "") {
    //         final newPostKey = ref.push().key;
    //         final postData = {"id": userid, "is_busy": 0, "status": status};
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
}
