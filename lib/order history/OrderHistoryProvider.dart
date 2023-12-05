import 'dart:convert';

import 'package:astrologyapp/common/styles/const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderHistoryProvider extends ChangeNotifier {

  static const String TAG = "OrderHistoryProvider";

  var _lastplanexpiredate;

  get lastplanexpiredate => _lastplanexpiredate;

  bool _myplanstatus = false;

  get myplanstatus => _myplanstatus;

  bool _isShimmer = false;

  bool get isShimmer => _isShimmer;

  toggleShimmerShow() {
    _isShimmer = true;
    notifyListeners();
  }

  toggleShimmerHide() {
    _isShimmer = false;
    notifyListeners();
  }

  getLastplanexpiredate(planenddate) async {
    var currentdate = DateTime.now();
    planenddate = DateTime.tryParse(planenddate);
    _myplanstatus = currentdate.isBefore(planenddate!);
    notifyListeners();
  }

  List _planbuyList = [];

  List get planbuyList => _planbuyList;


  List<dynamic> userOrdersList = [];
  List<dynamic> astrologerOrdersList = [];
  String? userType = "";

  orderHistoryList(context) async {
    toggleShimmerShow();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');

    Dio dio = Dio();
    FormData formData = FormData.fromMap({'user_id': userid});
    debugPrint('vinay add peram ${formData.fields}');
    var response = await dio.post("${baseURL}view_user_buy_plan", data: formData);
    debugPrint('view buy plan response $response');
    final responseData = json.decode(response.toString());

    try {
      if (responseData['status'] == true) {
        _planbuyList = responseData['data'];
        _lastplanexpiredate = responseData['data'].last['plan_end'];
        notifyListeners();
        toggleShimmerHide();
      } else {
        toggleShimmerHide();
        _lastplanexpiredate = '2021-11-22 17:48:29.565722';
        notifyListeners();
      }
    } catch (e) {
      toggleShimmerHide();
    }
  }

  Future<void> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userType = prefs.getString('user_type');
    notifyListeners();
  }

  Future<void> getOrderHistory() async {
    toggleShimmerShow();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');
    try{
      Dio dio = Dio();
      var response = await dio.get("${baseURL}recharge-history?user_id=$userid&user_type=$userType");
      debugPrint('$TAG get order history response =======> $response');
      final responseData = json.decode(response.toString());
      toggleShimmerHide();
      if(responseData["status"]) {
        userOrdersList.clear();
        astrologerOrdersList.clear();
        userOrdersList = responseData["user_data"];
        astrologerOrdersList = responseData["astro_data"];
        notifyListeners();

      } else {
        userOrdersList.clear();
        astrologerOrdersList.clear();
        notifyListeners();
      }
    } catch(e) {
      toggleShimmerHide();
      debugPrint("$TAG get order history error =======> ${e.toString()}");
    } finally {
      toggleShimmerHide();
    }
  }
}
