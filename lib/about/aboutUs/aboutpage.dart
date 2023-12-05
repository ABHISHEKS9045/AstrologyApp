import 'package:astrologyapp/common/appbar/chatpageAppbar.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';

import 'aboutusPageWidget.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: deviceWidth(context, 1.0),
          height: deviceheight(context, 1.0),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/BackGround.png'),
                  fit: BoxFit.fill,),),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      appbarChatScreen(context, 'ABOUT US'),
                      sizedboxheight(20.0),
                      Column(
                        children: [
                          aboutUsWidget(context),
                          sizedboxheight(20.0),
                          contactUsWidget(context),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
