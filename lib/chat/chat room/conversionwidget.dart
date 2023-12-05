import 'package:astrologyapp/common/styles/const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ChatRoomModel.dart';

class ChatRoomConversionWidget extends StatefulWidget {
  const ChatRoomConversionWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatRoomConversionWidget> createState() => _ChatRoomConversionWidgetState();
}

class _ChatRoomConversionWidgetState extends State<ChatRoomConversionWidget> {
  ScrollController scrollController = ScrollController();
  ScrollController scrollController1 = ScrollController();

  bool isScroll = false;
  int msgLength = 0;
  int msgLengthTemp = 0;
  int msgLengthTemp1 = 0;

  void scrollToNewData(int duration) {
    scrollController1.animateTo(
      scrollController1.position.maxScrollExtent,
      duration: Duration(milliseconds: duration),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ChatRoomModel>(builder: (BuildContext context, ChatRoomModel model, _) {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 10),
          );
        }

        return ListView.builder(
            controller: isScroll? scrollController1 : scrollController,
            itemCount: model.chatconversiondata.length,
            padding: const EdgeInsets.only(bottom: 20),
            itemBuilder: (context, index) {
              msgLength = model.chatconversiondata.length;
              print(msgLength);
              if(msgLengthTemp != msgLength ){
                msgLengthTemp1 = msgLengthTemp;
                msgLengthTemp = msgLength;
                isScroll = true;

                  scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 500),
                  );

              }
              // else if(msgLengthTemp == msgLength){
              //   isScroll = false;
              // }


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
            });
      }),
    );
  }
}
