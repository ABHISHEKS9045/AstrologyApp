import 'dart:convert';
import 'package:astrologyapp/common/apiErroralertdiloge.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/styles/const.dart';

class NotificationModelPage extends ChangeNotifier {

  String TAG = "NotificationModelPage";

  bool _isShimmer = false;
  bool get isShimmer => _isShimmer;

  toggleShimmerShow() {
    _isShimmer = true;
    notifyListeners();
  }

  toggleShimmerDismiss() {
    _isShimmer = false;
    notifyListeners();
  }

  List notificationList = [];

  getNotificationList(BuildContext context, String type) async {
    toggleShimmerShow();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "user_id": userid,
      "type": type,
    });
    var response = await dio.post("${baseURL}view_notfication", data: formData);
    final responseData = json.decode(response.toString());
    debugPrint("$TAG responseData ========> $responseData");
    try {
      if (responseData['status'] == true) {
        notificationList.clear();
        notificationList = responseData["data"];
        toggleShimmerDismiss();
        notifyListeners();
      } else {
        toggleShimmerDismiss();
        var messages = responseData["message"];
        if(context.mounted) {
          apiErrorAlertdialog(context, messages);
        }
      }
    } catch (e) {
      toggleShimmerDismiss();
      debugPrint('$TAG Error getNotificationList =======> ${e.toString()}');
    }
  }
}