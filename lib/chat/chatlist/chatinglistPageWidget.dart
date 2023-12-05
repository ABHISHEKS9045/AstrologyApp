import 'package:astrologyapp/chat/chat%20room/chatroomPage.dart';
import 'package:astrologyapp/chat/chatlist/chatlistmodelpage.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../help&support/CustomerRefundRaiseQueryPage.dart';
import '../../my wallet/mywalletpage.dart';
import '../../profile jyotish/profileJyotishPage.dart';
import '../chat Intake form/ChatIntakeForm.dart';
import '../chat room/chatroomHistoryPage.dart';
import 'CustomerWaitListScreen.dart';

List<Icon> categoryIcons = [
  const Icon(Icons.widgets_outlined, size: 18, color: Colors.black54),
  const Icon(Icons.favorite, size: 18, color: Colors.redAccent),
  const Icon(Icons.shopping_bag, size: 18, color: Colors.blueAccent),
  const Icon(Icons.female, size: 18, color: Colors.pinkAccent),
  const Icon(Icons.medical_services, size: 18, color: Colors.deepOrangeAccent),
  const Icon(Icons.account_balance_wallet_rounded, size: 18, color: Colors.purpleAccent),
  const Icon(Icons.credit_card, size: 18, color: Colors.lightGreenAccent),
  const Icon(Icons.people_rounded, size: 18, color: Colors.orangeAccent),
  const Icon(Icons.lock, size: 18, color: Colors.lightBlueAccent),
  const Icon(Icons.cast_for_education, size: 18, color: Colors.pinkAccent),
  const Icon(Icons.person_outlined, size: 18, color: Colors.deepOrangeAccent),
  const Icon(Icons.child_care, size: 18, color: Colors.greenAccent),
  const Icon(Icons.bedroom_parent, size: 18, color: Colors.purpleAccent)
];

Widget recentCallListWidget(BuildContext context, String? userType, Chatlistmodelpage model) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedboxheight(10.0),
        sizedboxheight(10.0),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Call history will be shown with some delay',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
        model.callHistoryList.isEmpty
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
                itemBuilder: (context, index) {
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
                            if (userType == "1")
                              Text(
                                model.callHistoryList[index]['astroname'] ?? "",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            if (userType == "2")
                              Text(
                                model.callHistoryList[index]['username'] ?? "",
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
                              'Duration: ${checkValue(model.callHistoryList[index]['duration']) != "" ? model.callHistoryList[index]['duration'] : "0"}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Start Time: ${checkValue(model.callHistoryList[index]['start_time']) != "" ? formatDate2(model.callHistoryList[index]['start_time']) : "00"}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'End Time: ${checkValue(model.callHistoryList[index]['end_time']) != "" ? formatDate2(model.callHistoryList[index]['end_time']) : "00"}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: model.userType == '1'
                                  ? Text(
                                      checkValue(model.callHistoryList[index]['deduction_amount']) != "" ? "- ₹ ${model.callHistoryList[index]['deduction_amount']}" : "0",
                                      // "- ₹ ${checkValue(model.callHistoryList[index]['deduction_amount']) != "" ? model.callHistoryList[index]['deduction_amount'] : "0"}",
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red),
                                    )
                                  : Text(
                                      checkValue(model.callHistoryList[index]['astro_earning_amount']) != "" ? "+ ₹ ${model.callHistoryList[index]['astro_earning_amount']}" : "0",
                                      // '+ ₹ ${checkValue(model.callHistoryList[index]["astro_earning_amount"]) != "" ? model.callHistoryList[index]["astro_earning_amount"] : "0"}',
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.green),
                                    ),
                            ),
                            sizedboxheight(10.0),
                            model.userType == "1"
                                ? showRefundButton(
                                    model.callHistoryList[index]['deduction_amount'],
                                    model.callHistoryList[index]["id"],
                                    "call",
                                    model.callHistoryList[index]["is_request"],
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
      ],
    ),
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

Widget showRefundButton(var value, var requestId, String type, var isRequest) {
  if (value != null && value != "null" && value != "") {
    if (value == "No Answer") {
      return Container();
    } else if (isRequest == 0) {
      return Align(
        alignment: Alignment.bottomRight,
        child: InkWell(
          onTap: () {
            Get.to(() => CustomerRefundRaiseQueryPage(
                  requestType: type,
                  amount: value.toString(),
                  requestId: requestId.toString(),
                ));
          },
          child: Text(
            "Refund",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: colororangeLight),
          ),
        ),
      );
    } else {
      return Align(
        alignment: Alignment.bottomRight,
        child: Text(
          "Resolved",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: colororangeLight),
        ),
      );
    }
  } else {
    return Container();
  }
}

