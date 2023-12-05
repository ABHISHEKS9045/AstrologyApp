import 'package:astrologyapp/chat/chatlist/chatinglistPageWidget.dart';
import 'package:astrologyapp/chat/chatlist/chatlistmodelpage.dart';
import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/shimmereffect.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../common/appbar/chatpageAppbar.dart';

class ChatHistoryListPage extends StatefulWidget {
  const ChatHistoryListPage({super.key});

  @override
  State<ChatHistoryListPage> createState() => ChatHistoryListPageState();
}

class ChatHistoryListPageState extends State<ChatHistoryListPage> {

  String? userType = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      userType = pref.getString("user_type");
      Future.delayed(const Duration(seconds: 1));
      if(mounted) {
        var list = Provider.of<Chatlistmodelpage>(context, listen: false);
        await list.getChatHistoryList(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: colororangeLight,
        onRefresh: () async {
          var list = Provider.of<Chatlistmodelpage>(context, listen: false);
          await list.getChatHistoryList(context);
        },
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/BackGround.png',),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            bgImagecommon(context),
            SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: appbarbackbtnnotification(context, 'CHAT HISTORY'),
                    ),
                    sizedboxheight(35.0),
                    Consumer<Chatlistmodelpage>(
                      builder: (context, model, _) {
                        return Container(
                          padding: const EdgeInsets.all(padding20),
                          width: deviceWidth(context, 1.0),
                          decoration: decorationtoprounded(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              model.isShimmer
                                  ? Container(
                                      margin: EdgeInsets.only(top: 25.h),
                                      child: loadingwidget(),
                                    )
                                  : recentChatListWidget(context, userType, model),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}