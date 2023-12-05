import 'package:astrologyapp/common/appbar/chatpageAppbar.dart';
import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:astrologyapp/premium%20services/premiumservicesWidgetPage.dart';
import 'package:flutter/material.dart';

class PremiumServicesPage extends StatelessWidget {
  PremiumServicesPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          bgImagecommon(context),
          Container(
            width: deviceWidth(context, 1.0),
            height: deviceheight(context, 1.0),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    sizedboxheight(deviceheight(context, 0.01)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: appbarbackbtnnotification(
                          context, 'PREMIUM SERVICES'),
                    ),
                    sizedboxheight(deviceheight(context, 0.05)),
                    Container(
                        padding: EdgeInsets.all(padding10),
                        width: deviceWidth(context, 1.0),
                        decoration: decorationtoprounded(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            premiumserviceBox(context),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
