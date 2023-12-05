import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

// Astrologer API key
String astroAPIUserId = '625781';
String astroApiKey = '1f9ea6a8bdb3a6b7af57612f22d89387';
String razorpayMerchantKey = "rzp_test_Azd8zKsG8Q1Wow";
String razorpayTestId = "rzp_test_vhoPCyzTQmt7Xl";
// 625781/1f9ea6a8bdb3a6b7af57612f22d89387


var encodedKey = base64.encode(utf8.encode('$astroAPIUserId:$astroApiKey'));
// String baseURL = 'http://134.209.229.112/astrology_new/api/';
String baseURL = 'https://connectaastro.com/api/';
String socketURL = 'http://137.184.125.101:8090';

String folderURL = 'https://connectaastro.com/';
String imageURL = "https://connectaastro.com/images/profile_image/";

Color colorWhite = Colors.white;
Color colorblack = Colors.black;
Color colororangeLight = HexColor("#F9921F");
int COLOR_PRIMARY = 0xFFF9921F;
// Color colororangeLight = HexColor("#FD6A35");
Color colorgreyblack = HexColor("#2E2526");
Color colorsanderchat = HexColor("#F3F8FF");
Color coloryourchat = HexColor("#FD7235");
Color colorcrema = HexColor("#FFF5EB");



Color whiteColor = Colors.white;
// Color themeColor = Color(0xFF504F4F);

const double fontsizeheading25 = 24.0;
const double fontsizeheading22 = 12.0;
const double fontsize18 = 16.0;
const double fontsize15 = 14.0;
const double fontsize12 = 11.0;

const double padding20 = 20.0;
const double padding10 = 10.0;
const double padding8 = 8.0;
const double padding5 = 5.0;

FontWeight fontWeight600 = FontWeight.w600;
FontWeight fontWeight700 = FontWeight.w700;
FontWeight fontWeight900 = FontWeight.bold;
FontWeight fontWeight400 = FontWeight.w400;
FontWeight fontWeight500 = FontWeight.w500;
FontWeight fontWeightnormal = FontWeight.normal;

TextStyle labelHintFontStyle = const TextStyle(
  color: Colors.black87,
  fontSize: 14.5,
  fontWeight: FontWeight.w600,
  // fontFamily: pCommonRegularFont,
);

TextStyle? textstyleHeading1(context) {
  return Theme.of(context).textTheme.displayLarge;
}

TextStyle? textstyleHeading2(context) {
  return Theme.of(context).textTheme.displayMedium;
}

TextStyle? textstyleHeading3(context) {
  return Theme.of(context).textTheme.displaySmall;
}

TextStyle? textstyletitleHeading6(context) {
  return Theme.of(context).textTheme.titleLarge;
}

TextStyle? textstylesubtitle2(context) {
  return Theme.of(context).textTheme.titleSmall;
}

TextStyle? textstylesubtitle1(context) {
  return Theme.of(context).textTheme.titleMedium;
}

double deviceWidth(context, size) {
  return MediaQuery.of(context).size.width * size;
}

double deviceheight(context, size) {
  return MediaQuery.of(context).size.height * size;
}

BoxBorder borderCustom() {
  return Border.all(color: colorgreyblack.withOpacity(0.2));
}

Widget sizedboxheight(height) {
  return SizedBox(
    height: height,
  );
}

Widget sizedboxwidth(width) {
  return SizedBox(
    width: width,
  );
}

Widget dividerCustom(double? height, double? thickness, double? indent, double? endIndent) {
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(50),
      ),
    ),
    child: Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      // color: HexColor('#A29EB5').withOpacity(0.2),
      color: Colors.black12,
    ),
  );
}

Widget dividerVertical() {
  return Container(
    width: 1,
    height: double.maxFinite,
    color: Colors.black12,
  );
}

Widget dividerHorizontal() {
  return Container(
    width: double.maxFinite,
    height: 1,
    color: Colors.black12,
  );
}

mediaText(context) {
  return MediaQuery.of(context).copyWith(textScaleFactor: 0.9);
}

TextButton TestBtn(onPressed) {
  return TextButton(onPressed: onPressed, child: const Text('Test'));
}

// comment by nilesh added to calculate time difference on 27-04-2023
bool checkTimeDifference(int time) {
  int currentTime = DateTime.now().millisecondsSinceEpoch;
  int finalTime = currentTime - time;
  int diff = Duration(milliseconds: finalTime).inSeconds;
  debugPrint("main notification customer side current time ========> $currentTime");
  debugPrint("main notification customer side notification time ========> $time");
  debugPrint("main notification customer side final time ========> $finalTime");
  debugPrint("main notification customer side time diff ========> $diff");
  if (diff > 60) {
    return false;
  } else {
    return true;
  }
}

String parseDouble2Digit(String data) {
  return double.parse(data).toStringAsFixed(2);
}

