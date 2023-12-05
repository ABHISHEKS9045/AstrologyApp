
import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/dashboard/dashboardModelPage.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:astrologyapp/settings/settingpageWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/BackGround.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          bgImagecommon(context),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: AppBar(
                      leading: Container(),
                      backgroundColor: Colors.transparent,
                      title: Text(
                        'SETTING',
                        style: textstyletitleHeading6(context)!.copyWith(
                          color: colorWhite,
                          fontWeight: fontWeight900,
                          letterSpacing: 1,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  sizedboxheight(35.0),
                  Container(
                    width: deviceWidth(context, 1.0),
                    decoration: decorationtoprounded(),
                    child: Consumer<DashboardModelPage>(
                      builder: (context, model, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizedboxheight(20.0),
                            model.isGeustLoggedIn ? Container() : accountSettingWidget(context),
                            model.isGeustLoggedIn ? Container() : supportWidget(context),
                            aboutAppWidget(context),
                            model.isGeustLoggedIn ? Container() : rateUsWidget(context),
                            privacyWidget(context),
                            termsConditionWidget(context),
                            logoutWidget(context, model, model.isGeustLoggedIn),
                          ],
                        );
                      },
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
}
