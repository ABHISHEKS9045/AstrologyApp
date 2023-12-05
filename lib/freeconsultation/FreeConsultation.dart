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
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../chat/chat Intake form/ChatIntakeForm.dart';
import '../chat/chatlist/chatinglistPageWidget.dart';
import '../common/appbar/chatpageAppbar.dart';
import '../profile jyotish/profileJyotishPage.dart';
import 'FreeConsultationProvider.dart';

class FreeConsultationPage extends StatefulWidget {
  final bool isCall;

  FreeConsultationPage({super.key, required this.isCall});

  @override
  State<FreeConsultationPage> createState() => _FreeConsultationPageState();
}

class _FreeConsultationPageState extends State<FreeConsultationPage> {
  List astrologerList = [];
  FreeConsultationProvider? model;

  DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
  String TAG = "_FreeConsultationPageState";
  var listner;

  Future<void> getFirebaseDatabaseValue() async {
    List<dynamic> firebaseData = List.from([]);
    listner = databaseRef.onValue.listen((DatabaseEvent event) {
      var snapshot = event.snapshot;
      if (snapshot.exists) {
        firebaseData.clear();
        for (var element in snapshot.children) {
          firebaseData.add(element.value);
        }
        if(mounted) {
          setState(() {
          if (astrologerList != null && astrologerList.isNotEmpty && firebaseData.isNotEmpty) {
            for (int i = 0; i < firebaseData.length; i++) {
              if (firebaseData[i]["id"] != null && firebaseData[i]["id"].toString() != "null" && firebaseData[i]["id"].toString() != "") {
                if (firebaseData[i]["id"].toString() != "000" && firebaseData[i]["id"].toString() != "'000'") {
                  int id = int.parse(firebaseData[i]["id"].toString());
                  for (int j = 0; j < astrologerList.length; j++) {
                    if (int.parse(astrologerList[j]["id"].toString()) == id) {
                      astrologerList[j]["is_busy"] = firebaseData[i]["is_busy"];
                      astrologerList[j]["user_status"] = firebaseData[i]["status"];
                    }
                  }
                }
              }
            }
          }
        });
        }
      } else {
        debugPrint('$TAG <======== On Value No data available ========>');
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      model = Provider.of<FreeConsultationProvider>(context, listen: false);
      await model!.chatUserList(context);

      astrologerList.addAll(model!.astrologerListdb);
      getFirebaseDatabaseValue();

      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/BackGround.png'),
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
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: appbarbackbtnnotification(context, 'Free Consultation'),
                  ),
                  sizedboxheight(15.0),
                  sizedboxheight(5.0),
                  Consumer<FreeConsultationProvider>(builder: (BuildContext context, FreeConsultationProvider model, _) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: padding20),
                      width: deviceWidth(context, 1.0),
                      decoration: decorationtoprounded(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizedboxheight(10.0),
                          sizedboxheight(10.0),
                          SizedBox(
                            height: 1.h,
                          ),
                          model.isShimmer ? Container(margin: EdgeInsets.only(top: 25.h), child: loadingwidget()) : sizedboxheight(10.0),
                          if (!model.isShimmer)
                            SizedBox(
                              height: 72.h,
                              child: astrologerChatListWidget(
                                context,
                                astrologerList,
                                model,
                                widget.isCall,
                                "Online",
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget astrologerChatListWidget(BuildContext context, List<dynamic> astrologerList, FreeConsultationProvider model, bool isCall, String type) {
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
            : Expanded(
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
                              builder: (context) => ProfileJyotishPage(astrolist: model.astrologerListdb[index], isFree: true, freeTime: model.astrologerListdb[index]['free_time']),
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
                                        Row(
                                          children: [
                                            Text(
                                              '₹ ${astrologerList[index]['per_minute']} / min',
                                              style: const TextStyle(
                                                decoration: TextDecoration.lineThrough,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            sizedboxwidth(5.0),
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
                                        if (astrologerList[index]['wait_time'] != null && astrologerList[index]['wait_time'] > 0) SizedBox(height: 0.5.h),
                                        if (astrologerList[index]['wait_time'] != null && astrologerList[index]['wait_time'] > 0)
                                          Text(
                                            'Wait Time ${astrologerList[index]['wait_time']} min.',
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
                                                  Fluttertoast.showToast(msg: 'You can not join astrologer wait list');
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

                                                    if (model1.waitListForAstrologer.isNotEmpty) {
                                                      Fluttertoast.showToast(msg: 'Astrologer is busy...');
                                                    } else {
                                                      debugPrint("$TAG model1.walletAmount =========> ${model1.walletAmount}");
                                                      bool status = await model.getChatStatus(context, astrologerList[index]['id']);

                                                      if (status) {
                                                        Future.delayed(const Duration(milliseconds: 100), () {
                                                          Get.to(() {
                                                            return ChatIntakeForm(
                                                              chatTime: astrologerList[index]['free_time'],
                                                              perMinute: astrologerList[index]['per_minute'],
                                                              name: astrologerList[index]['name'],
                                                              astroid: astrologerList[index]['id'],
                                                              image: astrologerList[index]['profile_image'] ?? astrologerList[index]['image_url'],
                                                              isFree: true,
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
                                                        }
                                                      }
                                                    }
                                                  } else {
                                                    Fluttertoast.showToast(msg: 'Astrologer is busy...');
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
                                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 10),
                                              ),
                                            )
                                          : const SizedBox(height: 8),
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
                  },
                ),
              ),
      ],
    );
  }
}
