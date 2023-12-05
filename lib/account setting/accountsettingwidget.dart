import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/my%20wallet/mywalletpage.dart';
import 'package:astrologyapp/order%20history/OrderHistoryPage.dart';
import 'package:astrologyapp/plan/planpage.dart';
import 'package:astrologyapp/profile/profilePage.dart';
import 'package:astrologyapp/refer%20a%20friend/referfriendPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../changepassword/ChangePasswordPage.dart';
import '../chat/callList/CallHistoryListPage.dart';
import '../chat/chatlist/chatHistoryPage.dart';

Widget profileWidget(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Material(
      color: colorWhite,
      child: InkWell(
        splashColor: Colors.black54,
        onTap: () async {
          Get.to(() => ProfilePage());
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
              'Your Profile',
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

// account setting history widget
Widget orderHistoryWidget(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Material(
      color: colorWhite,
      child: InkWell(
        splashColor: Colors.black54,
        onTap: () async {
          Get.to(() => const OrderHistoryPage());
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
                  'assets/icons/order.png',
                ),
              ),
            ),
            title: Text(
              'Transaction History',
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

// account setting wallet widget
Widget myWalletWidget(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Material(
      color: colorWhite,
      child: InkWell(
        splashColor: Colors.black54,
        onTap: () async {
          Get.to(() => MyWalletPage());
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
                  'assets/icons/wallet.png',
                ),
                color: Color(0xff413535),
              ),
            ),
            title: Text(
              'My Wallet',
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

// account setting refer earn widget
Widget referEarnWidget(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Material(
      color: colorWhite,
      child: InkWell(
        splashColor: Colors.black54,
        onTap: () async {
          Get.to(() => ReferFriendPage());
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
                  'assets/icons/refer.png',
                ),
              ),
            ),
            title: Text(
              'Refer a Friend',
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

// account setting upgrade plan widget
Widget upgradePlanWidget(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Material(
      color: colorWhite,
      child: InkWell(
        splashColor: Colors.black54,
        onTap: () async {
          Get.to(() => const PlanPage());
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
                  'assets/icons/upgrade.png',
                ),
              ),
            ),
            title: Text(
              'Upgrade Plan',
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

// account setting payment option widget
Widget paymentOptionWidget(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Material(
      color: colorWhite,
      child: InkWell(
        splashColor: Colors.black54,
        onTap: () async {
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
                  'assets/icons/payment.png',
                ),
              ),
            ),
            title: Text(
              'Payment Options',
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

Widget changePasswordWidget(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Material(
      color: colorWhite,
      child: InkWell(
        splashColor: Colors.black54,
        onTap: () {
          Get.to(() => const ChangePasswordPage());
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
                  'assets/icons/unlock.png',
                ),
              ),
            ),
            title: Text(
              'Change Password',
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

Widget callHistoryWidget(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Material(
      color: colorWhite,
      child: InkWell(
        splashColor: Colors.black54,
        onTap: () async {
          Get.to(() => const CallHistoryListPage());
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
                Icons.call,
              ),
            ),
            title: Text(
              'Call History',
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

Widget chatHistoryWidget(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Material(
      color: colorWhite,
      child: InkWell(
        splashColor: Colors.black54,
        onTap: () async {
          Get.to(() => const ChatHistoryListPage());
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
              'Chat History',
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
