
import 'dart:convert';

import 'package:astrologyapp/common/apiErroralertdiloge.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/styles/const.dart';

class FreeConsultationProvider extends ChangeNotifier {
  String TAG = "FreeConsultationProvider";

  bool _isShimmer = false;

  bool get isShimmer => _isShimmer;

  List astrologerListdb = [];

  toggleshemmerShow() {
    _isShimmer = true;
    notifyListeners();
  }

  toggleshemmerdismis() {
    _isShimmer = false;
    notifyListeners();
  }

  chatUserList(BuildContext context) async {
    toggleshemmerShow();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');
    String? usertype = prefs.getString('user_type');

    Dio dio = Dio();

    String url = "${baseURL}free_astrologer_list?user_id=$userid&user_type=$usertype&limit=50&offset=0&user_status=Online";
    debugPrint("$TAG User List URL =======> $url");
    var response = await dio.get(url);
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
        astrologerListdb.clear();
        var messages = responseData["message"];
        if (context.mounted) {
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
}
