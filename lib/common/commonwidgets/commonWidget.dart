import 'package:astrologyapp/common/bottomnavbar/bottomnavbarModelPage.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/dashboard/dashboardModelPage.dart';
import 'package:astrologyapp/login%20Page/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

Future<bool> onWillPop(context) async {
  final showPopUp = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: const Text('Are you sure'),
      content: const Text('You want to leave from App'),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: colororangeLight,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text(
            'Yes',
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: colororangeLight,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('No'),
        ),
      ],
    ),
  );

  return showPopUp ?? false;
}

Future<bool> onWillPopUpdateStatus(BuildContext context, BottomNavbarModelPage model) async {
  final showPopUp = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: const Text('Are you sure'),
            content: const Text('You want to leave from App'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: colororangeLight,
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () async {
                  await model.updateUserStatus("Offline");
                  Navigator.of(context).pop(true);
                },
                child: const Text(
                  'Yes',
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: colororangeLight,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No')),
            ],
          ));

  return showPopUp ?? false;
}

Future<bool> geustloginfirst(context) async {
  final showPopUp = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: const Text('Please Login'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: colororangeLight,
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () async {
                  Get.to(() => LoginPage());

                  final bottompagemodel = Provider.of<BottomNavbarModelPage>(context, listen: false);
                  await bottompagemodel.togglebottomindexreset();
                  final dbmodel = Provider.of<DashboardModelPage>(context, listen: false);
                  await dbmodel.geustloginfalse();
                },
                child: const Text(
                  'Yes',
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: colororangeLight,
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
          ));

  return showPopUp ?? false;
}

Widget headingscustomwidget(context, heading) {
  return Text(heading, style: textstyleHeading1(context));
}

Decoration decorationtoprounded() {
  return BoxDecoration(
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
  );
}

BorderRadius borderRadiuscircular(radius) {
  return BorderRadius.circular(radius);
}

boxShadowcontainer() {
  return [
    BoxShadow(
      color: Colors.grey.withOpacity(0.05),
      spreadRadius: 1,
      blurRadius: 1,
      offset: const Offset(0, 3),
    ),
  ];
}

void showPopup(BuildContext context, messageWidget) {
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.65),
    transitionDuration: const Duration(milliseconds: 400),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(15.0),
          // height: 300,
          margin: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          decoration: BoxDecoration(
            color: whiteColor.withOpacity(0.9),
            borderRadius: BorderRadius.circular(25),
          ),
          child: messageWidget ??
              const SizedBox.expand(
                child: FlutterLogo(),
              ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).animate(anim),
        child: child,
      );
    },
  );
}
