import 'dart:async';

import 'package:astrologyapp/chat/chatlist/chatlistmodelpage.dart';
import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/shimmereffect.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../common/MaterialDesignIndicator.dart';
import '../../common/bottomnavbar/bottomnavbar.dart';
import '../../common/commonwidgets/button.dart';
import '../../common/formtextfield/myTextField.dart';
import '../chat room/chatroomHistoryPage.dart';
import 'ChatListScreenWidget.dart';

class ChatingListPage extends StatefulWidget {
  final isCall;

  const ChatingListPage({super.key, this.isCall});

  @override
  State<ChatingListPage> createState() => _ChatingListPageState();
}

class _ChatingListPageState extends State<ChatingListPage> with SingleTickerProviderStateMixin {
  String TAG = "_ChatingListPageState";

  final formKey = GlobalKey<FormState>();
  String? usertype;

  TextEditingController waitListController = TextEditingController();

  late TabController _tabController;
  final _tabs = [
    const Tab(text: 'Wait List'),
    const Tab(text: 'Chat History'),
  ];

  Timer? _timer;
  var _start = 0.obs;

  int tabSelectedIndex = 0;

  void dismissTimer() {
    _timer?.cancel();
  }
  Future<void> setUserIsBusyFirebase(int is_busy) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');

    String? userKey = "users_$userid";
    var postData = {"id": userid, "is_busy": is_busy, "status": "Online"};
    FirebaseDatabase.instance.ref(userKey).set(postData);
  }


  void startTimer1() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            if (timerboolValue == true) {
              if (mounted) {
                debugPrint("$TAG startTimer() redirect to home page");
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
              }
            }
          });
        } else {
          _start--;
        }
      },
    );
  }

  String name = "";
  String remainingTime = '';

  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(const Duration(seconds: 1));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      usertype = prefs.getString('user_type');
      name = prefs.getString("name").toString();
      setState(() {});
      var list = Provider.of<Chatlistmodelpage>(context, listen: false);
      if (mounted) {
        if (usertype == "1") {
          await list.chatUserListForChat(context: context, categoryId: 0);
          await list.getWalletBalance(context);
        } else {
          await list.getWaitCustomersList(context: context, type: "Chat");
          await list.getChatHistoryList(context);
        }
      }

      _tabController.addListener(() async {
        debugPrint("$TAG controller index =======> ${_tabController.index}");

        if (_tabController.index != tabSelectedIndex) {
          debugPrint("$TAG before update tabSelectedIndex ===========> $tabSelectedIndex");
          setState(() {
            tabSelectedIndex = _tabController.index;
          });
          debugPrint("$TAG after update tabSelectedIndex ===========> $tabSelectedIndex");
          if (_tabController.index == 0) {
            await list.getWaitCustomersList(context: context, type: "Chat");
          } else if (_tabController.index == 1) {
            await list.getChatHistoryList(context);
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    dismissTimer();
    super.dispose();
    debugPrint("$TAG on dispose called");
  }

  @override
  void deactivate() {
    dismissTimer();
    super.deactivate();
    debugPrint("$TAG on deactivate called");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          bgImagecommon(context),
          SingleChildScrollView(
            child: Column(
              children: [
                AppBar(
                  leading: Container(),
                  backgroundColor: Colors.transparent,
                  title: Text(
                    usertype == '1' ? 'ASTROLOGERS' : 'CUSTOMERS',
                    style: textstyletitleHeading6(context)!.copyWith(color: colorWhite, fontWeight: fontWeight900, letterSpacing: 1, fontSize: 20),
                  ),
                ),
                sizedboxheight(56.0),
                Consumer<Chatlistmodelpage>(
                  builder: (BuildContext context, Chatlistmodelpage model, _) {
                    return usertype == '1'
                        ? Container(
                            width: deviceWidth(context, 1.0),
                            padding: const EdgeInsets.only(left: padding20, right: padding20, top: padding20),
                            decoration: decorationtoprounded(),
                            child: RefreshIndicator(
                              color: colororangeLight,
                              onRefresh: () async {
                                if (mounted) {
                                  var list = Provider.of<Chatlistmodelpage>(context, listen: false);
                                  await list.chatUserListForChat(context: context, categoryId: 0);
                                  await list.getWalletBalance(context);
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  model.isShimmer
                                      ? Container(
                                          margin: EdgeInsets.only(top: 20.h),
                                          child: loadingwidget(),
                                        )
                                      : ChatListScreenWidget(model: model, isCall: widget.isCall),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            width: deviceWidth(context, 1.0),
                            height: deviceheight(context, 0.72),
                            padding: const EdgeInsets.only(left: padding20, right: padding20, top: padding20),
                            decoration: decorationtoprounded(),
                            child: RefreshIndicator(
                              color: colororangeLight,
                              onRefresh: () async {
                                if (mounted) {
                                  var list = Provider.of<Chatlistmodelpage>(context, listen: false);
                                  await list.getWaitCustomersList(context: context, type: "Chat");
                                  await list.getChatHistoryList(context);
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TabBar(
                                    controller: _tabController,
                                    labelColor: Colors.black,
                                    unselectedLabelColor: Colors.grey,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    indicator: MaterialDesignIndicator(
                                      indicatorHeight: 4,
                                      indicatorColor: colororangeLight,
                                    ),
                                    tabs: _tabs,
                                    labelStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    unselectedLabelStyle: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  sizedboxheight(10.0),
                                  Expanded(
                                    child: TabBarView(
                                      controller: _tabController,
                                      children: [
                                        model.isShimmer
                                            ? Container(
                                                margin: EdgeInsets.only(top: 20.h),
                                                child: loadingwidget(),
                                              )
                                            : waitListForAstrologer(model),
                                        model.isShimmer
                                            ? Container(
                                                margin: EdgeInsets.only(top: 20.h),
                                                child: loadingwidget(),
                                              )
                                            : chatHistoryListWidget(context, model),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget chatHistoryListWidget(BuildContext context, Chatlistmodelpage model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        model.chatHistoryList.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: deviceheight(context, 0.6),
                    child: Center(
                      child: Text(
                        'No History Found',
                        style: textstyleHeading3(context),
                      ),
                    ),
                  ),
                ],
              )
            : Flexible(
                child: ListView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: model.chatHistoryList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var dur, startTime = '',endTime = '', chatDate = "";
                    if (model.chatHistoryList[index]['duration'] != null) dur = model.chatHistoryList[index]['duration'];
                    if (model.chatHistoryList[index]['start_time'] != null) startTime = model.chatHistoryList[index]['start_time'].toString();
                    if (model.chatHistoryList[index]['end_time'] != null) endTime = model.chatHistoryList[index]['end_time'].toString();
                    if (model.chatHistoryList[index]['chat_date'] != null) chatDate = model.chatHistoryList[index]['chat_date'].toString();
                    return InkWell(
                      onTap: () {
                        Get.to(() {
                          return ChatRoomHistoryPage(
                            userName: model.chatHistoryList[index]['name'],
                            astroId: model.chatHistoryList[index]['astro_id'],
                            userId: model.chatHistoryList[index]['user_id'],
                          );
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(15.0),
                        width: deviceWidth(context, 1.0),
                        decoration: BoxDecoration(
                          color: colorWhite,
                          borderRadius: BorderRadius.circular(15),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.chatHistoryList[index]['name'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.0.h,
                                ),
                                Text(
                                  'Duration: $dur',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Start Time: ${formatOnlyDate(chatDate)} $startTime',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'End Time: ${formatOnlyDate(chatDate)} $endTime',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: model.userType == '1'
                                  ? Text(
                                      "- ₹ ${model.chatHistoryList[index]['deduction_amount']}",
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red),
                                    )
                                  : Text(
                                      '+ ₹ ${model.chatHistoryList[index]["astro_earning_amount"] ?? ''}',
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.green),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }

  Widget waitListForAstrologer(Chatlistmodelpage model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedboxheight(10.0),
        Row(
          children: [
            Expanded(
              child: AllInputDesign(
                controller: waitListController,
                fillColor: colorWhite,
                hintText: 'Search',
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: colororangeLight,
                ),
                focusedBorderColor: colorblack.withOpacity(0.1),
                enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
                keyBoardType: TextInputType.text,
                onChanged: (String value) {
                  if (waitListController.text.isNotEmpty) {
                    model.searchUsersInChatWaitList(value);
                  } else {
                    model.setActualWaitChatList();
                  }
                },
              ),
            ),
          ],
        ),
        sizedboxheight(10.0),
        Flexible(
          child: model.waitListForAstrologer.isNotEmpty
              ? ListView.builder(
                  itemCount: model.waitListForAstrologer.length,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10, top: 10),
                      width: deviceWidth(context, 1.0),
                      decoration: BoxDecoration(
                        color: colorWhite,
                        borderRadius: BorderRadius.circular(15),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 9.h,
                                  height: 9.h,
                                  child: ClipOval(
                                    child: model.waitListForAstrologer[index]['profile_image'] != null
                                        ? Image.network(
                                            imageURL + model.waitListForAstrologer[index]['profile_image'],
                                            errorBuilder: (context, url, error) => const Image(
                                              image: AssetImage('assets/images/user.png'),
                                              fit: BoxFit.cover,
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : const Image(
                                            image: AssetImage('assets/images/user.png'),
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  SizedBox(
                                    width: 50.w,
                                    child: Text(
                                      model.waitListForAstrologer[index]['name'].toString(),
                                      maxLines: 1,
                                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: HexColor('#000000'),
                                          ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 42.w,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              (model.waitListForAstrologer[index]['dob'].toString() == 'null') ? '' : 'DOB: ' + model.waitListForAstrologer[index]['dob'],
                                              style: TextStyle(fontSize: 15, color: HexColor('#979797')),
                                            ),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Text(
                                              model.waitListForAstrologer[index]['birth_time'].toString() == 'null' ? '' : 'Birth Time: ' + model.waitListForAstrologer[index]['birth_time'],
                                              style: TextStyle(fontSize: 15, color: HexColor('#979797')),
                                            ),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Text(
                                              model.waitListForAstrologer[index]['birth_place'].toString() == 'null' ? '' : 'Birth Place: ' + model.waitListForAstrologer[index]['birth_place'],
                                              style: TextStyle(fontSize: 15, color: HexColor('#979797')),
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              if (index == 0)
                                InkWell(
                                  onTap: () async {

                                    print("object");
                                    setUserIsBusyFirebase(1);
                                    // http://134.209.229.112/astrology/api/send_user_chat_request
                                    // request_id:5
                                    model.acceptUserWaitChatRequest(context, model.waitListForAstrologer[index]["id"], "chat");

                                    _start.value = 1000;
                                    timerboolValue = true;
                                    startTimer1();

                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(builder: (context, setState) {
                                            return buildPopupDialog(context, model, index);
                                          });
                                        });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: HexColor('#EFEFEF'),
                                          spreadRadius: 1,
                                          blurRadius: 8,
                                          offset: const Offset(0, 0.3), // changes position of shadow
                                        )
                                      ],
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(8.0),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: HexColor('#EFEFEF'), width: 1),
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              if (index == 0)
                                InkWell(
                                  onTap: () async {
                                    // http://134.209.229.112/astrology/api/reject_user_chat_request
                                    // request_id:5
                                    model.rejectWaitRequest(context, model.waitListForAstrologer[index]["id"], "chat");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: HexColor('#EFEFEF'),
                                          spreadRadius: 1,
                                          blurRadius: 8,
                                          offset: const Offset(0, 0.3), // changes position of shadow
                                        )
                                      ],
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(8.0),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffff0000),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: HexColor('#EFEFEF'), width: 1),
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              if (index > 0)
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: HexColor('#EFEFEF'),
                                        spreadRadius: 1,
                                        blurRadius: 8,
                                        offset: const Offset(0, 0.3), // changes position of shadow
                                      )
                                    ],
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.all(8.0),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: HexColor('#EFEFEF'), width: 1),
                                    ),
                                    child: Icon(
                                      Icons.access_time,
                                      color: colororangeLight,
                                      size: 25,
                                    ),
                                  ),
                                ),
                            ],
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
        ),
      ],
    );
  }

  buildPopupDialog(BuildContext context, Chatlistmodelpage model, int index) {
    String customerName = model.waitListForAstrologer[index]['name'].toString();

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Column(
        children: [
          Visibility(
            visible: false,
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  dismissTimer();
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.clear,
                ),
              ),
            ),
          ),
          const Center(
            child: Text(
              "You are all set",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 9.h,
                    height: 9.h,
                    child: const ClipOval(
                      child: Image(
                        image: AssetImage('assets/images/user.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 23.w,
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: 45,
                width: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/icons/connecting.gif',
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          '$imageURL${model.waitListForAstrologer[index]['profile_image']}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 18.w,
                    child: Text(
                      customerName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          sizedboxheight(15.0),
          Obx(() {
            return RichText(
              text: TextSpan(
                text: 'You will be connecting with $customerName in ',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: '${_start}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
      actions: [
        okBtn(context, () {
          Fluttertoast.showToast(msg: "if in case customer will be not available for or unable to accept your request until your request will be automatically closed after 2 minute.");
        }),
        sizedboxheight(12.0),
      ],
    );
  }

  Widget okBtn(BuildContext context, onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Button(
        btnWidth: deviceWidth(context, 1.0),
        btnHeight: 40,
        buttonName: 'Waiting...',
        key: const Key('ok'),
        borderRadius: BorderRadius.circular(8.0),
        btnColor: Colors.green,
        onPressed: onTap,
      ),
    );
  }

  String formatOnlyDate(String dateToFormat) {
    if(dateToFormat != null && dateToFormat != "null" && dateToFormat != "") {
      DateTime dateTime = DateFormat("yyyy-MM-dd").parse(dateToFormat);
      debugPrint("date Time ========> ${dateTime.toString()}");
      String formattedDate = DateFormat("dd-MM-yyyy").format(dateTime);
      debugPrint("formatted Date =========> $formattedDate");
      return formattedDate;
    } else {
      return "";
    }
  }
}
