import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/generate%20kundli/openkundlimodelpage.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'generatekundliWidgetpage.dart';

class GenerateKundliPage extends StatefulWidget {
  bool showBackButton = true;

  GenerateKundliPage({Key? key, required this.showBackButton}) : super(key: key);

  @override
  State<GenerateKundliPage> createState() => _GenerateKundliPageState();
}

class _GenerateKundliPageState extends State<GenerateKundliPage> {
  final formkey = GlobalKey<FormState>();

  final List tabnamelist = ['Open Kundli', 'Generate Kundli'];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(const Duration(seconds: 1));

      var list = Provider.of<Openkundlimodelpage>(context, listen: false);
      await list.kundlilistview(context);
      // print('open kundli list init');
    });

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      // print('Token.....   $value');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        if (notification.body == 'You have audio call now' || notification.body == 'You have vedio call now') {
          // print('Token.....   ${notification.body}');
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => Incomincall(
          //               calltype: notification.body.toString(),
          //             )));
        }
        var type = message.data['type'] ?? '';
        // print('Token.....   $type');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Consumer<Openkundlimodelpage>(builder: (context, model, _) {
          return Stack(
            children: [
              bgImagecommon(context),
              Container(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        sizedboxheight(15.0),
                        Row(
                          children: [
                            SizedBox(
                              width: 5.w,
                            ),
                            if (widget.showBackButton)
                              Container(
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
                                        Navigator.pop(context);
                                        // print('click back2 appbar');
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        color: colorblack,
                                        size: 17,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Text(
                              'GENERATE KUNDALI',
                              style: textstyletitleHeading6(context)!.copyWith(color: colorWhite, fontWeight: fontWeight900, letterSpacing: 1, fontSize: 20),
                            ),
                          ],
                        ),
                        // Padding(
                        //     padding: const EdgeInsets.symmetric(horizontal: 15),
                        //     child: appbarbackbtnnotification(
                        //         context, model.appbartitle)),
                        sizedboxheight(18.0),
                        DefaultTabController(
                          length: 2,
                          child: Container(
                              padding: const EdgeInsets.all(padding20),
                              width: deviceWidth(context, 1.0),
                              decoration: decorationtoprounded(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: deviceWidth(context, 1.0),
                                    height: 45,
                                    decoration: BoxDecoration(border: borderCustom(), borderRadius: borderRadiuscircular(15.0)),
                                    child: Container(
                                      child: TabBar(
                                        isScrollable: true,
                                        labelStyle: const TextStyle(color: Colors.white),
                                        labelColor: Colors.white,
                                        unselectedLabelStyle: const TextStyle(color: Colors.black54),
                                        unselectedLabelColor: Colors.black54,
                                        indicatorSize: TabBarIndicatorSize.tab,
                                        indicator: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colororangeLight),
                                        tabs: [
                                          Container(
                                              width: deviceWidth(context, 0.38),
                                              child: Center(
                                                  child: Text(
                                                tabnamelist[0],
                                                style: const TextStyle(fontSize: 16),
                                              ),),),
                                          Container(
                                              width: deviceWidth(context, 0.38),
                                              child: Center(
                                                  child: Text(
                                                tabnamelist[1],
                                                style: const TextStyle(fontSize: 16),
                                              ),),),
                                        ],
                                        onTap: (value) async {
                                          // print('vinay $value');
                                          model.toggelappbartitle(value);

                                          var list = Provider.of<Openkundlimodelpage>(context, listen: false);

                                          if (value == 0) {
                                            await list.kundlilistview(context);
                                          }
                                          // print('open kundli list init setstate');
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: deviceheight(context, 0.73),
                                    child: TabBarView(
                                      children: [
                                      openkundlitabbarview(context, formkey),
                                      genrateKundliTabBarview(context, formkey),
                                    ],),
                                  ),
                                ],
                              ),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
