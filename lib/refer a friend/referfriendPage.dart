import 'package:astrologyapp/common/appbar/chatpageAppbar.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/refer%20a%20friend/referfriendWidget.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ReferFriendPage extends StatefulWidget {
  ReferFriendPage({Key? key}) : super(key: key);

  @override
  State<ReferFriendPage> createState() => _ReferFriendPageState();
}

class _ReferFriendPageState extends State<ReferFriendPage> {

  String TAG = "_ReferFriendPageState";

  final formKey = GlobalKey<FormState>();
  bool share = false;

  void _shareText() async {
    try {
      Share.share('This is text', subject: 'This is subject');
    } catch (e) {
     debugPrint("$TAG _shareText error ======> ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/BackGround.png'), fit: BoxFit.fill)),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appbarChatScreen(context, 'REFER A FRIEND'),
              sizedboxheight(30.0),
              referfriendHeader(context),
              // sizedboxheight(20.0),
              GestureDetector(
                onTap: () {
                  share = true;
                  (context as Element).markNeedsBuild();
                 // print(share);
                },
                child: sharelistView(context),
              ),
              // sizedboxheight(60.0),
              share == true
                  ? shareBtn(context, formKey, _shareText)
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
