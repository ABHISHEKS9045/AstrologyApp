import 'package:astrologyapp/account%20setting/accountsettingwidget.dart';
import 'package:astrologyapp/common/appbar/chatpageAppbar.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/dashboard/dashboardModelPage.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountSettingPage extends StatelessWidget {
  AccountSettingPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final dbmodel = Provider.of<DashboardModelPage>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          bgImagecommon(context),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/BackGround.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // sizedboxheight(10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: appbarbackbtnnotification(
                        context,
                        'ACCOUNT SETTING',
                      ),
                    ),
                    sizedboxheight(deviceheight(context, 0.04)),
                    Container(
                      width: deviceWidth(context, 1.0),
                      height: deviceheight(context, 0.9),
                      decoration: BoxDecoration(
                        color: colorWhite,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/BackGround.png',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizedboxheight(20.0),
                            dbmodel.isGeustLoggedIn ? Container() : profileWidget(context),
                            dbmodel.isGeustLoggedIn ? Container() : changePasswordWidget(context),
                            dbmodel.isGeustLoggedIn ? Container() : myWalletWidget(context),
                            dbmodel.isGeustLoggedIn ? Container() : callHistoryWidget(context),
                            dbmodel.isGeustLoggedIn ? Container() : chatHistoryWidget(context),
                            dbmodel.isGeustLoggedIn ? Container() : orderHistoryWidget(context),
                            referEarnWidget(context),
                            sizedboxheight(120.0),
                          ],
                        ),
                      ),
                    ),
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