Widget recentChatListWidget(BuildContext context, String? userType, Chatlistmodelpage model) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedboxheight(10.0),
        sizedboxheight(10.0),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Chat history will be shown with some delay',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
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
            : ListView.builder(
                physics: const ScrollPhysics(),
                itemCount: model.chatHistoryList.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var dur;
                  String startTime = '', endTime = '', chatDate = "";
                  if (model.chatHistoryList[index]['duration'] != null) dur = model.chatHistoryList[index]['duration'];
                  if (model.chatHistoryList[index]['start_time'] != null) startTime = model.chatHistoryList[index]['start_time'].toString();
                  if (model.chatHistoryList[index]['end_time'] != null) endTime = model.chatHistoryList[index]['end_time'].toString();
                  if (model.chatHistoryList[index]['chat_date'] != null) chatDate = model.chatHistoryList[index]['chat_date'].toString();
                  return Slidable(
                    enabled: false,
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.14,
                      children: [
                        Container(
                          height: 75,
                          margin: const EdgeInsets.only(left: 9),
                          decoration: BoxDecoration(
                            color: HexColor('#ECEEFF'),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Image(
                              image: AssetImage('assets/icons/fileicon.png'),
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Container(
                          height: 75,
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: HexColor('#FFE7E5'),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Image(
                              image: const AssetImage('assets/icons/deleteicon.png'),
                              color: colororangeLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    child: InkWell(
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
                                Text(
                                  model.chatHistoryList[index]['name'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.0.h
                                ),
                                Text(
                                  'Duration: $dur',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5
                                ),
                                Text(
                                  'Start Time: ${formatOnlyDate(chatDate)} ${formatDate(startTime)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5
                                ),
                                Text(
                                  'End Time: ${formatOnlyDate(chatDate)} ${formatDate(endTime)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
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
                                sizedboxheight(10.0),
                                model.userType == "1" ? showRefundButton(model.chatHistoryList[index]['deduction_amount'], model.chatHistoryList[index]["id"], "chat", model.chatHistoryList[index]["is_request"]) : Container(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ],
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



String TAG = "AstrologerUpcomingList";

Widget astrologerChatListWidget(BuildContext context, List<dynamic> astrologerList, Chatlistmodelpage model, bool isCall, String type, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      astrologerList.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: deviceheight(context, 0.6),
                  child: Center(
                    child: Text(
                      'No Data Found',
                      style: textstyleHeading3(context),
                    ),
                  ),
                ),
              ],
            )
          : SizedBox(
              height: 60.h,
              child: ListView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: astrologerList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: false,
                  itemBuilder: (context, index) {
                    if (astrologerList[index]['user_status'] == type) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileJyotishPage(
                                astrolist: model.astrologerListdb[index],
                                isFree: false,
                                freeTime: 0,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          width: deviceWidth(context, 1.0),
                          decoration: BoxDecoration(
                            color: colorWhite,
                            borderRadius: BorderRadius.circular(15),
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
                          child: Stack(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 60,
                                              margin: const EdgeInsets.only(top: 15),
                                              child: ClipOval(
                                                child: astrologerList[index]['profile_image'] != null
                                                    ? Image.network(
                                                        imageURL + astrologerList[index]['profile_image'],
                                                        errorBuilder: (context, url, error) => const Image(
                                                          image: AssetImage('assets/images/user.png'),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        fit: BoxFit.cover,
                                                      )
                                                    : const Image(
                                                        image: AssetImage(
                                                          'assets/images/user.png',
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 0.5.h),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: colororangeLight,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            Text(
                                              astrologerList[index]['user_rating'] == null ? "0.0" : parseDouble2Digit(astrologerList[index]['user_rating'].toString()),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5.0),
                                        // const SizedBox(
                                        //   height: 5.0,
                                        // ),
                                        // if (astrologerList[index]["recommend"] != null && astrologerList[index]["recommend"] != "")
                                        //   Container(
                                        //     padding: const EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
                                        //     decoration: BoxDecoration(
                                        //       color: HexColor("#00fa9a"),
                                        //       shape: BoxShape.rectangle,
                                        //       borderRadius: BorderRadius.circular(10),
                                        //     ),
                                        //     child: Text(
                                        //       astrologerList[index]["recommend"].toString(),
                                        //       style: const TextStyle(
                                        //         color: Colors.white,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // const SizedBox(
                                        //   height: 5.0,
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 50.w,
                                          child: Text(
                                            astrologerList[index]['name'].toString(),
                                            maxLines: 1,
                                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: HexColor('#000000'),
                                                ),
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          astrologerList[index]['user_expertise'].toString() == 'null' ? '' : astrologerList[index]['user_expertise'],
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          astrologerList[index]['user_language'].toString() == 'null' ? '' : astrologerList[index]['user_language'],
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: HexColor('#979797'),
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          astrologerList[index]['user_experience'].toString() == 'null' ? '0 Year' : astrologerList[index]['user_experience'] + ' Year',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: HexColor('#979797'),
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          '₹ ${astrologerList[index]['per_minute']}/ min',
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        if (astrologerList[index]['wait_time'] != null && astrologerList[index]['wait_time'] > 0) SizedBox(height: 0.5.h),
                                        if (astrologerList[index]['wait_time'] != null && astrologerList[index]['wait_time'] > 0)
                                          Text(
                                            'Wait ${astrologerList[index]['wait_time']}m',
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        sizedboxheight(6.0),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      const SizedBox(height: 3),
                                      if (astrologerList[index]['status'] == 1)
                                        Container(
                                          height: 25,
                                          width: 25,
                                          child: const Image(
                                            image: AssetImage(
                                              'assets/icons/varifiedHd.png',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      const SizedBox(height: 15),
                                      astrologerList[index]['is_busy'] == 1
                                          ? InkWell(
                                              onTap: () {
                                                if (astrologerList[index]['user_status'].toString() != "Offline") {
                                                  Get.to(() => CustomerWaitListScreen(
                                                        astroId: astrologerList[index]['id'].toString(),
                                                        isCall: false,
                                                        astroName: astrologerList[index]['name'].toString(),
                                                        perMinute: int.parse(astrologerList[index]['per_minute']),
                                                      ));
                                                } else {
                                                  Fluttertoast.showToast(msg: 'Astrologer is Offline right now.');
                                                }
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(top: 10),
                                                child: Container(
                                                  margin: EdgeInsets.only(top: 10, right: 10, bottom: astrologerList[index]['is_busy'] != 1 ? 20 : 0),
                                                  padding: const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: Colors.red, width: 1),
                                                  ),
                                                  child: Image.asset(
                                                    "assets/images/wait_list.png",
                                                    width: 25,
                                                    height: 25,
                                                    color: colororangeLight,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () async {
                                                if (astrologerList[index]['user_status'].toString() != "Offline") {
                                                  final model1 = Provider.of<Chatlistmodelpage>(context, listen: false);
                                                  await model1.getWalletBalance(context);
                                                  if (astrologerList[index]['is_busy'] == null || astrologerList[index]['is_busy'].toString() != '1') {
                                                    await model1.getWaitCustomersListForCheckJoinChat(type: "", astroId: astrologerList[index]['id'].toString());
                                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                                    String? usertype = prefs.getString('user_type');
                                                    int time = 0;
                                                    debugPrint("$TAG astrologerList per_minute cost ========> ${astrologerList[index]['per_minute']}");
                                                    if (astrologerList[index]['per_minute'] != null && astrologerList[index]['per_minute'] != "") {
                                                      if (int.parse(astrologerList[index]['per_minute']) > 0) {
                                                        time = (int.parse(model1.walletAmount.toString()) / int.parse(astrologerList[index]['per_minute'])).toInt();
                                                      } else {
                                                        Fluttertoast.showToast(msg: 'Astrologer is registered for call');
                                                      }
                                                    } else {
                                                      Fluttertoast.showToast(msg: 'Astrologer is registered for call');
                                                    }

                                                    if (usertype == '1') {
                                                      if (model1.waitListForAstrologer.isNotEmpty) {
                                                        Fluttertoast.showToast(msg: 'Some one is already in wait list. You can join wait list');
                                                        Future.delayed(const Duration(milliseconds: 100), () {
                                                          Get.to(() => CustomerWaitListScreen(
                                                                astroId: astrologerList[index]['id'].toString(),
                                                                isCall: false,
                                                                astroName: astrologerList[index]['name'].toString(),
                                                                perMinute: int.parse(astrologerList[index]['per_minute']),
                                                              ));
                                                        });
                                                      } else {
                                                        debugPrint("$TAG model1.walletAmount =========> ${model1.walletAmount}");

                                                        if (model1.walletAmount >= (int.parse(astrologerList[index]['per_minute']) * 5)) {
                                                          bool status = await model.getChatStatus(context, astrologerList[index]['id']);

                                                          if (status) {
                                                            Future.delayed(const Duration(milliseconds: 100), () {
                                                              Get.to(() {
                                                                return ChatIntakeForm(
                                                                  chatTime: time,
                                                                  perMinute: astrologerList[index]['per_minute'],
                                                                  name: astrologerList[index]['name'],
                                                                  astroid: astrologerList[index]['id'],
                                                                  image: astrologerList[index]['profile_image'] ?? astrologerList[index]['image_url'],
                                                                  isFree: false,
                                                                );
                                                              });
                                                            });
                                                          } else {
                                                            if (model1.walletAmount < (int.parse(astrologerList[index]['per_minute']) * 5)) {
                                                              Future.delayed(const Duration(milliseconds: 100), () {
                                                                showBottomSheetPopUp(context, astrologerList, index);
                                                              });
                                                            } else {
                                                              Fluttertoast.showToast(msg: 'Astrologer is busy...');
                                                              await model1.addUserToAstrologerWaitList(astroId: astrologerList[index]['id'], type: "Chat");
                                                            }
                                                          }
                                                        } else {
                                                          debugPrint("$TAG astrologerList =====> ${astrologerList.length}");
                                                          debugPrint("$TAG index =====> $index");

                                                          Future.delayed(const Duration(milliseconds: 100), () {
                                                            showBottomSheetPopUp(context, astrologerList, index);
                                                          });
                                                        }
                                                      }
                                                    } else {
                                                      // comment by nilesh on 14-04-2023
                                                      int time = (int.parse(model1.walletAmount.toString()) / int.parse(astrologerList[index]['per_minute'].toString())).toInt();
                                                      if (context.mounted) {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                          return ChatRoomPage(
                                                            chatTime: time,
                                                            perMinute: astrologerList[index]['per_minute'],
                                                            userName: astrologerList[index]['name'],
                                                            receiver_id: astrologerList[index]['id'],
                                                            isForHistory: false,
                                                          );
                                                        }));
                                                      }
                                                    }

                                                    await model1.toggelreseverid(astrologerList[index]['id']);
                                                    await model1.toggelreseverSocketToken(astrologerList[index]['token']);
                                                    await model1.toggelresevername(astrologerList[index]['name']);
                                                    await model1.toggelreseverImage(astrologerList[index]['image_url']);
                                                    await model1.toggelreseverdiveiceid(astrologerList[index]['device_id']);
                                                  } else {
                                                    if (model1.walletAmount < (int.parse(astrologerList[index]['per_minute']) * 5)) {
                                                      Future.delayed(const Duration(milliseconds: 100), () {
                                                        showBottomSheetPopUp(context, astrologerList, index);
                                                      });
                                                    } else {
                                                      Fluttertoast.showToast(msg: 'Astrologer is busy...');
                                                      await model1.addUserToAstrologerWaitList(astroId: astrologerList[index]['id'], type: "Chat");
                                                    }
                                                  }
                                                } else {
                                                  Fluttertoast.showToast(msg: 'Astrologer is offline right now.');
                                                }
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(right: 10, top: 10),
                                                padding: const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: HexColor('#EFEFEF'),
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.chat_outlined,
                                                  color: colororangeLight,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                      astrologerList[index]['is_busy'] == 1
                                          ? const Padding(
                                              padding: EdgeInsets.only(right: 10, top: 5),
                                              child: Text(
                                                'Wait List',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            )
                                          : const SizedBox(
                                              height: 8,
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                              if (astrologerList[index]["recommend"] != null && astrologerList[index]["recommend"] != "")
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        setImageBasedOnType(astrologerList[index]["recommend"]),
                                      ),
                                    ),
                                  ),
                                ),
                              Positioned(
                                top: 70,
                                left: 55,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: astrologerList[index]['user_status'].toString() == "Offline" ? Colors.red : Colors.green,
                                    border: Border.all(
                                      color: astrologerList[index]['user_status'].toString() == "Offline" ? Colors.red : Colors.green,
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
    ],
  );
}

String setImageBasedOnType(String type) {
  switch (type) {
    case "Star Astrologer":
      return "assets/images/star_astrologer.png";
    case "Recommended":
      return "assets/images/recommended.png";
    case "Top Choice":
      return "assets/images/top_choice.png";
    case "Must Try":
      return "assets/images/must_try.png";
    default:
      return "";
  }
}

void showBottomSheetPopUp(BuildContext context, List astrologerList, int index) {
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
                  child: Text(
                    "Minimum balance of 5 minutes (₹ ${astrologerList[index]['per_minute']} / min.) is required to start chat/call with ${astrologerList[index]['name'].toString()}",
                    style: const TextStyle(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyWalletPage(),
                  ),
                );
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

Color setColor(var status) {
  if (status == null) {
    return Colors.red;
  } else if (status.toString() == "Completed") {
    return Colors.green;
  } else {
    return Colors.red;
  }
}

String showStatus(var status) {
  if (status == null) {
    return "Failed";
  } else if (status.toString() == "Completed") {
    return "Completed";
  } else {
    return "Failed";
  }
}
