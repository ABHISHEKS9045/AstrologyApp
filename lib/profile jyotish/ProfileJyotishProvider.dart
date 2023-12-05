import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/apiErroralertdiloge.dart';
import '../common/styles/const.dart';

class ProfileJyotishProvider extends ChangeNotifier {
  String TAG = "ProfileJyotishProvider";

  bool isLoading = false;
  List<String> weekDay = [];
  List<String> startTime = [];
  List<String> endTime = [];

  List waitListForAstrologer = [];

  showLoader() {
    isLoading = true;
    notifyListeners();
  }

  hideLoader() {
    isLoading = false;
    notifyListeners();
  }

  getAvailability(astrolist) async {
    showLoader();
    notifyListeners();
    try {
      Dio dio = Dio();
      String mainURL = "${baseURL}astro_availability?astro_id=${astrolist["id"]}";

      debugPrint("$TAG get Availability url =======> $mainURL");
      var response = await dio.get(mainURL);
      final responseData = json.decode(response.toString());
      debugPrint("$TAG getAvailability response =======> $responseData");
      if (responseData["status"]) {

        weekDay.clear();
        startTime.clear();
        endTime.clear();

        var data = responseData["data"];
        for (int i = 0; i < data["days"].length; i++) {
          weekDay.add(data["days"][i]);
        }
        for (int i = 0; i < data["start_time"].length; i++) {
          startTime.add(data["start_time"][i]);
        }
        for (int i = 0; i < data["end_time"].length; i++) {
          endTime.add(data["end_time"][i]);
        }
        hideLoader();
        notifyListeners();
      } else {
        hideLoader();
        notifyListeners();
      }
    } catch (e, s) {
      hideLoader();
      notifyListeners();
      debugPrint("$TAG error getAvailability =======> ${e.toString()}");
      debugPrint("$TAG error stack trace getAvailability =======> ${s.toString()}");
    }
  }

  getWaitCustomersList({required BuildContext context, required String type, String? astroId}) async {
    showLoader();
    waitListForAstrologer.clear();

    Dio dio = Dio();
    FormData formData = FormData.fromMap({"astro_id": astroId, "type": type});
    var response = await dio.post("${baseURL}get_waiting_list", data: formData);
    final responseData = json.decode(response.toString());

    debugPrint("$TAG waiting list id responseData =======> $responseData");

    try {
      if (responseData['status']) {
        waitListForAstrologer = responseData['data'];
        debugPrint('$TAG astrologer wait list of users ===========> ${waitListForAstrologer.toString()}');
        hideLoader();
        notifyListeners();
      } else {
        hideLoader();
        notifyListeners();
        var messages = responseData["message"];
        if (context.mounted) {
          apiErrorAlertdialog(context, messages);
        }
      }
    } catch (e) {
      hideLoader();
      notifyListeners();
      debugPrint("$TAG error getWaitCustomersList =======> ${e.toString()}");
    }
  }
}
