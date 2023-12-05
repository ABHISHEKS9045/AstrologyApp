import 'dart:convert';

import 'package:astrologyapp/common/bottomnavbar/bottomnavbarModelPage.dart';
import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/my%20wallet/mywalletpage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../chat/Astrologer response/CustomerResponse.dart';
import '../../chat/Astrologer response/atrologerChatResponse.dart';
import '../../chat/callList/CallHistoryListPage.dart';
import '../../chat/chat room/chatroomPage.dart';
import '../../chat/chatlist/chatlistmodelpage.dart';
import '../../main.dart';
import '../styles/const.dart';
import 'bottomnavbarwidget.dart';

class BottomNavBarPage extends StatefulWidget {

  final bool? fromWallet;
  final bool? toChat;

  const BottomNavBarPage({this.fromWallet, this.toChat, Key? key}) : super(key: key);

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  String TAG = "_BottomNavBarPageState";

  @override
  void initState() {
    checkNotification();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {});
      var model = Provider.of<BottomNavbarModelPage>(context, listen: false);
      await model.updateUserStatus("Online");

      if(widget.fromWallet != null && widget.fromWallet! == true) {
        Get.to(() => MyWalletPage());
      } else if(widget.toChat != null && widget.toChat! == true) {
        model.updateSelectedIndex(3);
      }
    });
    super.initState();
  }

  Future<void> checkNotification() async {
    print("$TAG checkNotification called");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? notificationData = pref.getString("notificationData");
    if (notificationData != "" && notificationData != null) {
      Map<String, dynamic> messageData = json.decode(notificationData);
      showNotification(messageData);
      pref.remove("notificationData");
    }
  }

  Future<void> showNotification(Map<String, dynamic> data) async {

    print('$TAG showNotification set navigation to astrologer page');
    if(data["type"] == "waiting" && data["notification_type"] == "astrologer_wait_request") {

      if(isChatConnected) {

      } else {
        Future.delayed(const Duration(milliseconds: 100), () {
          Get.offUntil(
            MaterialPageRoute(
              builder: (context) {
                return BottomNavBarPage(toChat: true,);
              },
            ),
                (route) {
              return false;
            },
          );
        });
      }
    } else if(data["type"] == "call_ended" && data["notification_type"] == "call_ended") {
      Future.delayed(const Duration(milliseconds: 100), () {
        Get.to(() => CallHistoryListPage());
      });
    } else if (data["type"] == "astrologer" && data['notification_type'] == 'send_request') {
      if(checkTimeDifference(int.parse(data["time"]))) {
        Future.delayed(const Duration(milliseconds: 100), () {
          Get.to(() =>
              AstrologerResponse(
                receiverId: data['receiver_id'],
                userName: data['user_name'],
                user_image: data['user_image'],
                sender_id: data['sender_id'],
                perMinute: data['per_minute'],
                requestId: data['id'],
              ));
        });
      } else {
        Fluttertoast.showToast(msg: 'Chat Request timeout');
      }
    } else if (data['type'] != 'astrologer' && data['notification_type'] == 'cancle') {
      debugPrint("$TAG message for customer to show wait list chat request rejected.");
      Fluttertoast.showToast(msg: 'Request rejected by astrologer...');
    } else if(data['type'] == 'astrologer' && data['notification_type'] == 'astrologer_reject_request') {
      debugPrint("$TAG message for customer to show wait list chat request rejected.");
      Fluttertoast.showToast(msg: 'Request rejected by astrologer...');

    } else if(data['type'] == 'astrologer' && data['notification_type'] == 'astrologer_send_request') {
      print("$TAG message for customer to show incoming chat request from astrologer.");
      Future.delayed(const Duration(milliseconds: 100), () {
        Get.to(() => CustomerResponse(
          requestType: data["request_type"].toString(),
          receiverId: int.parse(data['receiver_id'].toString()),
          userName: data['user_name'].toString(),
          userImage: data['user_image'].toString(),
          senderId: int.parse(data['sender_id'].toString()),
          perMinute: int.parse(data['per_minute'].toString()),
          requestId: int.parse(data['id'].toString()),
          phoneNo: data['astro_phone'].toString(),
        ));
      });
    } else if(data['type'] == 'astrologer' && data['notification_type'] == 'user_aprrove_request') {
      print("$TAG message for astrologer to show chat request accepted.");
      Future.delayed(const Duration(milliseconds: 100), () {
        Get.to(() => ChatRoomPage(
          chatTime: 0,
          receiver_id: data["sender_id"],
          isForHistory: false,
          userName: data["user_name"],
          perMinute: data["per_minute"],
        ));
      });
    } else if(data['type'] == 'astrologer' && data['notification_type'] == 'user_reject_request') {
      print("$TAG message for astrologer to show chat request rejected.");
      Fluttertoast.showToast(msg: 'Customer refused to join chat...');
      Future.delayed(const Duration(milliseconds: 100), () {
        Get.offUntil(
          MaterialPageRoute(
            builder: (context) {
              return BottomNavBarPage();
            },
          ),
              (route) {
            return false;
          },
        );
      });
    } else {
      if(checkTimeDifference(int.parse(data["time"]))) {
        try {
          final model1 = Provider.of<Chatlistmodelpage>(context, listen: false);
          await model1.getWalletBalance(context);
          print("$TAG model1 wallet Amount ========> ${model1.walletAmount}");
          print("$TAG notification data ========> ${data.toString()}");
          await model1.toggelreseverid(data['sender_id']);

          int time = (int.parse(model1.walletAmount.toString()) / int.parse(data['per_minute'].toString())).toInt();
          Future.delayed(const Duration(milliseconds: 100), () {
            Get.offUntil(MaterialPageRoute(builder: (context) {
              return ChatRoomPage(
                chatTime: time,
                isForHistory: false,
                perMinute: data['per_minute'],
                userName: data['user_name'],
                receiver_id: data['sender_id'],
              );
            },), (route) {
              return false;
            },);
          });
        } catch (e) {
          print("$TAG User side catch exception ==========> ${e.toString()}");
          Fluttertoast.showToast(msg: 'user${e.toString()}');
        }
      } else {
        Fluttertoast.showToast(msg: 'Chat Request timeout');
      }
    }
  }

  Future<bool> backdb(BottomNavbarModelPage model) async {
    if (model.bottombarzindex != 0) {
      model.togglebottomindexreset();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavbarModelPage>(builder: (context, BottomNavbarModelPage model, _) {
      return WillPopScope(
        onWillPop: () {
          return model.bottombarzindex == 0 ? onWillPopUpdateStatus(context, model) : backdb(model);
        },
        child: Scaffold(
          body: model.bottombarScreens[model.bottombarzindex],
          bottomNavigationBar: bottomNavBarPageWidget(context, model),
        ),
      );
    });
  }
}