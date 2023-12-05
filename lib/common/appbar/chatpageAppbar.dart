
import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';

import 'appbarCustomWidget.dart';

Widget appbarChatScreen(context, title) {
  return AppBar(
    leadingWidth: 36,
    toolbarHeight: 34,
    leading: backButtonLeading(context),
    centerTitle: true,
    title: Text(
      title,
      style: textstyletitleHeading6(context)!.copyWith(
        color: colorblack,
        fontWeight: fontWeight900,
        letterSpacing: 1,
        fontSize: 15,
      ),
    ),
    // actions: [
    //   if (title == 'FEEDBACK' || title == 'REFER A FRIEND' || title == 'ABOUT US' || title == 'TERM & CONDITION' || title == 'PRIVACY POLICY')
    //     const Row(
    //       children: [],
    //     )
    //   else
    //     const Row(
    //       children: [
    //       ],
    //     )
    // ],
  );
}

Widget appbarChatScreen1(BuildContext context, title, ontap) {
  return AppBar(
    leadingWidth: 36,
    toolbarHeight: 34,
    leading: backbtnleading1(context, ontap),
    centerTitle: true,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: textstyletitleHeading6(context)!.copyWith(
            color: colorblack,
            fontWeight: fontWeight900,
            letterSpacing: 1,
            fontSize: 15,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '(',
              style: textstyletitleHeading6(context)!.copyWith(
                color: colorblack.withOpacity(0.7),
                fontWeight: fontWeight900,
                letterSpacing: 1,
                fontSize: 10,
              ),
            ),
            Container(
              height: 5,
              width: 5,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.green),
            ),
            const SizedBox(
              width: 1,
            ),
            Text(
              'Online)',
              style: textstyletitleHeading6(context)!.copyWith(
                color: Colors.black.withOpacity(0.7),
                fontWeight: fontWeight900,
                letterSpacing: 1,
                fontSize: 10,
              ),
            )
          ],
        )
      ],
    ),
  );
}

Widget appBarChatHistory(BuildContext context, String title, ontap) {
  return AppBar(
    leadingWidth: 36,
    toolbarHeight: 34,
    leading: backbtnleading1(context, ontap),
    centerTitle: true,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: textstyletitleHeading6(context)!.copyWith(
            color: colorblack,
            fontWeight: fontWeight900,
            letterSpacing: 1,
            fontSize: 15,
          ),
        ),
      ],
    ),
  );
}

Widget appbarrashiScreen(context, title) {
  return AppBar(
    leadingWidth: 36,
    toolbarHeight: 34,
    leading: backButtonLeading(context),
    backgroundColor: Colors.transparent,
    centerTitle: true,
    title: Text(
      title,
      style: textstyletitleHeading6(context)!.copyWith(
        color: colorblack,
        fontWeight: fontWeight900,
        letterSpacing: 1,
        fontSize: 18,
      ),
    ),
  );
}

Widget appbarbackbtnnotification(context, title) {
  return SizedBox(
    width: deviceWidth(context, 1.0),
    height: 70,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        title == 'GENERATE KUNDLI' || title == 'KUNDLI' ? Container(width: 30) : backButtonLeading(context),
        Text(
          title,
          style: textstyletitleHeading6(context)!.copyWith(
            color: colorWhite,
            fontWeight: fontWeight900,
            letterSpacing: 1,
            fontSize: 18,
          ),
        ),
        title == 'GENERATE KUNDLI' || title == 'KUNDLI'
            ? Container(width: 30)
            : title == 'DETAILS'
                ? pdficonAction(context)
                : Container()
      ],
    ),
  );
}