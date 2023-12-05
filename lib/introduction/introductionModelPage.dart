import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login Page/LoginPage.dart';

class IntroductionModelPage extends ChangeNotifier {
  int _activeIndex = 0;

  int get activeIndex => _activeIndex;

  CarouselController buttonCarouselController = CarouselController();

  List<String> images = [
    'assets/images/intro4.png',
    'assets/images/intro1.png',
    'assets/images/intro3.png',
  ];

  List<String> titleList = [
    "Connect Aastro",
    "Connect Aastro",
    "Connect Aastro",
  ];

  List<String> messageList = [
    "Login and Get first Chat FREE",
    "Connect with Genuine Astrologers",
    "Love, Career, Health, Marriage, etc\nConsult for anything and everything.",
  ];

  updateIndex(int index) {
    _activeIndex = index;
    notifyListeners();
  }

  updateStatusForIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("introDone", true);

    Get.offAll(() => LoginPage());
  }
}
