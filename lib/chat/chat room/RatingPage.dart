import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' hide FormData;
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/bottomnavbar/bottomnavbar.dart';
import '../../common/commonwidgets/commonWidget.dart';
import '../../common/styles/const.dart';
import '../../login Page/loginpageWidget.dart';

class RatingPage extends StatefulWidget {
  final String astroId;
  final bool fromWallet;

  const RatingPage({super.key, required this.astroId, required this.fromWallet});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  static const String TAG = "_RatingPageState";

  TextEditingController ratingController = TextEditingController();
  double ratingCount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/BackGround.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          bgImagecommon(context),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  sizedboxheight(15.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: appBarChatHistory(context, "RATE  ASTROLOGER"),
                  ),
                  sizedboxheight(35.0),
                  Container(
                    padding: const EdgeInsets.all(padding20),
                    width: deviceWidth(context, 1.0),
                    decoration: decorationtoprounded(),
                    child: Column(
                      children: [
                        sizedboxheight(10.0),
                        RatingBar.builder(
                          initialRating: 0,
                          minRating: 0,
                          itemSize: 40,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (double rating) {
                            ratingCount = rating;
                          },
                        ),
                        sizedboxheight(40.0),
                        SizedBox(
                          width: deviceWidth(context, 0.75),
                          child: TextFormField(
                            controller: ratingController,
                            minLines: 4,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: 'Enter your comment here...',
                              hintStyle: TextStyle(
                                color: colororangeLight,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                            ),
                          ),
                        ),
                        sizedboxheight(40.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colororangeLight,
                            textStyle: const TextStyle(fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            if (ratingCount == 0) {
                              Fluttertoast.showToast(msg: "please provide ratting");
                            } else {
                              addReview(context, widget.astroId, ratingCount);
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: const Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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

  Future<void> addReview(BuildContext context, String astroId, double ratingCount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('login_user_id');

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      'user_id': userid.toString(),
      'astro_id': astroId,
      'message': ratingController.text,
      'rating': ratingCount,
    });
    debugPrint("$TAG formData =======> ${formData.fields}");
    var response = await dio.post("${baseURL}astro_review", data: formData);
    final responseData = json.decode(response.toString());

    debugPrint("$TAG response Data ======> $responseData");

    if (responseData['status']) {
      ratingController.clear();
      redirectToHome(context);
    } else {
      redirectToHome(context);
    }
  }

  void redirectToHome(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 100), () {
      Get.offUntil(
        MaterialPageRoute(
          builder: (context) {
            return BottomNavBarPage(fromWallet: widget.fromWallet);
          },
        ),
        (route) {
          return false;
        },
      );
    });
  }

  Widget appBarChatHistory(BuildContext context, String title) {
    return AppBar(
      leadingWidth: 36,
      toolbarHeight: 34,
      leading: backButton(context),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: textstyletitleHeading6(context)!.copyWith(
              color: Colors.white,
              fontWeight: fontWeight900,
              letterSpacing: 1,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget backButton(BuildContext context) {
    return Container(
      width: 36,
      height: 34,
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorgreyblack.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Center(
          child: IconButton(
              onPressed: () {
                redirectToHome(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: colorblack,
                size: 17,
              )),
        ),
      ),
    );
  }
}
