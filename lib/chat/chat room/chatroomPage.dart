import 'dart:async';
import 'dart:convert';

import 'package:astrologyapp/chat/chat%20room/TimerProvider.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/cupertino/button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' hide FormData;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../common/apiErroralertdiloge.dart';
import '../../common/bottomnavbar/bottomnavbar.dart';
import '../../generate kundli/generatekundliPage.dart';
import '../../main.dart';
import 'ChatRoomModel.dart';
import 'RatingPage.dart';
import 'conversionwidget.dart';

class ChatRoomPage extends StatefulWidget {
  final int chatTime;
  final bool isForHistory;
  final String perMinute;
  final String userName;
  final String receiver_id;

  const ChatRoomPage({
    super.key,
    required this.chatTime,
    required this.isForHistory,
    required this.perMinute,
    required this.userName,
    required this.receiver_id,
  });

  @override
  ChatRoomPageState createState() => ChatRoomPageState();
}

class ChatRoomPageState extends State<ChatRoomPage> {
  String TAG = "_ChatRoomPageState";
  IO.Socket? socket;
  ChatRoomModel? chatModel;

  // Timer? countdownTimer;
  // Duration? duration = const Duration();
  bool isAstrologer = false;
  bool isInitialMessageSend = false;
  DateTime startTime = DateTime.now();
  bool isTyping = false;

  // String timerCount = "";
  String? userId;
  String? userType;
  // comment by nilesh using new timer for countdown on 09-06-2023
  Timer? timer;
  TimerProvider? timerProvider;

  Future<void> initSocket() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? socketToken = prefs.getString('socket_token');
    String? userId = prefs.getString('login_user_id');

    debugPrint('Connecting to chat service');
    debugPrint('Socket Token$socketToken');

