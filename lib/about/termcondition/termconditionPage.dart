import 'package:astrologyapp/common/appbar/chatpageAppbar.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';

import 'termConditionWidgetpage.dart';

class TermConditionPage extends StatelessWidget {
  const TermConditionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: appbarChatScreen(context, 'TERMS AND CONDITIONS'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Container(
          width: deviceWidth(context, 1.0),
          height: deviceheight(context, 1.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/BackGround.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                appAimWidget(context),
                sizedboxheight(30.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
