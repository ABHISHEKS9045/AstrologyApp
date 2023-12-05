import 'dart:async';
import 'dart:convert';

import 'package:astrologyapp/common/bottomnavbar/bottomnavbar.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/introduction/introductionPage.dart';
import 'package:astrologyapp/login%20Page/LoginPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  String TAG = "_SplashScreenState";

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {
      print("$TAG instance getInitialMessage =========> ${message?.data}");
      if (message != null) {
        String notificationData = json.encode(message.data);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("notificationData", notificationData);
      }
    });

    getValuesSF();
  }

  getValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    var introDone = prefs.getBool('introDone') ?? false;

    Timer(const Duration(seconds: 3), () {
      if(introDone) {
        if(status) {
          Get.offAll(() => BottomNavBarPage());
        } else {
          Get.offAll(() => LoginPage());
        }
      } else {
        Get.offAll(() => const IntroductionPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: deviceWidth(context, 1.0),
        height: deviceheight(context, 1.0),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/splash_screen.png',
              fit: BoxFit.cover,
              height: deviceheight(context, 1.0),
              width: deviceWidth(context, 1.0),
            ),
          ],
        ),
      ),
    );
  }
}
