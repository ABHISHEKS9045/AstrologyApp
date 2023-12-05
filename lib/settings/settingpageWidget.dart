import 'package:astrologyapp/account%20setting/accountsettingpage.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/help&support/help&support.dart';
import 'package:astrologyapp/login%20Page/LoginPage.dart';
import 'package:astrologyapp/login%20Page/social%20login/loginController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../about/aboutUs/aboutpage.dart';
import '../about/privecy policy/privecyPolicyPage.dart';
import '../about/termcondition/termconditionPage.dart';
import '../common/commonwidgets/toast.dart';
import '../dashboard/dashboardModelPage.dart';
import '../feedback/feedbackPage.dart';

Widget accountSettingWidget(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Material(
      color: colorWhite,
      child: InkWell(
        splashColor: Colors.black54,
        onTap: () {
          Get.to(() => AccountSettingPage());
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: colorgreyblack.withOpacity(0.2),
            ),
          ),
          child: ListTile(
            minLeadingWidth: 5,
            leading: const SizedBox(
              height: 21,
              child: Image(
                image: AssetImage(
                  'assets/icons/people.png',
                ),
              ),
            ),
            title: Text(
              'Account Setting',
              style: textstyletitleHeading6(context),
            ),
            trailing: const SizedBox(
              width: 20,
              height: 20,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget privacySettingWidget(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Material(
      color: colorWhite,
      child: InkWell(
        splashColor: Colors.black54,
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => ));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: colorgreyblack.withOpacity(0.2),
            ),
          ),
          child: ListTile(
            minLeadingWidth: 5,
            leading: const SizedBox(
              height: 21,
              child: Image(
                image: AssetImage(
                  'assets/icons/setting.png',
                ),
              ),
            ),
            title: Text(
              'Privacy Setting',
              style: textstyletitleHeading6(context),
            ),
            trailing: const SizedBox(
              width: 20,
              height: 20,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget logoutWidget(BuildContext context, DashboardModelPage model, bool isGuestLoggedIn) {
  final controller = Get.put(LoginController());
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Material(
      color: colorWhite,
      child: isGuestLoggedIn
          ? InkWell(
              splashColor: Colors.black38,
              onTap: () async {
                // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                //   builder: (context) {
                //     return LoginPage();
                //   },
                // ), (route) => false);
                await controller.logout(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(
                    color: colorgreyblack.withOpacity(0.2),
                  ),
                ),
                child: ListTile(
                  minLeadingWidth: 5,
                  title: Text(
                    'Go To Login Page',
                    style: textstyletitleHeading6(context),
                  ),
                  trailing: const SizedBox(
                    width: 20,
                    height: 20,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                    ),
                  ),
                ),
              ),
            )
          : InkWell(
              splashColor: Colors.black38,
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Are you sure'),
                    content: const Text('You want to Logout'),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colororangeLight,
                          textStyle: const TextStyle(fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () async {
                          Constants.showToast('Logout Successful');
                          await controller.logout(context);
                        },
                        child: const Text(
                          'Yes',
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colororangeLight,
                          textStyle: const TextStyle(fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text(
                          'No',
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(
                    color: colorgreyblack.withOpacity(0.2),
                  ),
                ),
                child: ListTile(
                  minLeadingWidth: 5,
                  leading: const SizedBox(
                    height: 21,
                    child: Image(
                      image: AssetImage(
                        'assets/icons/Logout.png',
                      ),
                    ),
                  ),
                  title: Text(
                    'Log Out',
                    style: textstyletitleHeading6(context),
                  ),
                  trailing: const SizedBox(
                    width: 20,
                    height: 20,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
    ),
  );
}

Widget notificationSwitchSetting(context, model) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: InkWell(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => click));
      },
      child: Container(
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.circular(10),
          border: borderCustom(),
        ),
        child: StatefulBuilder(
          builder: (BuildContext context, setState) {
            return ListTile(
              leading: const Icon(
                Icons.notifications_outlined,
              ),
              title: Text(
                'Notifications',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                  value: model.switchVal,
                  activeColor: colororangeLight,
                  onChanged: (value) {
                    model.toggleSwitchbtn();
                  },
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}

Widget supportWidget(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Material(
      color: colorWhite,
      child: InkWell(
        splashColor: Colors.black54,
        onTap: () {
          Get.to(() => const HelpSupportPage());
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: colorgreyblack.withOpacity(0.2),
            ),
          ),
          child: ListTile(
            minLeadingWidth: 5,
            leading: const SizedBox(
              height: 21,
              child: Icon(
                Icons.chat,
              ),
            ),
            title: Text(
              'Help & Support',
              style: textstyletitleHeading6(context),
            ),
            trailing: const SizedBox(
              width: 20,
              height: 20,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

// privacy policy widget
Widget privacyWidget(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Material(
      color: colorWhite,
      child: InkWell(
        splashColor: Colors.black54,
        onTap: () async {
          Get.to(() => const PrivecyPolicyPage());
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: colorgreyblack.withOpacity(0.2),
            ),
          ),
          child: ListTile(
            minLeadingWidth: 5,
            leading: const SizedBox(
              height: 21,
              child: Image(
                image: AssetImage(
                  'assets/icons/help.png',
                ),
              ),
            ),
            title: Text(
              'Privacy Policy',
              style: textstyletitleHeading6(context),
            ),
            trailing: const SizedBox(
              width: 20,
              height: 20,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

// terms & condition widget
Widget termsConditionWidget(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Material(
      color: colorWhite,
      child: InkWell(
        splashColor: Colors.black54,
        onTap: () async {
          Get.to(() => const TermConditionPage());
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: colorgreyblack.withOpacity(0.2),
            ),
          ),
          child: ListTile(
            minLeadingWidth: 5,
            leading: const SizedBox(
              height: 21,
              child: Image(
                image: AssetImage(
                  'assets/icons/help.png',
                ),
              ),
            ),
            title: Text(
              'Terms & Condition',
              style: textstyletitleHeading6(context),
            ),
            trailing: const SizedBox(
              width: 20,
              height: 20,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

// account setting about app widget
Widget aboutAppWidget(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Material(
      color: colorWhite,
      child: InkWell(
        splashColor: Colors.black54,
        onTap: () async {
          Get.to(() => const AboutPage());
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: colorgreyblack.withOpacity(0.2),
            ),
          ),
          child: ListTile(
            minLeadingWidth: 5,
            leading: const SizedBox(
              height: 21,
              child: Image(
                image: AssetImage(
                  'assets/icons/about.png',
                ),
              ),
            ),
            title: Text(
              'About App',
              style: textstyletitleHeading6(context),
            ),
            trailing: const SizedBox(
              width: 20,
              height: 20,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

// account setting rate us widget
Widget rateUsWidget(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Material(
      color: colorWhite,
      child: InkWell(
        splashColor: Colors.black54,
        onTap: () async {
          Get.to(() => const FeedbackPage());
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: colorgreyblack.withOpacity(0.2),
            ),
          ),
          child: ListTile(
            minLeadingWidth: 5,
            leading: const SizedBox(
              height: 21,
              child: Image(
                image: AssetImage(
                  'assets/icons/rate.png',
                ),
              ),
            ),
            title: Text(
              'Share Feedback',
              style: textstyletitleHeading6(context),
            ),
            trailing: const SizedBox(
              width: 20,
              height: 20,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