String formatDate(String dateToFormat) {
  if(dateToFormat != null && dateToFormat != "null" && dateToFormat != "") {
    DateTime dateTime = DateFormat.Hms().parse(dateToFormat);
    debugPrint("date Time ========> ${dateTime.toString()}");
    String formattedDate = DateFormat("hh:mm a").format(dateTime);
    debugPrint("formatted Date =========> $formattedDate");
    return formattedDate;
  } else {
    return "00";
  }
}

String formatDate2(String dateToFormat) {
  if(dateToFormat != null && dateToFormat != "null" && dateToFormat != "") {
    DateTime dateTime = DateTime.parse(dateToFormat);
    debugPrint("date Time ========> ${dateTime.toString()}");
    String formattedDate = DateFormat("dd-MM-yyyy hh:mm a").format(dateTime);
    debugPrint("formatted Date =========> $formattedDate");
    return formattedDate;
  } else {
    return "00";
  }
}

String formatNotificationDate(String dateToFormat) {
  if(dateToFormat != null && dateToFormat != "null" && dateToFormat != "") {
    DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateToFormat);
    debugPrint("date Time ========> ${dateTime.toString()}");
    String formattedDate = DateFormat("dd-MM-yyyy hh:mm a").format(dateTime);
    debugPrint("formatted Date =========> $formattedDate");
    return formattedDate;
  } else {
    return "";
  }
}






const String sighDescription =
    'Ascendant is one of the most sought concepts in astrology when it comes to predicting the minute events in your life. At the time of birth, the sign that rises in the sky is the persons ascendant. It helps in making predictions about the minute events, unlike your Moon or Sun sign that help in making weekly, monthly or yearly predictions for you.Your ascendant is Aries';
const String signPersonality =
    'Those born with the Aries sign are brave, assertive, independent, demanding, combative, and quick-tempered. They have a clear, opinionated, and independent mindset. Aries ascendant individuals are associated with good management skills and have a strong command over others. Though they are often free-spirited, they are also giving and kind by nature. When it comes to spending cash, they are somewhat liberal. They like sports plus an exciting lifestyle. In their perspective, a diligent worker is always inventive, realistic, and sensible. They have a habit of acting without thinking, which makes them face immense difficulties in life. They are susceptible to change in terms of fortune and are religious to varying degrees. People born with Aries rising sign might face a difficult time dealing with home affairs. However, they excel in the areas of swift action, decision-making, and leadership roles.';
const String signHealth =
    'Aries people are powerful and resilient, yet they are hardly immune to injuries, accidents, or surgical incisions. As a result, people born under the rising sign of Aries should avoid risky driving and extreme activities. It is likely that their head and face might get harmed. Injury, accidents, surgery, burns, mild fever, colitis, rashes, and small poxes are common among people born under the sign of Aries. Insomnia, as well as paralysis, is the other two symptoms as well';
const String signCareer =
    "A career defending actual wars, like in the army, as firefighters, or as an officer, will be ideal for Aries rising people. A profession in athletics would also be rewarding for them. They can also channel their combative spirit into jobs that need them to face risk and succeed but aren't as deadly. Many financial occupations, like stock market occupations or real estate enterprises, including a level of risk that necessitates fortitude and the capability to succeed in the midst of difficulty, are best for Aries ascendant natives. They need a method to feel powerful and a steady stream of possibilities to appear like a conqueror, at the absolute minimum. Even if it's just a never-ending flow of problems to address, they'll have enough opportunities to strive and win.";
const String signRship =
    "The person born under the sign of Aries enjoys romantic adventures. Due to their attractive appearance, they effortlessly captivate the opposite sex. When it comes to switching to marriage, they are quite realistic and practical. Aries natives always want to be in a long-term relationship and adore their partner in all ways. The basic nature of them is to have experiences in love. In regards to love and relationships, Aries ought to be faithful. They practice calmness and refrain from showing emotions easily even to their loved ones. The Aries husband is fortunate to have found a lovely and bright wife, while the females attract sensual and passionate husbands.";
const String signSunConsi =
    "The planet Sun is in your seventh house which is ruled by Libra. The conjunction results in the person having trouble with family. The relationship with the spouse and children is also to remain sour. You may have a tendency to earn more and more in life and for the same you may indulge in both fair and unfair means.";
const String signmoonConsi =
    'The planet Moon is camping the sixth house of your natal chart, which is ruled by the Virgo sign. With this conjunction, you may lack motherly affection in your life. However, you will get help from your maternal grandfather who would be very supportive of you. You may also have to work harder to establish a good bond with the other members of the family.';
const String signMercuryConsi =
    "The planet Mercury is in the eighth house of your natal chart. The eighth house is ruled by the Scorpio sign. The combination makes you very worried about your daily routine. You tend to plan your day but often fail to execute the plan. This could become a reason for your strained finances in the future. You must take advice on this issue from someone who is not family. You have a blessing of long life and heightened sexual desires.";
const String signVenusConsi =
    "The planet Venus in the eighth house of your Kundli, as we can see. The eighth house is ruled by the Scorpio sign. Venus is the planet of romance and is very favourable for you in terms of sexual romance. You are to feel a heightened craving for sexual conduct across all ages of life. This will enhance the relationship that you share with your spouse.";
