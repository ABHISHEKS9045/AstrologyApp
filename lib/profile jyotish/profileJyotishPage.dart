
import 'dart:convert';
import 'dart:io';

import 'package:astrologyapp/common/appbar/chatpageAppbar.dart';
import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:astrologyapp/profile%20jyotish/ProfileJyotishProvider.dart';
import 'package:astrologyapp/profile%20jyotish/profileJyotishWigetPage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../common/shimmereffect.dart';

class ProfileJyotishPage extends StatefulWidget {

  final astrolist;
  final bool isFree;
  final int freeTime;

  const ProfileJyotishPage({Key? key, this.astrolist, required this.isFree, required this.freeTime}) : super(key: key);


  @override
  State<ProfileJyotishPage> createState() => _ProfileJyotishPageState();
}

class _ProfileJyotishPageState extends State<ProfileJyotishPage> {
  String TAG = "_ProfileJyotishPageState";

  var amount;
  List? reviewdata;

  DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
  var listner;

  List waitListForAstrologer = [];


  Future<void> getFirebaseDatabaseValue(astrolist) async {
    List<dynamic> firebaseData = List.from([]);
    listner = databaseRef.onValue.listen((DatabaseEvent event) {
      var snapshot = event.snapshot;
      debugPrint("$TAG snapshot ======> $snapshot");
      if (snapshot.exists) {
        firebaseData.clear();
        snapshot.children.forEach((DataSnapshot element) {
          firebaseData.add(element.value);
        });
        debugPrint("$TAG firebaseData =======> $firebaseData");
        setState(() {
          for (int i = 0; i < firebaseData.length; i++) {
            if(firebaseData[i]["id"] != null && firebaseData[i]["id"].toString() != 'null' && firebaseData[i]["id"].toString() != "") {
              int id = int.parse(firebaseData[i]["id"].toString());
              if (int.parse(astrolist["id"].toString()) == id) {
                astrolist["is_busy"] = firebaseData[i]["is_busy"];
              }
            }
          }
        });
      } else {
        debugPrint('$TAG <======== On Value No data available ========>');
      }
    });
  }

  @override
  void initState() {
    debugPrint("$TAG init state astro list =====> ${widget.astrolist}");
    getFirebaseDatabaseValue(widget.astrolist);
    reviewlist(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var model = Provider.of<ProfileJyotishProvider>(context, listen: false);
      model.getWaitCustomersList(context: context, type: "", astroId: widget.astrolist['id'].toString());
      model.getAvailability(widget.astrolist);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    listner.cancel();
  }

  progressDialogue(BuildContext context) {
    AlertDialog alert = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  wallet() async {
    var deviceToken = "deviceToken";
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceToken = androidInfo.id;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('login_user_id');
    var userType = prefs.getString('user_type');
    Dio dio = Dio();
    final formData = {'user_id': userid.toString(), 'user_type': userType, 'device_id': deviceToken};

    var response = await dio.post("${baseURL}view_wallet_bal", data: formData);
    final responseData = json.decode(response.data);
    try {
      if (responseData['status'] == true) {
        setState(() {
          amount = responseData['Amount'];
        });
      } else {}
    } catch (e) {
      debugPrint("$TAG error get wallet =======> ${e.toString()}");
    }
  }

  reviewlist(context) async {
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      'astro_id': widget.astrolist['id'].toString(),
    });
    var response = await dio.post("${baseURL}astro_review_list", data: formData);
    final responseData = json.decode(response.toString());
    debugPrint("$TAG review list response ========> $response");

    if (responseData['status'] == true) {
      setState(() {
        reviewdata = responseData['review'];
      });
      Future.delayed(const Duration(seconds: 2));
    } else {
      // print(responseData['message']);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileJyotishProvider>(builder: (context, model, child) {
      return Scaffold(
        body: model.isLoading ? Container(
          margin: EdgeInsets.only(top: 20.h),
          child: loadingwidget(),
        ) : Stack(
          children: [
            bgImagecommon(context),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    sizedboxheight(20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: appbarbackbtnnotification(context, "PROFILE"),
                    ),
                    sizedboxheight(40.0),
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: deviceWidth(context, 1.0),
                      height: deviceheight(context, 0.82),
                      decoration: decorationtoprounded(),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 1.h),
                            headerJyotish(context, widget.astrolist, widget.isFree),
                            sizedboxheight(10.0),
                            chatTalkWidget(context, widget.astrolist, model, widget.isFree, widget.freeTime),
                            aboutMeWidget(context, widget.astrolist),
                            availabilityWidget(context, model),
                            expertiseWidget(context, widget.astrolist),
                            eductionWidget(context, widget.astrolist),
                            SizedBox(height: 1.h),
                            SizedBox(height: 2.h),
                            overallRatingWidget(context, widget.astrolist["count_rating"], widget.astrolist['user_rating'] == null ? "0.0" : parseDouble2Digit(widget.astrolist['user_rating'].toString())),
                            sizedboxheight(10.0),
                            commentWidget(context, reviewdata)
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
    },);
  }
}
