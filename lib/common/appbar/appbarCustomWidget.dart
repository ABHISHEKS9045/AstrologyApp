import 'package:astrologyapp/common/appbar/appbarmodal.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/generate%20kundli/generatekundaliModelPage.dart';
import 'package:astrologyapp/notification/notificationPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget notificationWidget(BuildContext context, AppBarModalPage model) {
  return StatefulBuilder(builder: (context, setState) {
    return Container(
      margin: const EdgeInsets.only(right: 05.0),
      child: Badge(
        isLabelVisible: model.counter > 0,
        textColor: Colors.white,
        backgroundColor: Colors.red,
        alignment: AlignmentDirectional.centerEnd,
        label: Text(
          "${model.counter > 10 ? "10+" : model.counter}",
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white,
          ),
        ),
        child: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NotificationPage();
            }));
          },
          icon: const Icon(
            Icons.notifications_none,
            color: Colors.white,
            size: 35,
          ),
        ),
      ),
    );
  });
}

// Widget videocallAction() {
//   return IconButton(onPressed: () {}, icon: Container(color: colorWhite, width: 23, height: 23, child: const Image(image: AssetImage('assets/icons/videocall.png'))));
// }
//
// Widget audiocallAction() {
//   return IconButton(onPressed: () {}, icon: Container(color: colorWhite, width: 21, height: 21, child: const Image(image: AssetImage('assets/icons/phonecall.png'))));
// }

Widget userporifilePic() {
  return const CircleAvatar(
    radius: 20,
    child: Image(
      image: AssetImage('assets/icons/phonecall.png'),
    ),
  );
}

Widget pdficonAction(context) {
  return MaterialButton(
    minWidth: 15,
    height: 20,
    child: Image(
      image: const AssetImage('assets/icons/pdf.png'),
      color: colorWhite,
    ),
    onPressed: () async {
      final model = Provider.of<GenratekundliModelPage>(context, listen: false);
      model.downloadpdfkundli();
    },
  );
}

Widget backbtnleading1(BuildContext context, onTap) {
  return Container(
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
              onTap();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: colorblack,
              size: 17,
            )),
      ),
    ),
  );
}

Widget backButtonLeading(context) {
  return Container(
    width: 36,
    height: 34,
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
            Navigator.pop(context);
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

Widget drawerLeading(context) {
  return MaterialButton(
      onPressed: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => NotificationPage()));
      },
      minWidth: 25,
      height: 30,
      child: Container() /*Image(
      image: AssetImage('assets/icons/drawer.png'),
      fit: BoxFit.cover,
    ),*/
      );
}

Widget backButtonAppBar(BuildContext context) {
  return Container(
    alignment: Alignment.topLeft,
    margin: const EdgeInsets.all(10),
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
            Navigator.pop(context);
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
