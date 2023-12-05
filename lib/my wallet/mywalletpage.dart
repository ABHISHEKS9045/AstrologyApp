import 'dart:convert';
import 'dart:io';

import 'package:astrologyapp/common/appbar/appbarcustom.dart';
import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/dashboard/dashboardModelPage.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:astrologyapp/my%20wallet/mywalletwidgetpage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/commonwidgets/button.dart';
import '../common/formtextfield/myTextField.dart';

class MyWalletPage extends StatefulWidget {
  MyWalletPage({Key? key}) : super(key: key);

  @override
  State<MyWalletPage> createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage> {

  static const String TAG = "_MyWalletPageState";


  static const platform = MethodChannel('razorpay_flutter');
  late Razorpay _razorpay;
  var amount;
  double addAmount = 0.00;
  var amt = 0;
  String? userType;
  String? userid;
  TextEditingController controller = TextEditingController();


  @override
  void initState() {
    wallet(context);
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          bgImagecommon(context),
          SafeArea(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  sizedboxheight(5.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: AppBarCustom(
                        title: 'MY WALLET',
                      ),
                    ),
                  ),
                  sizedboxheight(deviceheight(context, 0.04)),
                  Container(
                    padding: const EdgeInsets.all(padding20),
                    width: deviceWidth(context, 1.0),
                    height: deviceheight(context, 0.85),
                    decoration: decorationtoprounded(),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          walletbelenceWidget(context, amount),
                          sizedboxheight(5.0),
                          if (userType == '1') headingContainerWallet(context),
                          sizedboxheight(20.0),
                          if (userType == '1') rechargeboxwidget(context),
                          sizedboxheight(20.0),
                          amt == 0
                              ? Container()
                              : Column(
                                  children: [
                                    rechargePackWidget(context, amt),
                                    sizedboxheight(20.0),
                                    proceedPayBtn(context, openCheckout, amt),
                                  ],
                                ),
                          if(userType == "2") withdrawalRequest(context),



                          sizedboxheight(70.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  submit(String paymentId) async {
    var deviceToken = "deviceToken";
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceToken = androidInfo.id;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('login_user_id');

    Dio dio = Dio();
    final formData = {
      'user_id': userid,
      'payment_method': 'card',
      'payment_status': 'paid',
      'wallet_amount': amt,
      'trancation_id': paymentId,
      'device_id': deviceToken,
    };
    var response = await dio.post("${baseURL}add_wallet_amt", data: formData);
    final responseData = json.decode(response.data);
    try {
      if (responseData['status'] == true) {
        setState(() {
          wallet(context);
        });
      } else {}
    } catch (e) {}
  }

  wallet(BuildContext context) async {
    var deviceToken = "deviceToken";
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceToken = androidInfo.id;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('login_user_id');
    userType = prefs.getString('user_type');

    Dio dio = Dio();
    final formData = {
      'user_id': userid,
      'user_type': userType,
      'device_id': deviceToken,
    };
    var response = await dio.post("${baseURL}view_wallet_bal", data: formData);
    final responseData = json.decode(response.data);
    try {
      if (responseData['status'] == true) {
        setState(() {
          amount = responseData['Amount'];
        });
      } else {}
    } catch (e) {}
  }

  void openCheckout(amt) async {
    var userviewprofile = Provider.of<DashboardModelPage>(context, listen: false);
    userviewprofile.dashboardProfileView(context, false);

    var amt2 = double.parse('$amt');
    addAmount = amt2;
    var options = {
      'key': 'rzp_test_Azd8zKsG8Q1Wow',
      'amount': addAmount * 100,
      'name': userviewprofile.userdataMap['name'],
      'description': 'add to wallet',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': userviewprofile.userdataMap['phone_no'], 'email': userviewprofile.userdataMap['email']},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "Wallet recharge successfully done");
    var paymentid = response.paymentId!;
    submit(paymentid);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // print('aman2${response.code.toString() + response.message!}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // print('aman3${response.walletName!}');
  }

  Widget rechargeboxwidget(BuildContext context) {
    return Container(
      width: deviceWidth(context, 1.0),
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                child: InkWell(
                  splashColor: Colors.grey,
                  onTap: () => {
                    setState(() {
                      amt = 20;
                    }),
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: colorgreyblack.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '₹ 20',
                          style: textstyleHeading3(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Material(
                child: InkWell(
                  splashColor: Colors.grey,
                  onTap: () => {
                    setState(() {
                      amt = 50;
                    }),
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: colorgreyblack.withOpacity(0.2),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '₹ 50',
                        style: textstyleHeading3(context),
                      ),
                    ),
                  ),
                ),
              ),
              Material(
                child: InkWell(
                  splashColor: Colors.grey,
                  onTap: () => {
                    setState(() {
                      amt = 100;
                    }),
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: colorgreyblack.withOpacity(0.2),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '₹ 100',
                        style: textstyleHeading3(context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                child: InkWell(
                  splashColor: Colors.grey,
                  onTap: () => {
                    setState(() {
                      amt = 200;
                    }),
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: colorgreyblack.withOpacity(0.2),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '₹ 200',
                        style: textstyleHeading3(context),
                      ),
                    ),
                  ),
                ),
              ),
              Material(
                child: InkWell(
                  splashColor: Colors.grey,
                  onTap: () => {
                    setState(() {
                      amt = 500;
                    }),
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: colorgreyblack.withOpacity(0.2),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '₹ 500',
                        style: textstyleHeading3(context),
                      ),
                    ),
                  ),
                ),
              ),
              Material(
                child: InkWell(
                  splashColor: Colors.grey,
                  onTap: () => {
                    setState(() {
                      amt = 1000;
                    }),
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: colorgreyblack.withOpacity(0.2),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '₹ 1000',
                        style: textstyleHeading3(context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget withdrawalRequest(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: colorgreyblack.withOpacity(0.2),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sizedboxheight(20.0),
          Text(
            'Withdrawal Request',
            style: textstyletitleHeading6(context),
          ),
          sizedboxheight(20.0),
          AllInputDesign(
            controller: controller,
            hintText: 'amount',
            textInputAction: TextInputAction.done,
            enabledOutlineInputBorderColor: colororangeLight.withOpacity(0.6),
            focusedBorderColor: colororangeLight,
            minLines: 1,
            keyBoardType: const TextInputType.numberWithOptions(decimal: false),
          ),
          sizedboxheight(20.0),
          Button(
            btnWidth: deviceWidth(context, 1.0),
            btnHeight: 45,
            buttonName: 'Submit',
            borderRadius: BorderRadius.circular(15.0),
            btnColor: colororangeLight,
            onPressed: () async {
              if(controller.text.toString().trim().isEmpty) {
                Fluttertoast.showToast(msg: "Please provide amount that you want to withdraw");
              } else if(double.parse(controller.text.toString().trim()) == 0.00) {
                Fluttertoast.showToast(msg: "You can't withdraw ₹ 0 from your wallet");
              } else if(double.parse(controller.text.toString().trim()) > double.parse(amount.toString())) {
                Fluttertoast.showToast(msg: "You don't have sufficient amount to withdraw");
              } else {
                withdrawAmount(context, controller.text.toString().trim());
              }
            },
          ),
          sizedboxheight(20.0),
        ],
      ),

    );
  }

  Future<void> withdrawAmount(BuildContext context, String amount) async {
    try {
      Dio dio = Dio();
      var response = await dio.get("${baseURL}withdrawal?user_id=$userid&amount=$amount");
      final responseData = json.decode(response.data);
      if(responseData["status"]) {
        Fluttertoast.showToast(msg: responseData["message"]);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: responseData["message"]);
      }
    } catch(e) {
      debugPrint("$TAG error in API call =====> ${e.toString()}");
    }
  }

}
