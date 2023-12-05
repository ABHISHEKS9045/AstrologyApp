import 'package:astrologyapp/common/appbar/chatpageAppbar.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';
import 'privecypoliceWidgetPage.dart';

class PrivecyPolicyPage extends StatelessWidget {
  const PrivecyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: appbarChatScreen(context, 'PRIVACY POLICY'),
        ),
      ),
      body: Container(
          width: deviceWidth(context, 1.0),
          height: deviceheight(context, 1.0),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/BackGround.png'),
                  fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: deviceWidth(context, 1.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            children: [
                              sizedboxheight(10.0),
                              policyWidget(context),
                              sizedboxheight(30.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
