import 'dart:convert';
import 'dart:io';

import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/shimmereffect.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/dashboard/YoutubePlayer.dart';
import 'package:astrologyapp/dashboard/dashboardModelPage.dart';
import 'package:astrologyapp/dashboard/dashboardWidgetPage.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:astrologyapp/notification/notificationPage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../common/appbar/appbarmodal.dart';
import '../common/bottomnavbar/bottomnavbarModelPage.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String TAG = "_DashboardPageState";

  var amount;
  AppBarModalPage? appBarModel;


  @override
  void initState() {
    var list = Provider.of<DashboardModelPage>(context, listen: false);
    appBarModel = Provider.of<AppBarModalPage>(context, listen: false);
    list.userTypeFind();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(const Duration(milliseconds: 300));

      if (mounted) {
        appBarModel!.getNotificationList(context, '0');
        await list.getgeustLogin();
        if (mounted) {
          await list.dashboardAstrologerList(context);
        }
        if (mounted) {
          await list.dashboardBannerList(context);
        }
        if (mounted) {
          await list.dashboardClientTestimonialList(context);
        }
        if (mounted) {
          await list.dashboardAstroNewsList(context);
        }

        if (list.isGeustLoggedIn == false && mounted) {
          list.dashboardProfileView(context, false);
          wallet();
        }
      }
    });
    super.initState();
  }

  wallet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('login_user_id');
    var userType = prefs.getString('user_type');

    if (userType == '2') {
      updateChatStatus(userid);
    }

    Dio dio = Dio();
    final formData = {'user_id': userid, 'user_type': userType};
    // print('formData>>>>$formData');

    var response = await dio.post("${baseURL}view_wallet_bal", data: formData);
    final responseData = json.decode(response.data);
    debugPrint("$TAG get wallet responseData =======> $responseData");
    try {
      if (responseData['status'] == true) {
        setState(() {
          amount = responseData['Amount'];
        });
      } else {}
    } catch (e) {
      debugPrint("$TAG get wallet error =======> ${e.toString()}");
    }
  }

  updateChatStatus(astroId) async {
    Dio dio = Dio();

    DateTime startTime = DateTime.now();
    DateTime endTime = startTime;
    FormData formData = FormData.fromMap({
      "start_time": startTime,
      "end_time": endTime,
      'astro_id': astroId,
      'status': 0,
    });

    try {
      var response = await dio.post("${baseURL}chat_status_update", data: formData);
    } catch (e) {
      // print(e);
    }
  }

  void _launchURL() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const YoutubeVideoPlayerScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DashboardModelPage>(builder: (context, model, _) {
        return Stack(
          children: [
            bgImagecommon(context),
            MediaQuery(
              data: mediaText(context),
              child: SizedBox(
                height: deviceheight(context, 1.0),
                child: SafeArea(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            leadingWidth: 48.w,
                            leading: Container(
                              height: 56,
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "Connect Aastro",
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500, color: Colors.white,),
                              ),
                            ),
                            centerTitle: false,
                            actions: [
                              // comment by nilesh for testing on 16-05-2023
                              Container(
                                margin: const EdgeInsets.only(right: 05.0),
                                child: Badge(
                                  isLabelVisible: appBarModel!.counter > 0,
                                  textColor: Colors.white,
                                  backgroundColor: Colors.red,
                                  alignment: AlignmentDirectional.centerEnd,
                                  label: Text(
                                    "${appBarModel!.counter > 10 ? "10+" : appBarModel!.counter}",
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: IconButton(
                                    onPressed: () async {
                                      if(!model.isGeustLoggedIn) {
                                        var result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return const NotificationPage();
                                        }));

                                        if (result != null) {
                                          if (mounted) {
                                            appBarModel!.getNotificationList(context, '0');
                                          }
                                        }
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.notifications_none,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10)
                            ],
                          ),
                        ),
                        titleHeaderRow(context, model, amount, model.isGeustLoggedIn),
                        sizedboxheight(9.0),
                        Container(
                          padding: const EdgeInsets.all(15),
                          width: deviceWidth(context, 1.0),
                          height: deviceheight(context, 0.8),
                          decoration: decorationtoprounded(),
                          child: RefreshIndicator(
                            color: colororangeLight,
                            onRefresh: () async {
                              if (mounted) {
                                var list = Provider.of<DashboardModelPage>(context, listen: false);
                                appBarModel = Provider.of<AppBarModalPage>(context, listen: false);
                                appBarModel!.getNotificationList(context, '0');
                                await list.getgeustLogin();
                                await list.dashboardAstrologerList(context);
                                await list.dashboardBannerList(context);
                                await list.dashboardClientTestimonialList(context);
                                await list.dashboardAstroNewsList(context);
                                await list.userTypeFind();
                                if (list.isGeustLoggedIn == false) {
                                  list.dashboardProfileView(context, false);
                                  wallet();
                                }
                              }
                            },
                            child: SingleChildScrollView(
                              physics: const ScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  features(context, model.isGeustLoggedIn, model.usertype),
                                  model.isShimmer
                                      ? shimmer()
                                      : model.bannerDataList.isNotEmpty
                                          ? dashboardSlider(context, model)
                                          : Container(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      customPageIndicator(model),
                                    ],
                                  ),
                                  sizedboxheight(10.0),
                                  cardTitleWidget(context, 'Explore Rashi', '', model),
                                  sizedboxheight(5.0),
                                  cartlisthorizontal(),
                                  sizedboxheight(10.0),
                                  model.usertype == '1' ? cardTitleWidget(context, model.usertype == '1' ? 'Active Astrologers' : '', 'View All', model) : Container(),
                                  sizedboxheight(10.0),
                                  model.usertype == '1'
                                      ? SizedBox(
                                          height: 140,
                                          child: model.isShimmer ? shimmer() : cartListVertical(model, amount),
                                        )
                                      : Container(),
                                  sizedboxheight(10.0),
                                  // cardTitleWidget(context, 'Explore Rashi', '', model),
                                  // sizedboxheight(10.0),
                                  // cartlisthorizontal(),
                                  sizedboxheight(10.0),
                                  cardTitleWidget(context, 'Behind the scenes', '', model),
                                  sizedboxheight(10.0),
                                  SizedBox(height: 150, child: behindScensList(_launchURL)),
                                  sizedboxheight(20.0),
                                 // cardTitleWidget(context, 'What Clients Says', 'View All', model),
                                  //sizedboxheight(10.0),
                                  //clientsTestimonialList(_launchURL, model),
                                  sizedboxheight(10.0),
                                 // sizedboxheight(10.0),
                                  cardTitleWidget(context, 'Connect aastro in news', 'View All', model),
                                  sizedboxheight(10.0),
                                  newsList(model),
                                  sizedboxheight(10.0),
                                  appFeatures(context),
                                  if (Platform.isAndroid) sizedboxheight(105.0),
                                  if (Platform.isIOS) sizedboxheight(105.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if(model.usertype == '1')
            Positioned(
              bottom: 10,
              left: 5,
              right: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 45,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colororangeLight,
                        foregroundColor: Colors.white,
                        elevation: 10,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0),),
                      ),
                      onPressed: () {
                        Provider.of<BottomNavbarModelPage>(context, listen: false).toggle(context, 1);
                      },
                      icon: const Icon(Icons.call, size: 16,),
                      label: const Text(
                        "Call with Astrologer",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 45,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colororangeLight,
                        foregroundColor: Colors.white,
                        elevation: 10,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0),),
                      ),
                      onPressed: () {
                        Provider.of<BottomNavbarModelPage>(context, listen: false).toggle(context, 3);
                      },
                      icon: const Icon(Icons.chat_outlined, size: 16,),
                      label: const Text(
                        "Chat with Astrologer",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
