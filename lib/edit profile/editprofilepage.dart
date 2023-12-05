import 'package:astrologyapp/common/appbar/chatpageAppbar.dart';
import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/shimmereffect.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/dashboard/dashboardModelPage.dart';
import 'package:astrologyapp/edit%20profile/editprofilemodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'editprofilepagewidget.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String TAG = "_EditProfilePageState";
  final formKey = GlobalKey<FormState>();
  String userType = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var model = Provider.of<EditProfileModel>(context, listen: false);
      var dashboardModel = Provider.of<DashboardModelPage>(context, listen: false);
      model.getLanguages(dashboardModel);
      model.getSkill(dashboardModel);
      model.setUserData(dashboardModel);
      Future.delayed(const Duration(seconds: 1));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userType = prefs.getString('user_type')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    var dashBoardModel = Provider.of<DashboardModelPage>(context, listen: false);
    return Consumer<EditProfileModel>(builder: (BuildContext context, EditProfileModel model, _) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: colororangeLight,
            title: appbarbackbtnnotification(
              context,
              'EDIT PROFILE',
            ),
          ),
          body: SizedBox(
            width: deviceWidth(context, 1.0),
            height: deviceheight(context, 1.0),
            child: Stack(
              children: [
                Container(
                  height: deviceheight(context, 0.3),
                  width: deviceWidth(context, 1.0),
                  color: colororangeLight,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 38),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: decorationtoprounded(),
                  child: SingleChildScrollView(
                    child: model.isShimmer
                        ? shimmer()
                        : Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                sizedboxheight(20.0),
                                profilePic(context, model, dashBoardModel),
                                sizedboxheight(15.0),
                                nameEditWidget(model, dashBoardModel),
                                sizedboxheight(15.0),
                                phoneEditWidget(model, dashBoardModel),
                                sizedboxheight(15.0),
                                dobEditWidget(context, model, dashBoardModel),
                                sizedboxheight(15.0),
                                birthTimeEditWidget(context, model, dashBoardModel),
                                sizedboxheight(15.0),
                                emailEditWidget(context, model, dashBoardModel),
                                sizedboxheight(15.0),
                                addressWidget(model, dashBoardModel),
                                sizedboxheight(15.0),
                                genderWidget(context, model, dashBoardModel),
                                if (userType == '2') astrologerFields(context, model, dashBoardModel),
                                sizedboxheight(40.0),
                                updateNowBtn(context, model, formKey),
                                sizedboxheight(15.0),
                              ],
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget astrologerFields(BuildContext context, EditProfileModel model, DashboardModelPage dashBoardModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedboxheight(18.0),
        updateWorkingHoursWidget(context, model, dashBoardModel),
        sizedboxheight(18.0),
        perMinute(context, model, dashBoardModel),
        sizedboxheight(15.0),
        userExperience(context, model, dashBoardModel),
        sizedboxheight(15.0),
        languageWidget(context, model, dashBoardModel),
        sizedboxheight(15.0),
        skillWidget(context, model, dashBoardModel),
        sizedboxheight(15.0),
        aboutWidget(context, model, dashBoardModel),
      ],
    );
  }
}
