import 'package:astrologyapp/chat/chat%20Intake%20form/ChatIntakeForm.dart';
import 'package:astrologyapp/chat/chatlist/chatlistmodelpage.dart';
import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/profile%20jyotish/ProfileJyotishProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../chat/chatlist/CustomerWaitListScreen.dart';
import '../my wallet/mywalletpage.dart';

bool like = false;
bool isComment = false;
TextEditingController messageController = TextEditingController();

String TAG = "profile jyotish widget page";

Widget headerJyotish(BuildContext context, var astrolist, bool isFree) {
  return SizedBox(
    width: deviceWidth(context, 1.0),
    height: 140,
    child: Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 97,
                    height: 105,
                    child: ClipRRect(
                      borderRadius: borderRadiuscircular(15.0),
                      child: CachedNetworkImage(
                        imageUrl: "$imageURL${astrolist['profile_image']}",
                        placeholder: (context, url) => const Image(image: AssetImage('assets/images/user.png'), fit: BoxFit.cover),
                        errorWidget: (context, url, error) => const Image(image: AssetImage('assets/images/user.png'), fit: BoxFit.cover),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (astrolist['user_status'].toString() != "Offline")
                    Container(
                      margin: const EdgeInsets.only(top: 0.0),
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.green, width: 1),
                      ),
                    ),
                  if (astrolist['user_status'].toString() == "Offline")
                    Container(
                      margin: const EdgeInsets.only(top: 0.0),
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.red, width: 1),
                      ),
                    ),
                ],
              ),
              sizedboxheight(5.0),
              Row(
                children: [
                  const Image(
                    image: AssetImage(
                      'assets/icons/star.png',
                    ),
                  ),
                  sizedboxwidth(5.0),
                  Text(
                    astrolist['user_rating'] == null ? "0.0" : parseDouble2Digit(astrolist['user_rating'].toString()),
                    style: textstylesubtitle1(context),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 50.w,
                child: Text(
                  astrolist['name'].toString(),
                  overflow: TextOverflow.ellipsis,
                  style: textstyletitleHeading6(context)!.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              sizedboxheight(5.0),
              astrolist['user_expertise'].toString() == 'null'
                  ? Container()
                  : Row(
                      children: [
                        Image(
                          image: const AssetImage(
                            'assets/icons/icon1.png',
                          ),
                          height: 2.h,
                          width: 2.h,
                          fit: BoxFit.fill,
                        ),
                        sizedboxwidth(5.0),
                        SizedBox(
                          width: 40.w,
                          child: Text(
                            astrolist['user_expertise'].toString(),
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
              sizedboxheight(5.0),
              astrolist['user_language'].toString() == 'null'
                  ? Container()
                  : Row(
                      children: [
                        Image(
                            image: const AssetImage(
                              'assets/icons/lang1.png',
                            ),
                            height: 2.h,
                            width: 2.h,
                            fit: BoxFit.fill),
                        sizedboxwidth(5.0),
                        SizedBox(
                          width: 30.w,
                          child: Text(
                            astrolist['user_language'].toString(),
                            overflow: TextOverflow.ellipsis,
                            style: textstylesubtitle1(context),
                          ),
                        ),
                      ],
                    ),
              sizedboxheight(4.0),
              astrolist['user_experience'].toString() == 'null'
                  ? Container()
                  : Text(
                      "Exp: ${astrolist['user_experience'].toString()}year",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: textstylesubtitle1(context)!,
                    ),
              sizedboxheight(5.0),
              Row(
                children: [
                  astrolist['per_minute'].toString() == 'null'
                      ? Container()
                      : Text(
                          '₹ ${astrolist['per_minute'].toString()}/min',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: textstylesubtitle1(context)!.copyWith(
                            color: colororangeLight,
                            decoration: isFree ? TextDecoration.lineThrough : TextDecoration.none,
                            fontWeight: fontWeight700,
                          ),
                        ),
                  if(isFree)
                  sizedboxwidth(5.0),
                  if(isFree)
                  const Text(
                    'Free',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
        Column(
          children: [
            Container(
              alignment: Alignment.topRight,
              child: Row(
                children: [
                  sizedboxwidth(7.0),
                  if (astrolist['status'] == 1)
                    const SizedBox(
                      height: 25,
                      width: 25,
                      child: Image(
                        image: AssetImage(
                          'assets/icons/varifiedHd.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              ),
            ),
            astrolist['is_busy'] == 1
                ? InkWell(
                    onTap: () {
                      if (astrolist['user_status'].toString() != "Offline") {
                        Get.to(() => CustomerWaitListScreen(
                              astroId: astrolist['id'].toString(),
                              isCall: false,
                              astroName: astrolist["name"].toString(),
                              perMinute: int.parse(astrolist['per_minute']),
                            ));
                      } else {
                        Fluttertoast.showToast(msg: 'Astrologer is Offline right now.');
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, right: 10, bottom: 0),
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
                : Container(),
            astrolist['is_busy'] == 1
                ? const Padding(
                    padding: EdgeInsets.only(right: 10, top: 10),
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
        )
      ],
    ),
  );
}

Widget chatTalkWidget(BuildContext context, var astrolist, ProfileJyotishProvider model, bool isFree, int freeTime) {
  debugPrint("$TAG astrolist chat active =========> ${astrolist["chat_active"]}");
  debugPrint("$TAG astrolist call active =========> ${astrolist["call_active"]}");
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      if (astrolist["chat_active"] == "1")
        GestureDetector(
          onTap: () async {
            if (astrolist['user_status'].toString() != "Offline") {
              var model1 = Provider.of<Chatlistmodelpage>(context, listen: false);
              await model1.getWalletBalance(context);
              if (astrolist['is_busy'] == null || astrolist['is_busy'] != 1) {
                if (model.waitListForAstrologer.isNotEmpty) {
                  Fluttertoast.showToast(msg: 'Some one is already in wait list. You can join wait list');
                  Future.delayed(const Duration(milliseconds: 100), () {
                    Get.to(() => CustomerWaitListScreen(
                          astroId: astrolist['id'].toString(),
                          isCall: false,
                          astroName: astrolist["name"].toString(),
                          perMinute: int.parse(astrolist['per_minute']),
                        ));
                  });
                } else {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String? usertype = prefs.getString('user_type');
                  int time = 0;
                  if (int.parse(astrolist['per_minute']) > 0) {
                    time = (int.parse(model1.walletAmount.toString()) / int.parse(astrolist['per_minute'])).toInt();
                  }
                  if (usertype == '1') {
                    if (isFree == true) {
                      bool status = await model1.getChatStatus(context, astrolist['id']);
                      await model1.toggelreseverSocketToken(astrolist['token']);
                      await model1.toggelreseverid(astrolist['id']);
                      await model1.toggelresevername(astrolist['name']);
                      await model1.toggelreseverdiveiceid(astrolist['device_id']);
                      if (status) {
                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatIntakeForm(
                                chatTime: freeTime ?? 5,
                                perMinute: astrolist['per_minute'],
                                name: astrolist['name'],
                                astroid: astrolist['id'],
                                image: astrolist['profile_image'] ?? astrolist['image_url'], isFree: isFree,
                              ),
                            ),
                          );
                        }
                      } else {
                        Fluttertoast.showToast(msg: 'Astrologer is busy!!');
                      }
                    } else if (model1.walletAmount >= int.parse(astrolist['per_minute']) * 5) {
                      bool status = await model1.getChatStatus(context, astrolist['id']);
                      await model1.toggelreseverSocketToken(astrolist['token']);
                      await model1.toggelreseverid(astrolist['id']);
                      await model1.toggelresevername(astrolist['name']);
                      await model1.toggelreseverdiveiceid(astrolist['device_id']);
                      if (status) {
                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatIntakeForm(
                                chatTime: time,
                                perMinute: astrolist['per_minute'],
                                name: astrolist['name'],
                                astroid: astrolist['id'],
                                image: astrolist['profile_image'] ?? astrolist['image_url'], isFree: isFree,
                              ),
                            ),
                          );
                        }
                      } else {
                        Fluttertoast.showToast(msg: 'Astrologer is busy!!');
                      }
                    } else {
                      Future.delayed(const Duration(milliseconds: 100), () {
                        showBottomSheetPopUp(context, astrolist);
                      });
                    }
                  }
                }
              } else {
                if (model1.walletAmount < int.parse(astrolist['per_minute']) * 5) {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    showBottomSheetPopUp(context, astrolist);
                  });
                } else {
                  Fluttertoast.showToast(msg: 'Astrologer is busy...');
                  await model1.addUserToAstrologerWaitList(astroId: astrolist["id"], type: "Chat");
                }
              }
            } else {
              Fluttertoast.showToast(msg: 'Astrologer is Offline right now.');
            }
          },
          child: Container(
            width: 42.w,
            height: 10.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: colorgreyblack.withOpacity(0.2),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage(
                    'assets/icons/views.png',
                  ),
                ),
                sizedboxheight(3.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '₹ ${astrolist['per_minute']}/mins',
                      style: textstyleHeading3(context)!.copyWith(
                        color: colororangeLight,
                        fontSize: 16,
                        decoration: isFree ? TextDecoration.lineThrough : TextDecoration.none,
                      ),
                    ),
                    if(isFree)
                      sizedboxwidth(5.0),
                    if(isFree)
                      const Text(
                        'Free',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                  ],
                ),
                astrolist['is_busy'] == 1
                    ? const Padding(
                        padding: EdgeInsets.only(right: 10, top: 5),
                        child: Text(
                          'Currently Busy',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      if (astrolist["call_active"] == "1") showCallWidget(context, astrolist, model, isFree),
    ],
  );
}

Widget showCallWidget(BuildContext context, var astrolist, ProfileJyotishProvider model, bool isFree) {
  if (isFree == false) {
    return GestureDetector(
      onTap: () async {
        if (astrolist['user_status'].toString() != "Offline") {
          final model1 = Provider.of<Chatlistmodelpage>(context, listen: false);
          await model1.getWalletBalance(context);

          if (astrolist['is_busy'] == null || astrolist['is_busy'] != 1) {
            if (model.waitListForAstrologer.isNotEmpty) {
              Fluttertoast.showToast(msg: 'Some one is already in wait list. You can join wait list');
              Future.delayed(const Duration(milliseconds: 100), () {
                Get.to(() => CustomerWaitListScreen(
                      astroId: astrolist['id'].toString(),
                      isCall: true,
                      astroName: astrolist["name"].toString(),
                      perMinute: int.parse(astrolist['per_minute']),
                    ));
              });
            } else {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? usertype = prefs.getString('user_type');
              int time = 0;
              if (int.parse(astrolist['per_minute']) > 0) {
                time = (int.parse(model1.walletAmount.toString()) / int.parse(astrolist['per_minute'])).toInt();
              }
              if (usertype == '1') {
                if (model1.walletAmount >= int.parse(astrolist['per_minute']) * 5) {
                  model1.initiateCall(context, astrolist['phone_no'], astrolist['id'].toString(), astrolist['per_minute'].toString(), 5);
                } else {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    showBottomSheetPopUp(context, astrolist);
                  });
                }
              }
            }
          } else {
            if (model1.walletAmount >= int.parse(astrolist['per_minute']) * 5) {
              showBottomSheetPopUp(context, astrolist);
            } else {
              Fluttertoast.showToast(msg: 'Astrologer is busy...');
              await model1.addUserToAstrologerWaitList(astroId: astrolist["id"], type: "Call");
            }
          }
        } else {
          Fluttertoast.showToast(msg: 'Astrologer is Offline right now.');
        }
      },
      child: Container(
        width: 42.w,
        height: 10.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: colorgreyblack.withOpacity(0.2),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(
                'assets/icons/callv5.png',
              ),
            ),
            sizedboxheight(3.0),
            Text(
              '₹ ${astrolist['per_minute']}/mins',
              style: textstyleHeading3(context)!.copyWith(
                color: colororangeLight,
                fontSize: 16,
              ),
            ),
            astrolist['is_busy'] == 1
                ? const Padding(
                    padding: EdgeInsets.only(right: 10, top: 5),
                    child: Text(
                      'Currently Busy',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  } else {
    return Container();
  }
}

Widget aboutMeWidget(context, astrolist) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedboxheight(10.0),
        Text('About Me', style: textstyleHeading1(context)!.copyWith(color: colorblack, fontSize: 18)),
        sizedboxheight(5.0),
        astrolist['user_expertise'].toString() == 'null'
            ? const Text(
                'No data found',
              )
            : Text(
                astrolist['user_aboutus'].toString(),
                style: textstylesubtitle1(context),
              ),
      ],
    ),
  );
}

// TODO: add availability here comment by nilesh on 26-05-2023
Widget availabilityWidget(BuildContext context, ProfileJyotishProvider model) {
  return model.weekDay.isEmpty
      ? Container()
      : Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            child: Container(
              width: deviceWidth(context, 1.0),
              decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.circular(11),
                border: Border.all(
                  color: colorgreyblack.withOpacity(0.2),
                ),
              ),
              child: ListTile(
                leading: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: colororangeLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image(
                    image: const AssetImage(
                      'assets/icons/avail.png',
                    ),
                    color: colorWhite,
                  ),
                ),
                title: Text(
                  'Availability',
                  style: textstyletitleHeading6(context),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Week day",
                            style: textstylesubtitle2(context)!.copyWith(
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Start time",
                            style: textstylesubtitle2(context)!.copyWith(
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "End time",
                            style: textstylesubtitle2(context)!.copyWith(
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Divider(
                      height: 1,
                      thickness: 0.5,
                      color: HexColor("#f1f1f1"),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    ListView.builder(
                      itemCount: model.weekDay.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                model.weekDay[index],
                                style: textstylesubtitle2(context)!.copyWith(
                                  fontSize: 15,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                model.startTime[index],
                                style: textstylesubtitle2(context)!.copyWith(
                                  fontSize: 15,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                model.endTime[index],
                                style: textstylesubtitle2(context)!.copyWith(
                                  fontSize: 15,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
}

Widget expertiseWidget(context, astrolist) {
  return astrolist['user_expertise'].toString() == 'null'
      ? Container()
      : Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            child: Container(
              width: deviceWidth(context, 1.0),
              // height: 55,
              decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.circular(11),
                border: Border.all(
                  color: colorgreyblack.withOpacity(0.2),
                ),
              ),
              child: ListTile(
                leading: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: colororangeLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image(
                      image: const AssetImage('assets/icons/exp.png'),
                      color: colorWhite,
                    )),
                title: Text(
                  'Expertise',
                  style: textstyletitleHeading6(context),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  astrolist['user_expertise'].toString(),
                  style: textstylesubtitle2(context)!.copyWith(fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        );
}

Widget eductionWidget(context, astrolist) {
  return astrolist['user_education'].toString() == 'null'
      ? Container()
      : Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            child: Container(
              width: deviceWidth(context, 1.0),
              // height: 55,
              decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.circular(11), border: Border.all(color: colorgreyblack.withOpacity(0.2))),
              child: ListTile(
                leading: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(color: colororangeLight, borderRadius: BorderRadius.circular(8)),
                    child: Image(
                      image: const AssetImage('assets/icons/edu.png'),
                      color: colorWhite,
                    )),
                title: Text(
                  'Education',
                  style: textstyletitleHeading6(context),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  astrolist['user_education'] ?? '',
                  style: textstylesubtitle2(context)!.copyWith(fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ),
        );
}

Widget overallRatingWidget(context, countRating, ratingInt) {
  return Container(
    width: deviceWidth(context, 1.0),
    // height: 140,
    padding: const EdgeInsets.only(top: 17, left: 10, right: 10, bottom: 10),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: borderCustom()),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Overall Rating',
          style: textstyletitleHeading6(context),
        ),
        sizedboxheight(3.0),
        Text(
          ratingInt,
          style: textstyleHeading1(context)!.copyWith(color: colorblack, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        sizedboxheight(5.0),
        ratingJyotishWidget(context, ratingInt),
        sizedboxheight(5.0),
        Text(
          'Based on ${countRating ?? 0} review',
          style: textstylesubtitle2(context)!.copyWith(fontSize: 15),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        )
      ],
    ),
  );
}

Widget ratingJyotishWidget(BuildContext context, ratingInt) {
  return RatingBar.builder(
    initialRating: double.parse(ratingInt),
    minRating: 0,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: 5,
    itemSize: 26,
    ignoreGestures: true,
    itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
    itemBuilder: (context, _) => const Icon(
      Icons.star,
      color: Colors.amber,
    ),
    onRatingUpdate: (rating) {},
  );
}

Widget commentWidget(context, reviewdata) {
  return StatefulBuilder(
    builder: (BuildContext context, setState) {
      return reviewdata == null
          ? Container()
          : ListView.builder(
              physics: const ScrollPhysics(),
              itemCount: reviewdata.length ?? 0,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: const CircleAvatar(
                          radius: 26,
                        ),
                        title: Text(
                          reviewdata[index]['name'],
                          style: textstyletitleHeading6(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ratingJyotish(context, reviewdata[index]['rating'].toString()),
                            Text(
                              reviewdata[index]['review_date'].split(' ')[0],
                              overflow: TextOverflow.ellipsis,
                              style: textstylesubtitle2(context)!.copyWith(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 10,
                          right: 15,
                        ),
                        child: Text(
                          reviewdata[index]['review'] == null ? "" : reviewdata[index]['review'].toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: const TextStyle(
                            fontSize: 16,
                            letterSpacing: 0.5,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      sizedboxheight(20.0),
                      isComment
                          ? Container(
                              height: 100,
                            )
                          : Container(),
                      dividerHorizontal(),
                    ],
                  ),
                );
              },
            );
    },
  );
}

Widget ratingJyotish(BuildContext context, String ratingCount) {
  return SizedBox(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingBar.builder(
          initialRating: double.parse(ratingCount),
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 15,
          ignoreGestures: true,
          itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            // model.togglerateapp(rating);
          },
        ),
      ],
    ),
  );
}

void showBottomSheetPopUp(BuildContext context, dynamic astrologerList) {
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
                    "Minimum balance of 5 minutes (₹ ${astrologerList['per_minute']} / min.) is required to start chat/call with ${astrologerList['name'].toString()}",
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
