import 'package:astrologyapp/common/bottomnavbar/bottomnavbar.dart';
import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../common/commonwidgets/button.dart';
import '../chatlist/chatlistmodelpage.dart';

class AstrologerResponse extends StatefulWidget {
  final requestId;
  final receiverId;
  final sender_id;
  final userName;
  final user_image;
  final perMinute;

  AstrologerResponse({this.requestId, this.receiverId, this.sender_id, this.userName, this.user_image, this.perMinute});

  @override
  State<AstrologerResponse> createState() => _AstrologerResponseState();
}

class _AstrologerResponseState extends State<AstrologerResponse> {
  final formKey = GlobalKey<FormState>();

  Widget appBarNavigation(
    context,
    title,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 18),
      width: deviceWidth(context, 1.0),
      height: 70,
      child: Row(
        children: [
          Container(
            child: backButton(context),
          ),
          Container(
            alignment: Alignment.center,
            width: deviceWidth(context, 0.8),
            child: Text(
              title,
              style: textstyletitleHeading6(context)!.copyWith(
                color: colorWhite,
                fontWeight: fontWeight900,
                letterSpacing: 1,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget backButton(context) {
    return Container(
      width: 34,
      height: 32,
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorgreyblack.withOpacity(0.1),
        ),
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
              Get.to(() => BottomNavBarPage());
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: colorblack,
              size: 17,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Chatlistmodelpage>(builder: (context, model, _) {
      //model.profileView(context);
      return Scaffold(
        body: Stack(
          children: [
            bgImagecommon(context),
            Column(
              // mainAxisSize: MainAxisSize.max,
              children: [
                // sizedboxheight(20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: appBarNavigation(context, "Incoming request"),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(padding20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: decorationtoprounded(),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            child: const Text(
                              'Incoming Chat request from ',
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22,),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                             // "name",
                               widget.userName,
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 23,),
                            ),
                          ),
                          Container(
                            // margin: EdgeInsets.only(bottom: 100,top: 0),
                            margin: const EdgeInsets.only(top: 30, bottom: 30),

                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10, top: 0),
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      // color: Colors.red
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          widget.user_image,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    // 'name',
                                     widget.userName,
                                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 23,),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: HexColor('#F9921F'),
                              ),
                              //margin: const EdgeInsets.only(bottom: 10),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                                onPressed: () {
                                  model.astrologerResponseApi(context, widget.requestId, widget.sender_id, widget.userName, widget.user_image, widget.perMinute);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.message,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                    sizedboxwidth(8.0),
                                    const Text(
                                      'Start Chat',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
                                    )
                                  ],
                                ),
                              )),
                          Container(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                model.rejectChatRequest(context, widget.sender_id);
                              },
                              child: const Text(
                                'Reject Chat Request',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }

  Widget startChatBtn(BuildContext context, ontap) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Button(
        btnWidth: deviceWidth(context, 1.0),
        btnHeight: 55,
        buttonName: 'Start Chat',
        key: const Key('AstroResponse'),
        borderRadius: BorderRadius.circular(35.0),
        btnColor: colororangeLight,
        onPressed: ontap,
      ),
    );
  }
}
