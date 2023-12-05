import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' hide FormData;
import 'package:shared_preferences/shared_preferences.dart';

import '../common/styles/const.dart';

class SupportProvider extends ChangeNotifier {
  static const String TAG = "SupportProvider";

  List<String> queryTypeList = ['Have an issue with a transaction?', 'Have an issue with a recharge?', 'Other'];

  List<dynamic> ticketList = [];

  bool isLoading = false;

  String type = "";

  TextEditingController controller = TextEditingController();

  var refundQueryData;

  void showLoading() {
    isLoading = true;
    notifyListeners();
  }

  void hideLoading() {
    isLoading = false;
    notifyListeners();
  }

  void updateSelectedType(String queryType) {
    type = queryType;
    notifyListeners();
  }


  Future<void> loadSupportQueries(bool showL) async {
    if(showL) {
      showLoading();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('login_user_id');

    Dio dio = Dio();
    try {
      var response = await dio.get("${baseURL}user-queries?user_id=$userId");
      debugPrint("$TAG Load Support Queries response =========> $response");
      final responseData = json.decode(response.toString());
      hideLoading();
      if (responseData["status"]) {
        ticketList = responseData["data"];
        debugPrint("$TAG Load Support Queries success =========> $response");
      } else {
        debugPrint("$TAG Load Support Queries failed =========> $response");
      }
    } catch (e) {
      hideLoading();
      debugPrint("$TAG error =======> ${e.toString()}");
    }
  }

  Future<void> sendQueryToServer(BuildContext context, String type, String message, String queryType, String? requestId, String? amount) async {
    showLoading();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('login_user_id');

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "user_id": userId, // user id that want to raise query
      "type": type, // query type
      "query_type": queryType, // chat, call, query
      "text_query": message, // query message
      "query_id": requestId, // if exist provide request id
      "amount": amount, // if exist provide amount
    });

    // http://134.209.229.112/astrology_new/api/submitquery
    try {
      debugPrint("$TAG send Query To Server formData =========> ${formData.fields}");
      var response = await dio.post("${baseURL}submitquery", data: formData);
      debugPrint("$TAG send Query To Server response =========> $response");
      final responseData = json.decode(response.toString());
      hideLoading();
      if (responseData["status"]) {
        controller.clear();
        Fluttertoast.showToast(msg: responseData["message"]);
        loadSupportQueries(false);
        Get.back();
        debugPrint("$TAG send Query To Server success response =========> $response");
      } else {
        debugPrint("$TAG send Query To Server failed response =========> $response");
      }
    } catch (e) {
      hideLoading();
      debugPrint("$TAG error =======> ${e.toString()}");
    }
  }

  Future<void> getRequestDetails(String type, String requestId) async {
    showLoading();
    debugPrint("$TAG getRequestDetails type ========> $type");
    debugPrint("$TAG getRequestDetails id ========> $requestId");
    // http://134.209.229.112/astrology_new/api/query?type=chat&id=4
    Dio dio = Dio();
    try {
      var response = await dio.get("${baseURL}query?type=$type&id=$requestId");
      debugPrint("$TAG send Query To Server response =========> $response");
      final responseData = json.decode(response.toString());
      hideLoading();
      if (responseData["status"]) {
        refundQueryData = responseData["data"];
        debugPrint("$TAG get Request Details success response =========> $response");
      } else {
        debugPrint("$TAG get Request Details failed response =========> $response");
      }
    } catch (e) {
      hideLoading();
      debugPrint("$TAG error =======> ${e.toString()}");
    }
  }
}