const String signMarsConsi =
    "The planet Mars is in the fifth house of your Kundli, which is ruled by the Leo sign. The combination results in you being a very ambitious person. However, yet you may have to put extra than regular attention to achieve what you wish to. The planet Mars also makes you very rash yet wise in your approach. You may not share the greatest relationship with your children.";
const String signJupiterConsi =
    "Jupiter is placed in the eleventh house of your natal chart, which is ruled by the Aquarius sign. The placement is auspicious as you are to get help from your destiny. You will enjoy the support of your cousins. You all together can become good business partners too. Even if you are working all by yourself, you are to find success in the same.";
const String signsaturnConsi =
    "The planet Saturn is in the 1st house of your Kundli. The 1st house is ruled by the Aries sign. The presence of Saturn in 1st house makes you prone to skin disorders due to which you might struggle to look your best physically. However, don't let that affect your confidence.";
const String signRahuConsi =
    "The celestial object Rahu (Dragon’s head) is in the 5th house of your Kundli. This house is governed by the Leo sign. Due to the presence of Rahu in this house, you may be faced with certain obstacles in acquiring good education. There also slight chances that you may be disappointed by your children and receive some unhappiness from them.";
const String signKetuConsi =
    "The planet Ketu is in the 11th house of your Kundli. The 11th house is ruled by the Aquarius sign. The placement of Ketu in this house will prove to be a sign of good tidings for you in the near future. You are sure to gain heavily in the coming time. Yet, this success will not make you be in vain, instead it will motivate you to work harder to acquire even more success. ";
const String signLakshmiYoga =
    "Lord of Lagna is powerful and the Lord of the ninth occupies its own or exaltation sign identical with a Kendra or Thrikona.Lakshmi Yoga indicates that you will be the owner of tremendous wealth and fortune. You are a learned person and you are incredibly noble by nature. You are known for your integrity which you take very seriously. This builds quite a reputation around you. In terms of your appearance, you are alluring. You make a good leader and will be able to rule over people and make a positive impact. You will enjoy all the pleasures and comforts of life as well.";
const String signKemadrumaYoga =
    "No planets on both side of the Moon.Kemadruma Yoga indicates that you might be an individual who is associated with sorrow and unrighteous deeds. You will likely be considered dirty in a practical sense and people might try to stay away from you in the fear of being scammed or hurt in some way. Your indulgence in unfair deeds will push you towards poverty which will also lead to your dependency on others to make a living. In terms of your personality, you are likely to be considered a rogue and a swindler.";
const String signSakataYoga =
    "Moon in 12th, 6th or 8th house from Jupiter. Sakata Yoga indicates that once you lose your fortune and then you tend to retrieve it. In the matter of identity, you are ordinary and insignificant. Furthermore, you will be suffering from lot of things such as poverty, privation and misery. Also, you are more likely to be pretty stubborn and your relatives mostly hate you.";
const String signVesiYoga =
    "Planets other than Moon occupy 2nd position from Sun.The Vesi Yoga points out at some interesting features in a person. You tend to be extremely fortunate as things always fall in your lap easily and are not liable to any misfortunes. Further, you are known to be very happy and also, try to make everyone around you happy. Considering your personality, you tend to be virtuous and ethical. This means that you don't encourage disbelieving and are true to your morals. Over your life span, you will be exceptionally famous and aristocratic.";
const String VenusMahadasha =
    "The planet Venus is in the twelfth house of the Kundli. During this Dasha period, there would be immense bliss in your life but with a tinge of downsides. On one side, you will do great in accumulating wealth, while on the other side, expenses would come with it too. As the Dasha time passes, you shall enjoy sexual relationships in your life. Not just this, you would also be involved in short and long trips and enjoy a pleasant time. However, with Venus in the twelfth house in the Dasha period, you might see issues in the mother's health. Also, there could be some mental distractions, which you need to be vary off.";
const String moonMahadasha =
    "The planet Moon is in the fourth house of the Kundli. During this Dasha period, you may get overly indulged in sexualities and physical relationships. Though you would get good friends yet may feel a bit dissatisfied with your company. You shall earn from the lands you possess and also purchase some new. As the Dasha time passes, you would involve yourself in benevolent and ethical deeds. In addition to this, you might also possess a new house, land, and carriages. With increased name and fame, you would attain success in publishing works and research. However, with Moon in the fourth house in the Dasha period, you may have to put extra effort into taking care of your mother's health.";
const String sumMahadash = "The planet Sun is in the tenth house of the Kundli. During this Dasha period, commending possibilities shall be in your way. Be it the accumulation of wealth or success and promotion in business, you would be earning several auspices during this time. ";

// final String signJupiterConsi ="";

RxList Mychatlistdata = [].obs;
var timerboolValue = false;

var Mychatmapdata = <Map<String, dynamic>>[].obs;
