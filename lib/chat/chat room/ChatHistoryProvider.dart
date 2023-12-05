
import 'dart:convert';

import 'package:astrologyapp/common/styles/const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ChatHistoryProvider extends ChangeNotifier {

  String TAG = "ChatHistoryProvider";

  bool isLoading = false;
  List historyList = [];
  //test

  showLoader() {
    isLoading = true;
    notifyListeners();
  }

  hideLoader() {
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadChatHistory(String userId, String opponentId) async {
    showLoader();
    Dio dio = Dio();

    FormData formData = FormData.fromMap({
      "from_user_id": userId,
      "to_user_id": opponentId,
    });
    debugPrint("$TAG load Chat History from_user_id ========> $userId");
    debugPrint("$TAG load Chat History to_user_id ========> $opponentId");
    var response = await dio.post("${baseURL}get_chat_messages", data: formData);
    final responseData = json.decode(response.toString());
    debugPrint("$TAG load Chat History response Data ========> $responseData");
    try {
      if(responseData["status"]) {
        historyList = responseData["data"];
        debugPrint("$TAG load Chat History List ========> $historyList");
        hideLoader();
        debugPrint("$TAG Chat History List Length ========> ${historyList.length}");
        notifyListeners();
        debugPrint("$TAG notifyListeners ========> ");
      } else {
        debugPrint("$TAG error ========> ${responseData["message"]}");
      }
    } catch (e) {
      debugPrint("$TAG error ========> $e");
    }
    hideLoader();
    notifyListeners();
  }
}