    socket = await IO.io(socketURL, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    if (!socket!.connected) {
      await socket?.connect();

      socket?.onConnect((_) {
        debugPrint('$TAG web socket status ========> ${socket?.connected}');
        debugPrint('$TAG web socket id ==========> ${socket?.id}');
        debugPrint('$TAG web socket connected');

        chatModel!.sendOnline(socket);
        socket?.emit('chat_history', {'from_user_id': userId, 'to_user_id': widget.receiver_id, 'socket_id': socket?.id});

        socket?.on('chat_data', (dynamic message) async {
          if ((message['from_user_id'].toString() == chatModel!.ourSanderid.toString() && message['to_user_id'].toString() == chatModel!.reseverid.toString()) ||
              (message['to_user_id'].toString() == chatModel!.ourSanderid.toString() && message['from_user_id'].toString() == chatModel!.reseverid.toString())) {
            debugPrint("$TAG chat_data ========> ${message['data']}");
            chatModel!.chatconversiondata.clear();
            await chatModel!.setChatListData(message['data']);
            if (!isAstrologer && !isInitialMessageSend && mounted) {
              await chatModel!.sendInitialMessage(context, socket);
              isInitialMessageSend = true;
            }
          }
        });

        socket?.on('message_data', (dynamic message) async {
          debugPrint("$TAG message_data received =============>");
          if (message['from_user_id'].toString() == chatModel!.reseverid.toString() && message['to_user_id'].toString() == chatModel!.ourSanderid.toString()) {
            chatModel!.insertMessage(message);
          }
        });

        socket?.on('end_chat_data', (dynamic data) {
          debugPrint('$TAG web socket end chat data received');
          debugPrint('$TAG end chat data mobile ==========> $data');
          if (mounted) {

            if ((data["receiver_id"] == chatModel!.reseverid || data["receiver_id"] == chatModel!.ourSanderid) && (data["sender_id"] == chatModel!.reseverid || data["sender_id"] == chatModel!.ourSanderid)) {
              if (userId.toString() == data["receiver_id"].toString()) {
                endChatFromSocket();
              }
              Fluttertoast.showToast(msg: 'Chat Ended.....');

              // if (isAstrologer) {
              //   Fluttertoast.showToast(msg: 'Chat Ended');
              //   endChatFromSocket();
              // } else {
              //   Fluttertoast.showToast(msg: 'Chat Ended');
              //   endChatFromSocket();
              // }
            }
          }
        });
        socket?.on('end_chat_web', (dynamic data) {
          print("process=====> 1");
          debugPrint('$TAG web socket end chat data received');
          debugPrint('$TAG end chat data web ==========> $data');
          if (mounted) {
            // print("process=====> 2");
            //
            // print("SAved DAta: chatModel!.reseverid${chatModel!.reseverid}\n "
            //     "chatModel!.ourSanderid${chatModel!.ourSanderid}");
            //
            // //   chatModel!.reseverid: 140
            //   chatModel!.ourSanderid: 129


            if ((data["userid"].toString() == chatModel!.reseverid || data["astroid"].toString() == chatModel!.ourSanderid)

            // && (data["astroid"] == chatModel!.reseverid || data["userid"] == chatModel!.ourSanderid)
            )

            {

              // print("process=====> 3");


              if (userId.toString() == data["astroid"].toString()) {
                endChatFromSocket();
              }
              Fluttertoast.showToast(msg: 'Chat Ended.....');

              // if (isAstrologer) {
              //   Fluttertoast.showToast(msg: 'Chat Ended');
              //   endChatFromSocket();
              // } else {
              //   Fluttertoast.showToast(msg: 'Chat Ended');
              //   endChatFromSocket();
              // }
            }
          }
        });
        socket?.on('times_up_disconnect', (dynamic data) {
          if ((data["userid"].toString() == chatModel!.reseverid || data["astroid"].toString() == chatModel!.ourSanderid)){
            print('True times_up_disconnect',);
            endChat('', false);
            Fluttertoast.showToast(msg: 'Chat is ended due to low balance');
          }
        });



        socket?.on('typingResponse', (dynamic data) {
          if (data['is_type'] == 1 && data['user_id'].toString() == chatModel!.reseverid.toString()) {
            isTyping = true;
          } else {
            isTyping = false;
          }
          setState(() {});
        });

        setState(() {
          isChatConnected = true;
        });
      });
    }
  }

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userType = prefs.getString('user_type');
    userId = prefs.getString('login_user_id');
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
    debugPrint("$TAG init state called =======> ");
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) async {
      debugPrint("$TAG addPostFrameCallback timeStamp ========> $timeStamp");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userType = prefs.getString('user_type');
      userId = prefs.getString('login_user_id');

      Future.delayed(const Duration(seconds: 1));
      debugPrint("$TAG widget userName =========> ${widget.userName}");

      timerProvider = Provider.of<TimerProvider>(context, listen: false);
      chatModel = Provider.of<ChatRoomModel>(context, listen: false);
      chatModel!.toggleSenderId(userId!);
      chatModel!.toggleReceiverName(widget.userName);
      chatModel!.toggleReceiverId(widget.receiver_id);

      if (widget.chatTime == 0) {
        await chatModel!.getCustomerWalletBalance(context, widget.receiver_id, widget.perMinute);
      } else {
        chatModel!.toggleChatAvailableTime(widget.chatTime);
        timerProvider!.setRemainingTime(Duration(minutes: widget.chatTime).inSeconds);
      }

      chatModel!.typingmessage.addListener(() {
        socket!.emit('typing', {'user_id': chatModel!.ourSanderid, 'is_type': chatModel!.typingmessage.text.isNotEmpty ? 1 : 0});
      });
      if (userType == '2') {
        setState(() {
          isAstrologer = true;
        });
      } else {
        chatModel!.updateChatStatus(chatModel!.reseverid, chatModel!.chatTime!, true);
      }

      if (!isAstrologer) {
        debugPrint("$TAG chatModel chatTime before count down start =========> ${chatModel!.chatTime!}");
        showTimer();
      }
    });
    initSocket();
  }

  void showTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer time) {
      timer = time;
      var timerInfo = Provider.of<TimerProvider>(context, listen: false);
      if (timerInfo.getRemainingTime() == 60) {
        showBottomSheetPopUp(context);
      }
      if (timerInfo.getRemainingTime() > 0) {
        timerInfo.updateRemainingTime();
      } else {
        timer!.cancel();
        endChat("called from timer cancel", false);
      }
    });
  }

  ScrollController scrollController = ScrollController(); // Add a ScrollController
  ScrollController scrollController1 = ScrollController();
  int msgLength = 0;
  int msgLengthTemp = 0;
  int msgLengthTemp1 = 0;
  bool isScroll = true;

  void scrollToNewData(int duration) {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: duration),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("$TAG dispose called ========> ");
  }

  @override
  void deactivate() {
    super.deactivate();
    debugPrint("$TAG dispose called ========> ");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        debugPrint("$TAG Will Pop Scope on Will Pop =======> ");
        showEndChatDialog(false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          // leadingWidth: 36,
          toolbarHeight: 34,
          leading: backButtonLeading(context),
          centerTitle: true,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.userName.toUpperCase(),
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
          actions: [
            if (userType == "2")
              InkWell(
                onTap: () async {
                  await getWaitList(context);
                },
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: ImageIcon(
                    const AssetImage(
                      'assets/images/wait_icon.png',
                    ),
                    color: colororangeLight,
                  ),
                ),
              ),
            const SizedBox(width: 10),
            if (userType == "2")
              InkWell(
                onTap: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GenerateKundliPage(showBackButton: true)));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: colororangeLight, width: 1),
                  ),
                  width: 30,
                  height: 30,
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset('assets/icons/Freekundli.png', color: colororangeLight),
                ),
              ),
            const SizedBox(width: 15),

          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/BackGround.png")
            ),
          ),
          child: Column(
            children: [
              sizedboxheight(5.0),
              SizedBox(height: 1.h),
              if (!widget.isForHistory && !isAstrologer)
                Consumer<TimerProvider>(builder: (context, model, child) {
                  return SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(
                          visible: true,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Text(
                              printDuration(Duration(seconds: model.getRemainingTime())),
                              style: TextStyle(
                                color: colororangeLight,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showEndChatDialog(false);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: colororangeLight,
                                width: 2,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 0.0.h, horizontal: 6.w),
                            child: Center(
                              child: Text(
                                'End',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: colororangeLight,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              sizedboxheight(5.0),
              Consumer<ChatRoomModel>(
                builder: (context, model, child) {

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    scrollToNewData(500);
                    // isScroll = false;
                  });

                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(

                              controller:  scrollController ,

                              itemCount: model.chatconversiondata.length,
                              // padding: const EdgeInsets.only(bottom: 20),
                              itemBuilder: (context, index) {
                                msgLength = model.chatconversiondata.length;
                                if(msgLengthTemp != msgLength ){

                                  msgLengthTemp1 = msgLengthTemp;
                                  msgLengthTemp = msgLength;
                                  isScroll = true;
                                  scrollController.animateTo(
                                    scrollController.position.maxScrollExtent,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                }

                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(5),
                                  decoration: model.chatconversiondata[index]['from_user_id'].toString() == model.ourSanderid
                                      ? const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  )
                                      : const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: model.chatconversiondata[index]['from_user_id'].toString() == model.ourSanderid ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                                    children: [
                                      if (model.chatconversiondata[index]['message_type'] == "text")
                                        Align(
                                          alignment: model.chatconversiondata[index]['from_user_id'].toString() == model.ourSanderid ? Alignment.topRight : Alignment.topLeft,
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            margin: const EdgeInsets.all(5),
                                            decoration: model.chatconversiondata[index]['from_user_id'].toString() == model.ourSanderid
                                                ? BoxDecoration(
                                              color: colororangeLight,
                                              borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                            )
                                                : BoxDecoration(
                                              color: Colors.blueGrey.withOpacity(0.1),
                                              borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                topLeft: Radius.circular(10),
                                                bottomRight: Radius.circular(10),
                                              ),
                                            ),
                                            child: SelectableText(
                                              (model.chatconversiondata[index]['chat_message']).toString(),
                                              style: TextStyle(color: model.chatconversiondata[index]['from_user_id'].toString() == model.ourSanderid ? Colors.white : Colors.black, fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      if (model.chatconversiondata[index]['message_type'] == "image")
                                        Align(
                                          alignment: model.chatconversiondata[index]['from_user_id'].toString() == model.ourSanderid ? Alignment.topRight : Alignment.topLeft,
                                          child: InkWell(
                                            onTap: () {
                                              final imageProvider = NetworkImage(model.chatconversiondata[index]['chat_message'].toString());
                                              showImageViewer(
                                                immersive: false,
                                                context,
                                                imageProvider,
                                                doubleTapZoomable: true,
                                                closeButtonColor: Colors.white,
                                                swipeDismissible: true,
                                                backgroundColor: Colors.grey.withOpacity(0.7),
                                                onViewerDismissed: () {
                                                  debugPrint("dismissed");
                                                },
                                              );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              margin: const EdgeInsets.all(5),
                                              width: 200,
                                              height: 200,
                                              decoration: model.chatconversiondata[index]['from_user_id'].toString() == model.ourSanderid
                                                  ? BoxDecoration(
                                                color: colororangeLight,
                                                borderRadius: const BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft: Radius.circular(10),
                                                ),
                                              )
                                                  : BoxDecoration(
                                                color: Colors.blueGrey.withOpacity(0.1),
                                                borderRadius: const BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                ),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: (model.chatconversiondata[index]['chat_message']).toString(),
                                                placeholder: (context, url) {
                                                  return const CircularProgressIndicator();
                                                },
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          ),
                                        ),
                                      Align(
                                        alignment: model.chatconversiondata[index]['from_user_id'].toString() == model.ourSanderid ? Alignment.topRight : Alignment.topLeft,
                                        child: Row(
                                          mainAxisAlignment: model.chatconversiondata[index]['from_user_id'].toString() == model.ourSanderid ? MainAxisAlignment.end : MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                right: 4,
                                              ),
                                              child: Text(
                                                ((model.chatconversiondata[index]['message_date'] ?? '') + ' ' + model.chatconversiondata[index]['message_time']).toString(),
                                                style: TextStyle(
                                                  color: model.chatconversiondata[index]['from_user_id'].toString() == model.ourSanderid ? Colors.black : Colors.black,
                                                  fontSize: 8,
                                                ),
                                              ),
                                            ),
                                            if (model.chatconversiondata[index]['from_user_id'].toString() == model.ourSanderid)
                                              const Icon(
                                                Icons.done_all_rounded,
                                                size: 15,
                                                color: Colors.blueAccent,
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        if (isTyping)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(top: 5, left: 20, bottom: 15),
                              alignment: AlignmentDirectional.center,
                              height: 40,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.1),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Typing...',
                              ),
                            ),
                          ),
                        widget.isForHistory == false || isAstrologer
                            ? Container(
                          // margin: const EdgeInsets.only(top: 20),
                          child: chattingTypingWidgetBottom(
                            context,
                            chatModel,
                            socket,
                          ),
                        )
                            : Container(),
                      ],
                    ),
                  );
                },
              ),

            ],
          ),
        ),
        // bottomSheet: widget.isForHistory == false || isAstrologer
        //     ? Container(
        //         margin: const EdgeInsets.only(top: 20),
        //         child: chattingTypingWidgetBottom(
        //           context,
        //           chatModel,
        //           socket,
        //         ),
        //       )
        //     : Container(),
      ),
    );
  }

  closeNavigation(bool fromWallet) {
    endChat("called from close Navigation function", fromWallet);
  }

  showEndChatDialog(bool fromWallet) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: const Text('Are you sure to end chat?'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colororangeLight,
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  closeNavigation(fromWallet);
                },
                child: const Text('Yes'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colororangeLight,
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('No'),
              ),
            ],
          );
        });
  }

  Future<void> endChat(String message, bool fromWallet) async {
    debugPrint("$TAG end chat called =========> $message");
    chatModel!.typingmessage.removeListener(() {});

    if (!isAstrologer) {
      timer!.cancel();
      var data = {
        "receiver_id": chatModel!.reseverid,
        "sender_id": chatModel!.ourSanderid,
        "astro_id": chatModel!.reseverid,
        "user_id": chatModel!.ourSanderid,
        "source": "mobile",
      };
      socket!.emit("force_disconnect", data);
    } else {
      var data = {
        "sender_id": chatModel!.ourSanderid,
        "receiver_id": chatModel!.reseverid,
        "astro_id": chatModel!.ourSanderid,
        "user_id": chatModel!.reseverid,
        "source": "mobile",
      };
      socket!.emit("force_disconnect", data);
    }

    Future.delayed(const Duration(milliseconds: 300), () async {
      socket!.clearListeners();
      socket!.dispose();

      if (!isAstrologer) {
        int durationMinute = Duration(seconds: timerProvider!.getRemainingTime()).inMinutes;
        int mins = chatModel!.chatTime! - durationMinute;
        debugPrint("$TAG min =========> $mins");
        if (mins > 0) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("is_free", "0");

          await chatModel!.walletRemoveBalance(mins, widget.perMinute, chatModel!.reseverid, startTime, chatModel!.reseverName);
        }
        chatModel!.updateChatStatus(chatModel!.reseverid, chatModel!.chatTime!, false);
      }
      debugPrint("$TAG end chat called Bottom Nav Bar Page");
      if (mounted) {
        setState(() {
          isChatConnected = false;
        });
      }
      if (isAstrologer) {
        Future.delayed(const Duration(milliseconds: 100), () {
          Get.offUntil(
            MaterialPageRoute(
              builder: (context) {
                return const BottomNavBarPage(
                  toChat: true,
                );
              },
            ),
                (route) {
              return false;
            },
          );
        });
      } else {
        Future.delayed(const Duration(milliseconds: 100), () {
          Get.offUntil(
            MaterialPageRoute(
              builder: (context) {
                return RatingPage(
                  astroId: chatModel!.reseverid.toString(),
                  fromWallet: fromWallet,
                );
              },
            ),
                (route) {
              return false;
            },
          );
        });
      }
    });
  }

  Future<void> endChatFromSocket() async {
    debugPrint("$TAG end Chat From Socket called =========>");

    chatModel!.typingmessage.removeListener(() {});
    socket!.dispose();

    if (!isAstrologer) {
      timer!.cancel();
      int durationMinute = Duration(seconds: timerProvider!.getRemainingTime()).inMinutes;
      int min = chatModel!.chatTime! - durationMinute;
      debugPrint("$TAG total min used in chat ==========> $min");
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("is_free", "0");
      if (min > 0) {
        await chatModel!.walletRemoveBalance(min, widget.perMinute, chatModel!.reseverid, startTime, chatModel!.reseverName);
      }
      await chatModel!.updateChatStatus(chatModel!.reseverid, chatModel!.chatTime!, false);
    }
    debugPrint("$TAG end chat called Bottom Nav Bar Page");
    setState(() {
      isChatConnected = false;
    });
    if (isAstrologer) {
      Future.delayed(const Duration(milliseconds: 100), () {
        Get.offUntil(
          MaterialPageRoute(
            builder: (context) {
              return const BottomNavBarPage(
                toChat: true,
              );
            },
          ),
              (route) {
            return false;
          },
        );
      });
    } else {
      Future.delayed(const Duration(milliseconds: 100), () {
        Get.offUntil(
          MaterialPageRoute(
            builder: (context) {
              return RatingPage(
                astroId: chatModel!.reseverid.toString(),
                fromWallet: false,
              );
            },
          ),
              (route) {
            return false;
          },
        );
      });
    }
  }

  Container chattingTypingWidgetBottom(BuildContext context, ChatRoomModel? model, IO.Socket? socket) {
    return Container(
      constraints: const BoxConstraints(minHeight: 60),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(color: colorsanderchat),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          selectImageForUpload(context, model, socket),
          typingChatBox(context, model),
          Container(
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              color: colororangeLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () async {
                model?.conversionTypingSubmit(context, socket);
              },
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget typingChatBox(BuildContext context, ChatRoomModel? model) {
    return Expanded(
      child: TextField(
        controller: model?.typingmessage,
        enabled: true,
        textAlign: TextAlign.left,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 4,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
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

  String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void showBottomSheetPopUp(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 70.w,
                    child: const Text(
                      "Your wallet amount is low please recharge your wallet account",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Container(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: const Text(
                'Select Amount',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              height: 0.5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: const Text(
                'Tip: 90% users choose for 100 rupees or more',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: InkWell(
                onTap: () {
                  debugPrint("$TAG show end chat dialog ===========>");
                  Navigator.pop(context);
                  showEndChatDialog(true);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      height: 5.h,
                      width: 20.w,
                      alignment: Alignment.center,
                      child: const Text(
                        '₹ 20',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      height: 5.h,
                      width: 20.w,
                      alignment: Alignment.center,
                      child: const Text(
                        '₹ 50',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      height: 5.h,
                      width: 20.w,
                      alignment: Alignment.center,
                      child: const Text(
                        '₹ 100',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      height: 5.h,
                      width: 20.w,
                      alignment: Alignment.center,
                      child: const Text(
                        '₹ 200',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 2.h,
            ),
          ],
        );
      },
    );
  }

  Widget appbarChatScreen(BuildContext context, String title) {
    return AppBar(
      leadingWidth: 36,
      toolbarHeight: 34,
      leading: backButtonLeading(context),
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
      actions: [
        if (userType == "2")
          InkWell(
            onTap: () async {
              await getWaitList(context);
            },
            child: SizedBox(
              width: 25,
              height: 25,
              child: ImageIcon(
                const AssetImage(
                  'assets/images/wait_icon.png',
                ),
                color: colororangeLight,
              ),
            ),
          ),
        const SizedBox(width: 10),
        if (userType == "2")
          InkWell(
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) => GenerateKundliPage(showBackButton: true)));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: colororangeLight, width: 1),
              ),
              width: 30,
              height: 30,
              padding: const EdgeInsets.all(5.0),
              child: Image.asset('assets/icons/Freekundli.png', color: colororangeLight),
            ),
          ),
      ],
    );
  }

  Widget backButtonLeading(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10),



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
                showEndChatDialog(false);
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

  Widget selectImageForUpload(BuildContext context, ChatRoomModel? model, IO.Socket? socket) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      child: IconButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (context, StateSetter setState) {
                  return Container(
                    height: 150,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CupertinoButton(
                          color: colororangeLight,
                          child: const Text("Open Gallery"),
                          onPressed: () {
                            Navigator.pop(context);

                            model!.selectImages("Gallery", socket);
                          },
                        ),
                        sizedboxheight(5.0),
                        CupertinoButton(
                          color: colororangeLight,
                          child: const Text("Open Camera"),
                          onPressed: () {
                            Navigator.pop(context);
                            model!.selectImages("Camera", socket);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
        icon: const Icon(
          Icons.attach_file,
          size: 20,
        ),
      ),
    );
  }

  getWaitList(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userId = pref.getString("login_user_id");

    Dio dio = Dio();
    FormData formData = FormData.fromMap({"astro_id": userId});
    var response = await dio.post("${baseURL}get_waiting_list", data: formData);
    final responseData = json.decode(response.toString());

    debugPrint("$TAG waiting list id responseData =======> $responseData");

    try {
      if (responseData['status']) {
        List<dynamic> dataList = [];
        for (int i = 0; i < responseData['data'].length; i++) {
          dataList.add(responseData['data'][i]);
        }
        if (context.mounted) {
          if (dataList.isNotEmpty) {
            waitListCountDialog(context, "Currently 0 users are waiting");
          } else {
            waitListCountDialog(context, "Currently ${dataList.length} users are waiting");
          }
        }
        debugPrint('$TAG astrologer wait list count ===========> ${dataList.length}');
        setState(() {});
      } else {
        setState(() {});
      }
    } catch (e) {
      setState(() {});
      debugPrint("$TAG error getWaitCustomersList =======> ${e.toString()}");
    }
  }
}