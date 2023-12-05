import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/dashboard/dashboardModelPage.dart';
import 'package:astrologyapp/profile/profilePageWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/appbar/chatpageAppbar.dart';
import '../common/commonwidgets/commonWidget.dart';
import '../common/shimmereffect.dart';
import '../login Page/loginpageWidget.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();
  String userType = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var model = Provider.of<DashboardModelPage>(context, listen: false);
      await model.dashboardProfileView(context, true);
      model.setData();
      await model.getAstrologerBankData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DashboardModelPage>(builder: (BuildContext context, DashboardModelPage model, _) {
        return Stack(
          children: [
            bgImagecommon(context),
            SafeArea(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: appbarbackbtnnotification(
                        context,
                        'MY PROFILE',
                      ),
                    ),
                    sizedboxheight(30.0),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: padding20),
                      width: deviceWidth(context, 1.0),
                      height: deviceheight(context, 1.0),
                      decoration: decorationtoprounded(),
                      child: SingleChildScrollView(
                        //physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            profileHeader(context, model),
                            if (model.usertype == '2') showAstrologerStatusWidgets(context, model),
                            mailWidget(context, model),
                            birthTimeWidget(context, model),
                            mobileNumberWidget(context, model),
                            genderWidget(context, model),
                            dobWidget(context, model),
                            addressWidget(context, model),
                            if (model.usertype == '2') showAstrologerData(context, model),
                            sizedboxheight(120.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            model.isShimmer ? loadingwidget() : Container(),
          ],
        );
      }),
    );
  }

  Widget showAstrologerData(BuildContext context, DashboardModelPage model) {
    return Column(
      children: [
        perMinuteWidget(context, model),
        languageWidget(context, model),
        skillWidget(context, model),
        aboutUsWidget(context, model),
      ],
    );
  }

  Widget showAstrologerStatusWidgets(BuildContext context, DashboardModelPage model) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: colorgreyblack.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          onlineOfflineWidget(context, model),
          Divider(
            color: colorgreyblack.withOpacity(0.2),
            height: 1.0,
            thickness: 1.0,
          ),
          chatActiveWidget(context, model),
          Divider(
            color: colorgreyblack.withOpacity(0.2),
            height: 1.0,
            thickness: 1.0,
          ),
          callActiveWidget(context, model),
          Divider(
            color: colorgreyblack.withOpacity(0.2),
            height: 1.0,
            thickness: 1.0,
          ),
          setAvailabilityWidget(context, model),
          model.isSetAvailability ? Divider(
            color: colorgreyblack.withOpacity(0.2),
            height: 1.0,
            thickness: 1.0,
          ) : Container(),
          model.isSetAvailability ? freeAvailabilityDropDownWidget(context, model) : Container(),
        ],
      ),
    );
  }
}
