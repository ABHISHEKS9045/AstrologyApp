import 'package:astrologyapp/common/appbar/chatpageAppbar.dart';
import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:flutter/material.dart';

import 'orderhistorydetailwidgetPage.dart';

class OrderhistorydetailwPage extends StatelessWidget {
  OrderhistorydetailwPage({Key? key, this.currentplan}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final currentplan;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            bgImagecommon(context),
            SafeArea(
                child: Container(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    sizedboxheight(10.0),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: appbarbackbtnnotification(context, 'PLAN DETAILS')),
                    sizedboxheight(18.0),
                    Container(
                        padding: EdgeInsets.all(padding20),
                        width: deviceWidth(context, 1.0),
                        height: deviceheight(context, 0.85),
                        decoration: decorationtoprounded(),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sizedboxheight(20.0),
                              orderhistorydetailwidgetcontainer(context, currentplan),
                              sizedboxheight(30.0),
                              // panchangBirthdetail(context),
                              // sizedboxheight(20.0)
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
