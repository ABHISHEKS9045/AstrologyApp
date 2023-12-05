
import 'dart:convert';

import 'package:astrologyapp/common/bottomnavbar/bottomnavbarModelPage.dart';
import 'package:astrologyapp/common/commonwidgets/toast.dart';
import 'package:astrologyapp/dashboard/dashboardModelPage.dart';
import 'package:astrologyapp/login%20Page/LoginPage.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/Material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/styles/const.dart';

class LoginController extends GetxController {
  String TAG = "LoginController";

  deviceLogout(String userid) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? userid = prefs.getString('login_user_id');
    // print("==============>userid $userid");

    Dio dio = Dio();
    FormData formData = FormData.fromMap({"user_id": userid});
    var response = await dio.post("${baseURL}logoutUpdate", data: formData);

    final responseData = json.decode(response.toString());
    print("responseData=========>$responseData");
    try {
      if (responseData['status'] == true) {
      } else {}
    } catch (e, s) {
      debugPrint("$TAG device id logout api error =======> ${e.toString()}");
      debugPrint("$TAG device id logout api stack trace =======> ${s.toString()}");
    }
  }

  // changed by nilesh on 17-05-2023
  logout(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('login_user_id');
    debugPrint("$TAG userId ========> $userId");
    if(userId != null && userId != "000" && userId != "0") {
      await setUserOfflineFirebase();

    }
    await prefs.clear();
    await prefs.setBool("introDone", true);
    // await Future.delayed(const Duration(seconds: 1));

    final bottompagemodel = Provider.of<BottomNavbarModelPage>(context, listen: false);
    bottompagemodel.togglebottomindexreset();

    final dbmodel = Provider.of<DashboardModelPage>(context, listen: false);
    await dbmodel.geustloginfalse();
    await dbmodel.userdatareset();

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return LoginPage();
      },
    ), (route) => false);
  }

  // update firebase login status of user added by nilesh on 17-05-2023
  // start
  Future<void> setUserOfflineFirebase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');

    String? userKey = "users_$userid";
    var postData = {"id": userid, "is_busy": 0, "status": "Offline"};
    FirebaseDatabase.instance.ref(userKey).set(postData);
    deviceLogout(userid.toString());


    // ref.orderByChild('id').equalTo(userid).once().then((DatabaseEvent value) {
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
    //     if (userKey != null && userKey != "" && userid != null && userid != "") {
    //
    //       FirebaseDatabase.instance.ref("user_id_60").set({"id": userid, "is_busy": 0, "status": "Offline"});
    //
    //       FirebaseDatabase.instance.ref(userKey).set({"id": userid, "is_busy": 0, "status": "Offline"}).whenComplete(() {
    //         debugPrint("$TAG if user data updated");
    //       }).onError((error, StackTrace stackTrace) {
    //         debugPrint("$TAG if error on update =====> ${error.toString()}");
    //         debugPrint("$TAG if stackTrace on update =====> ${stackTrace.toString()}");
    //         FirebaseCrashlytics.instance.recordError(error, stackTrace);
    //       });
    //     } else {
    //       if(userid != null && userid != "") {
    //         final newPostKey = ref.push().key;
    //         final postData = {"id": userid, "is_busy": 0, "status": "Offline"};
    //         final Map<String, Map> updates = {};
    //         updates['$newPostKey'] = postData;
    //
    //         ref.child("user_id_60").set(postData);
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
}