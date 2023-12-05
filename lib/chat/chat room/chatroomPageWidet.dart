import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/dashboard/dashboardModelPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Container chattingTypingWidgetBottom(
  BuildContext context,
  model,
  socket,
) {
  return Container(
    constraints: BoxConstraints(minHeight: 60),
    padding: EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(color: colorsanderchat, borderRadius: BorderRadius.circular(18.0)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        typingChatBox(context, model),
        Container(
          margin: EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            color: colororangeLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            onPressed: () async {
              var dbcontroller = Provider.of<DashboardModelPage>(context, listen: false);
              if (dbcontroller.isGeustLoggedIn) {
                geustloginfirst(context);
                model.typingreset();
              } else {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? usertype = prefs.getString('user_type');
                model.conversiontypingsubmit(
                  context,
                  socket,
                );
              }
            },
            icon: Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget typingChatBox(context, model) {
  return Expanded(
    child: TextField(
      controller: model.typingmessage,
      enabled: true,
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        border: new OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        isDense: true,
        hintText: 'Type something...',
        hintStyle: textstyletitleHeading6(context)!.copyWith(color: colorblack.withOpacity(0.5)),
        fillColor: colorsanderchat,
        filled: true,
      ),
    ),
  );
}
