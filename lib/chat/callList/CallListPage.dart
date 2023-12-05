import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../common/MaterialDesignIndicator.dart';
import '../../common/commonwidgets/commonWidget.dart';
import '../../common/formtextfield/myTextField.dart';
import '../../common/shimmereffect.dart';
import '../../common/styles/const.dart';
import '../../login Page/loginpageWidget.dart';
import '../chatlist/ChatListScreenWidget.dart';
import '../chatlist/chatlistmodelpage.dart';

class CallListPage extends StatefulWidget {
  final isCall;

  CallListPage({this.isCall});

  @override
  State<CallListPage> createState() => _CallListPageState();
}

class _CallListPageState extends State<CallListPage> with SingleTickerProviderStateMixin {
  String TAG = "_CallListPageState";

  TextEditingController waitListController = TextEditingController();
  String? usertype;
  late TabController _tabController;
  bool showTab = false;
  final _tabs = [
    const Tab(text: 'Wait List'),
    const Tab(text: 'Call History'),
  ];

  int tabSelectedIndex = 0;

  @override
  void initState() {
    getUserType();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var list = Provider.of<Chatlistmodelpage>(context, listen: false);
      await list.getCallHistoryList(context);
      await list.getWaitCustomersList(context: context, type: "Call");
      await list.chatUserListForCall(context: context, categoryId: 0);
      await list.getWalletBalance(context);

      _tabController.addListener(() async {
        debugPrint("$TAG controller index =======> ${_tabController.index}");

        if (_tabController.index != tabSelectedIndex) {
          debugPrint("$TAG before update tabSelectedIndex ===========> $tabSelectedIndex");
          setState(() {
            tabSelectedIndex = _tabController.index;
          });
          debugPrint("$TAG after update tabSelectedIndex ===========> $tabSelectedIndex");
          if (_tabController.index == 0) {
            await list.getWaitCustomersList(context: context, type: "Call");
          } else if (_tabController.index == 1) {
            await list.getCallHistoryList(context);
          }
        }
      });
    });
    super.initState();
  }

  getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      usertype = prefs.getString('user_type');
      debugPrint("$TAG getUserType =======> $usertype");
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          bgImagecommon(context),
          SingleChildScrollView(
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              children: [
                AppBar(
                  leading: Container(),
                  backgroundColor: Colors.transparent,
                  title: Text(
                    usertype == '1' ? 'ASTROLOGERS' : 'CUSTOMERS',
                    style: textstyletitleHeading6(context)!.copyWith(color: colorWhite, fontWeight: fontWeight900, letterSpacing: 1, fontSize: 20),
                  ),
                ),
                sizedboxheight(35.0),
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
                                  await list.chatUserListForCall(
                                    context: context,
                                    categoryId: 0,
                                  );
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
                              onRefresh: () async {
                                if (mounted) {
                                  var list = Provider.of<Chatlistmodelpage>(context, listen: false);
                                  await list.getCallHistoryList(context);
                                  await list.getWaitCustomersList(context: context, type: "Call");
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
                                            : callHistoryForAstrologer(context, model),
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
                                    child: Image.network(
                                      imageURL + model.waitListForAstrologer[index]['profile_image'],
                                      errorBuilder: (context, url, error) => const Image(
                                        image: AssetImage('assets/images/1.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                              ],
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 1.h),
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
                                SizedBox(height: 1.h),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 42.w,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            (model.waitListForAstrologer[index]['dob'].toString() == 'null') ? '' : "DOB: ${model.waitListForAstrologer[index]['dob']}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: HexColor('#979797'),
                                            ),
                                          ),
                                          SizedBox(height: 0.5.h),
                                          Text(
                                            model.waitListForAstrologer[index]['birth_time'].toString() == 'null' ? '' : "Birth Time: ${model.waitListForAstrologer[index]['birth_time']}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: HexColor('#979797'),
                                            ),
                                          ),
                                          SizedBox(height: 0.5.h),
                                          Text(
                                            model.waitListForAstrologer[index]['birth_place'].toString() == 'null' ? '' : "Birth Place: ${model.waitListForAstrologer[index]['birth_place']}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: HexColor('#979797'),
                                            ),
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 1.h),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              if (index == 0)
                                InkWell(
                                  onTap: () async {
                                    model.acceptUserWaitChatRequest(context, model.waitListForAstrologer[index]["id"], "call");
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
                                    model.rejectWaitRequest(context, model.waitListForAstrologer[index]["id"], "call");
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

  Widget callHistoryForAstrologer(BuildContext context, Chatlistmodelpage model) {
    return model.callHistoryList.isEmpty
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
        : ListView.builder(
            physics: const ScrollPhysics(),
            itemCount: model.callHistoryList.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {

              return Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
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
                        if (usertype == "1")
                          Text(
                            model.callHistoryList[index]['astroname'] != null ? model.callHistoryList[index]['astroname'] : "",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        if (usertype == "2")
                          Text(
                            model.callHistoryList[index]['username'] != null ? model.callHistoryList[index]['username'] : "",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Text(
                          'Duration: ${checkValue(model.callHistoryList[index]['duration']) != "" ? model.callHistoryList[index]['duration'].toString() : "0"}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Start Time: ${checkValue(model.callHistoryList[index]['start_time']) != "" ? formatDate2(model.callHistoryList[index]['start_time'].toString()) : "00"}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'End Time: ${checkValue(model.callHistoryList[index]['end_time']) != "" ? formatDate2(model.callHistoryList[index]['end_time'].toString()) : "00"}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '+ ₹ ${checkValue(model.callHistoryList[index]["astro_earning_amount"]) == "" ? '0' : model.callHistoryList[index]["astro_earning_amount"]}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.green),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }

  String checkValue(var value) {
    if (value != null && value != "null" && value != "") {
      if (value == "No Answer") {
        return "";
      } else {
        return value.toString();
      }
    } else {
      return "";
    }
  }

}
