import 'dart:convert';

import 'package:astrologyapp/dashboard/dashboardModelPage.dart';
import 'package:astrologyapp/order%20history/OrderHistoryProvider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/styles/const.dart';

class PlanModelPage extends ChangeNotifier {
  bool _lastplanActivated = false;

  bool get lastplanActivated => _lastplanActivated;

  var _planstartdate;

  get planstartdate => _planstartdate;

  var _planEnddate;

  get planEnddate => _planEnddate;

  getplanEndDate(context, int enddays) {
    _planstartdate = DateTime.now();
    _planEnddate = planstartdate.add(Duration(days: enddays));
    notifyListeners();
  }

  getLastplanexpiredate(context) async {
    Future.delayed(Duration(milliseconds: 500));
    toggleLoadingShow();
    final ordermodel = Provider.of<OrderHistoryProvider>(context, listen: false);
    await ordermodel.orderHistoryList(context);
    toggleLoadingdismis();
    var lastplanexpiredate = DateTime.tryParse(ordermodel.lastplanexpiredate);
    var currentdate = DateTime.now();
    _lastplanActivated = currentdate.isBefore(lastplanexpiredate!);
    notifyListeners();
  }

  bool _color1 = false;

  bool get color1 => _color1;

  String? _planamount;

  String? get planamount => _planamount;

  String? _selectplanname = '';

  String? get selectplanname => _selectplanname;

  mostpopularplan(context) {
    _color2 = false;
    _color3 = false;
    _color1 = !_color1;
    _color1 ? _planamount = planListdata['plan_free_amount'].toString() : _planamount = '';
    _color1 ? _selectplanname = planListdata['plan_free_name'].toString() : _selectplanname = '';
    _color1 ? getplanEndDate(context, 7) : getplanEndDate(context, 0);
    notifyListeners();
  }

  bool _color2 = false;

  bool get color2 => _color2;

  monthlyplan(context) {
    _color1 = false;
    _color3 = false;
    _color2 = !_color2;
    _color2 ? _planamount = planListdata['plan_monthly_amount'].toString() : _planamount = '';
    _color2 ? _selectplanname = planListdata['plan_monthly'].toString() : _selectplanname = '';
    _color2 ? getplanEndDate(context, 30) : getplanEndDate(context, 0);
    notifyListeners();
  }

  bool _color3 = false;

  bool get color3 => _color3;

  yearlyplan(context) {
    _color1 = false;
    _color2 = false;
    _color3 = !_color3;
    _color3 ? _planamount = planListdata['plan_yearly_amt'].toString() : _planamount = '';
    _color3 ? _selectplanname = planListdata['plan_yearly'].toString() : _selectplanname = '';
    _color3 ? getplanEndDate(context, 365) : getplanEndDate(context, 0);
    notifyListeners();
  }

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

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  toggleLoadingShow() {
    _isLoading = true;
    notifyListeners();
  }

  toggleLoadingdismis() {
    _isLoading = false;
    notifyListeners();
  }

  List _userdataList = [];

  List get userdataList => _userdataList;

  Map _planListdata = {};

  get planListdata => _planListdata;

  viewplan(context) async {
    toggleshemmerShow();

    Dio dio = Dio();

    var response = await dio.post(
      baseURL + "view_plan",
    );

    // final responseData = json.decode(response.data);
    final responseData = json.decode(response.toString());
    //map is not a subtype of string error aaye to ye then apply

    try {
      if (responseData['status'] == true) {
        _userdataList = responseData["data"];
        // print('user profie data $_userdataList');
        // print('user profie data ${_userdataList[0]['plan_monthly']}');
        _planListdata = _userdataList[0];
        // print('planlist $planListdata');
        notifyListeners();
        toggleshemmerdismis();
      } else {
        toggleshemmerdismis();
        // print('Error: ${responseData["message"]}');
      }
    } catch (e) {
      toggleshemmerdismis();
      // print('Error: ${e.toString()}');
    }
  }

  addplan(paymentid) async {
    toggleshemmerShow();
    await Future.delayed(Duration(seconds: 1));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');
    // var useridconvertint = userid?.substring(1, userid.length - 1);

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      'user_id': userid,
      'plan_name': selectplanname,
      'plan_start': DateTime.now(),
      'plan_end': planEnddate,
      'plan_sdate': planstartdate,
      'plan_id': '1',
      'transcation_id': paymentid,
      'payment_method': 'online',
      'payment_status': 'success',
      'status': '1',
    });
    // print('vinay add peram ${formData.fields}');
    var response = await dio.post(baseURL + "buy_plan", data: formData);

    // final responseData = json.decode(response.data);
    final responseData = json.decode(response.toString());
    // print('add plan response $responseData');
    //map is not a subtype of string error aaye to ye then apply

    try {
      if (responseData['status'] == 'true') {
        // print('helllo');

        // _planEnddate = '';
        // _planamount = '';
        _planstartdate = '';
        _selectplanname = '';
        notifyListeners();
        toggleshemmerdismis();
        Fluttertoast.showToast(msg: 'Plan Add Successfully');
      } else {
        toggleshemmerdismis();
        // print('Error: ${responseData["message"]}');
      }
    } catch (e) {
      toggleshemmerdismis();
      // print('Error: ${e.toString()}');
    }
  }

  late Razorpay razorpay;
  var paymentid;

  void openCheckout(context, amt) async {
    toggleLoadingShow();
    Future.delayed(Duration(seconds: 2));
    var userviewprofile = Provider.of<DashboardModelPage>(context, listen: false);
    userviewprofile.dashboardProfileView(context, false);
    // print('profile wallat view init ${userviewprofile.userdataMap}');

    var amt2 = double.parse('$amt');
    var addamount = amt2;
    // print('$addamount');
    var options = {
      'key': 'rzp_test_Azd8zKsG8Q1Wow',
      'amount': addamount * 100,
      'name': userviewprofile.userdataMap['name'],
      'description': 'Subscription Plan',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': userviewprofile.userdataMap['phone_no'], 'email': userviewprofile.userdataMap['email']},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorpay.open(options);
      toggleLoadingdismis();
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    // print('aman1........$response');
    Fluttertoast.showToast(
        // msg: "SUCCESS: " + response.paymentId!,
        msg: "Transection Successfull",
        toastLength: Toast.LENGTH_SHORT);
    paymentid = response.paymentId!;
    // submit(paymentid);
    addplan(paymentid);

    // print('vinay signature ${response.signature}');
    // print('vinay paymentid $paymentid');
  }

  void handlePaymentError(PaymentFailureResponse response) {
    // print('aman2${response.code.toString() + response.message!}');
    Fluttertoast.showToast(msg: 'Transection Unsuccessful');
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    // print('vinay wallatname${response.walletName!}');
  }
}
