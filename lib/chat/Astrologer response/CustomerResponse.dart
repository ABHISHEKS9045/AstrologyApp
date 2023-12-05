import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../common/bottomnavbar/bottomnavbar.dart';
import '../../common/commonwidgets/commonWidget.dart';
import '../../common/styles/const.dart';
import '../../login Page/loginpageWidget.dart';
import '../chatlist/chatlistmodelpage.dart';

class CustomerResponse extends StatefulWidget {
  final String requestType;
  final int requestId;
  final int receiverId;
  final int senderId;
  final String userName;
  final String userImage;
  final int perMinute;
  final String phoneNo;

  const CustomerResponse({
    Key? key,
    required this.requestType,
    required this.requestId,
    required this.receiverId,
    required this.senderId,
    required this.userName,
    required this.userImage,
    required this.perMinute,
    required this.phoneNo,
  }) : super(key: key);

  @override
  State<CustomerResponse> createState() => _CustomerResponseState();
}

class _CustomerResponseState extends State<CustomerResponse> {
  String TAG = "_CustomerResponseState";

  Widget appBarNavigation(context, title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 18),
      width: deviceWidth(context, 1.0),
      height: 70,
      child: Row(
        children: [
          Container(
            child: backButton(context),
          ),
          Container(
            alignment: Alignment.center,
            width: deviceWidth(context, 0.8),
            child: Text(
              title,
              style: textstyletitleHeading6(context)!.copyWith(
                color: colorWhite,
                fontWeight: fontWeight900,
                letterSpacing: 1,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget backButton(context) {
    return Container(
      width: 34,
      height: 32,
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorgreyblack.withOpacity(0.1),
        ),
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
              Get.to(() => BottomNavBarPage());
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: colorblack,
              size: 17,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) async {
      debugPrint("$TAG addPostFrameCallback timeStamp ========> $timeStamp");
      Future.delayed(const Duration(seconds: 1));
      var model = Provider.of<Chatlistmodelpage>(context, listen: false);
      await model.getWalletBalance(context);
      await model.profileView(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Chatlistmodelpage>(builder: (BuildContext context, Chatlistmodelpage model, _) {
      return Scaffold(
        body: Stack(
          children: [
            bgImagecommon(context),
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  sizedboxheight(20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: appBarNavigation(context, "Incoming request"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(padding20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: decorationtoprounded(),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            child: Text(
                              widget.requestType == "Call" ? "Incoming Call request from " : "Incoming Chat request from ",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: Text(
                              widget.userName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 23,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 120,
                              bottom: 70,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      bottom: 12,
                                      top: 0,
                                    ),
                                    height: 150,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          widget.userImage,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    widget.userName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 23,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: HexColor('#F9921F'),
                            ),
                            margin: const EdgeInsets.only(bottom: 15),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              onPressed: () {
                                if (int.parse(model.walletAmount.toString()) > widget.perMinute) {
                                  if (widget.requestType == "Call") {
                                    int time = (int.parse(model.walletAmount.toString()) / widget.perMinute).toInt();
                                    debugPrint("$TAG click on start call");
                                    model.initiateCall(context, widget.phoneNo, widget.senderId.toString(), widget.perMinute.toString(), time);
                                    Future.delayed(const Duration(seconds: 1), () {
                                      if (mounted) {
                                        Get.offUntil(MaterialPageRoute(
                                          builder: (context) {
                                            return BottomNavBarPage();
                                          },
                                        ), (route) => false);
                                      }
                                    });
                                  } else {
                                    debugPrint("$TAG click on start chat");
                                    int time = (int.parse(model.walletAmount.toString()) / widget.perMinute).toInt();
                                    model.customerAcceptChatRequest(context, widget.requestId, widget.senderId, widget.perMinute, time, widget.userName);
                                  }
                                } else {
                                  Fluttertoast.showToast(msg: widget.requestType == "Call" ? "You don't have sufficient balance for call" : "You don't have sufficient balance for chat");
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    widget.requestType == "Call" ? Icons.call : Icons.message,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  sizedboxwidth(8.0),
                                  Text(
                                    widget.requestType == "Call" ? 'Start Call' : 'Start Chat',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                debugPrint("$TAG click on reject chat");
                                model.customerRejectChatRequest(widget.requestId);
                              },
                              child: Text(
                                widget.requestType == "Call" ? 'Reject Call Request' : 'Reject Chat Request',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
