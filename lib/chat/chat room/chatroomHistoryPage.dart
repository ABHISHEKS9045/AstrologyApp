import 'dart:async';

import 'package:astrologyapp/chat/chat%20room/ChatHistoryProvider.dart';
import 'package:astrologyapp/common/appbar/chatpageAppbar.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../common/shimmereffect.dart';

class ChatRoomHistoryPage extends StatefulWidget {
  String userName;
  String astroId;
  String userId;

  ChatRoomHistoryPage({
    super.key,
    required this.userName,
    required this.astroId,
    required this.userId,
  });

  @override
  ChatRoomHistoryPageState createState() => ChatRoomHistoryPageState();
}

class ChatRoomHistoryPageState extends State<ChatRoomHistoryPage> {
  String TAG = "_ChatRoomHistoryPageState";
  String? userId;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(const Duration(seconds: 1));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('login_user_id');
      if (mounted && userId != null) {
        var model = Provider.of<ChatHistoryProvider>(context, listen: false);
        if (userId == widget.userId) {
          model.loadChatHistory(widget.userId, widget.astroId);
        } else {
          model.loadChatHistory(widget.astroId, widget.userId);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ChatHistoryProvider>(
        builder: (BuildContext context, ChatHistoryProvider model, _) {
          return model.isLoading
              ? loadingwidget()
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: deviceWidth(context, 1.0),
                  height: deviceheight(context, 1.0),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/BackGround.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    children: [
                      sizedboxheight(5.0),
                      appBarChatHistory(
                        context,
                        widget.userName.toUpperCase(),
                        closeNavigation,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Expanded(
                        child: model.historyList.reversed.isNotEmpty
                            ? ListView.builder(
                                controller: scrollController,
                                itemCount: model.historyList.reversed.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(5),
                                    decoration: model.historyList[index]['from_user_id'].toString() != userId!
                                        ? const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                          )
                                        : const BoxDecoration(
                                            // color: Colors.blueGrey.withOpacity(0.1),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                    child: Column(
                                      crossAxisAlignment: model.historyList[index]['from_user_id'].toString() != userId! ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                                      children: [
                                        if(model.historyList[index]['message_type'] == 'image')
                                          Align(
                                          alignment: model.historyList[index]['from_user_id'].toString() == userId! ? Alignment.topRight : Alignment.topLeft,
                                          child: InkWell(
                                            onTap: () {
                                              final imageProvider = NetworkImage(model.historyList[index]['chat_message'].toString());
                                              showImageViewer(
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
                                              decoration: model.historyList[index]['from_user_id'].toString() == userId!
                                                  ? BoxDecoration(
                                                      color: colororangeLight,
                                                      borderRadius: const BorderRadius.only(
                                                        topRight: Radius.circular(10),
                                                        topLeft: Radius.circular(10),
                                                        bottomRight: Radius.circular(10),
                                                      ),
                                                    )
                                                  : BoxDecoration(
                                                      color: Colors.blueGrey.withOpacity(0.1),
                                                      borderRadius: const BorderRadius.only(
                                                        topRight: Radius.circular(10),
                                                        topLeft: Radius.circular(10),
                                                        bottomLeft: Radius.circular(10),
                                                      ),
                                                    ),
                                              child: CachedNetworkImage(
                                                imageUrl: (model.historyList[index]['chat_message']).toString(),
                                                placeholder: (context, url) {
                                                  return const CircularProgressIndicator();
                                                },
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          ),
                                        ),
                                        if(model.historyList[index]['message_type'] == 'text')
                                          Align(
                                            alignment: model.historyList[index]['from_user_id'].toString() == userId! ? Alignment.topRight : Alignment.topLeft,
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              margin: const EdgeInsets.all(5),
                                              decoration: model.historyList[index]['from_user_id'].toString() == userId!
                                                  ? BoxDecoration(
                                                color: colororangeLight,
                                                borderRadius: const BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                ),
                                              )
                                                  : BoxDecoration(
                                                color: Colors.blueGrey.withOpacity(0.1),
                                                borderRadius: const BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft: Radius.circular(10),
                                                ),
                                              ),
                                              child: Text(
                                                (model.historyList[index]['chat_message']).toString(),
                                                style: TextStyle(
                                                  color: model.historyList[index]['from_user_id'].toString() == userId! ? Colors.white : Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        Align(
                                          alignment: model.historyList[index]['from_user_id'].toString() == userId! ? Alignment.topRight : Alignment.topLeft,
                                          child: Row(
                                            mainAxisAlignment: model.historyList[index]['from_user_id'].toString() == userId! ? MainAxisAlignment.end : MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  right: 4,
                                                ),
                                                child: Text(
                                                  ((model.historyList[index]['message_date'] ?? '') + ' ' + model.historyList[index]['message_time']).toString(),
                                                  style: TextStyle(
                                                    color: model.historyList[index]['from_user_id'].toString() == userId! ? Colors.black : Colors.black,
                                                    fontSize: 8,
                                                  ),
                                                ),
                                              ),
                                              if (model.historyList[index]['from_user_id'].toString() == userId!)
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
                                },
                              )
                            : const Center(
                                child: Text(
                                  "No data available",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }

  void closeNavigation() {
    Get.back();
  }
}
