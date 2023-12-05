import 'package:astrologyapp/chat/chat%20Intake%20form/ChatIntakeForm.dart';
import 'package:astrologyapp/chat/chatlist/CustomerWaitListScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../common/formtextfield/myTextField.dart';
import '../../common/shimmereffect.dart';
import '../../common/styles/const.dart';
import '../../my wallet/mywalletpage.dart';
import '../../profile jyotish/profileJyotishPage.dart';
import '../chat room/chatroomPage.dart';
import 'chatinglistPageWidget.dart';
import 'chatlistmodelpage.dart';

class ChatListScreenWidget extends StatefulWidget {
  final Chatlistmodelpage model;
  final bool isCall;

  const ChatListScreenWidget({super.key, required this.model, required this.isCall});

  @override
  ChatListScreenWidgetState createState() => ChatListScreenWidgetState();
}

class ChatListScreenWidgetState extends State<ChatListScreenWidget> {
  TextEditingController controller = TextEditingController();
  List astrologerList = [];

  List<FilterModel> sortList = [
    FilterModel(name: 'Experience: High to Low', isSelected: false),
    FilterModel(name: 'Experience: Low to High', isSelected: false),
    FilterModel(name: 'Price: Low to High', isSelected: false),
    FilterModel(name: 'Price: High to Low', isSelected: false),
    FilterModel(name: 'Rating: High to Low', isSelected: false),
  ];

  List<FilterModel> languageList = [
    FilterModel(name: 'Bengali', isSelected: false),
    FilterModel(name: 'English', isSelected: false),
    FilterModel(name: 'Gujarati', isSelected: false),
    FilterModel(name: 'Hindi', isSelected: false),
    FilterModel(name: 'Marathi', isSelected: false),
    FilterModel(name: 'Kannada', isSelected: false),
    FilterModel(name: 'Punjabi', isSelected: false),
    FilterModel(name: 'Tamil', isSelected: false),
  ];

  List<FilterModel> genderList = [
    FilterModel(name: 'Male', isSelected: false),
    FilterModel(name: 'Female', isSelected: false),
  ];

  /*List<FilterModel> offerList = [
    FilterModel(name: 'Active', isSelected: false),
    FilterModel(name: 'Not Active', isSelected: false),
  ];*/

  List<FilterModel> skillList = [
    FilterModel(name: 'Face Reading', isSelected: false),
    FilterModel(name: 'KP', isSelected: false),
    FilterModel(name: 'Life Coach', isSelected: false),
    FilterModel(name: 'Nadi', isSelected: false),
    FilterModel(name: 'Numerology', isSelected: false),
    FilterModel(name: 'Prashana', isSelected: false),
    FilterModel(name: 'Palmistry', isSelected: false),
    FilterModel(name: 'Psychic', isSelected: false),
    FilterModel(name: 'Tarot', isSelected: false),
    FilterModel(name: 'Vastu', isSelected: false),
    FilterModel(name: 'Vedic', isSelected: false),
  ];

  int selectedSkillCount = 0;
  int selectedLanguageCount = 0;
  int selectedGenderCount = 0;

  //int selectedOfferCount = 0;
  FilterModel? selectedSort;
  int selectedParameterIndex = 0;
  bool isCalling = false;

  DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
  String TAG = "_ChatListScreenWidgetState";
  var listner;
  int selectedIndex = 0;

  Future<void> getFirebaseDatabaseValue() async {
    List<dynamic> firebaseData = List.from([]);
    listner = databaseRef.onValue.listen((DatabaseEvent event) {
      var snapshot = event.snapshot;
      debugPrint("$TAG snapshot ======> $snapshot");
      if (snapshot.exists) {
        firebaseData.clear();
        for (var element in snapshot.children) {
          debugPrint("$TAG element value =======> ${element.value}");
          firebaseData.add(element.value);
        }
        debugPrint("$TAG firebaseData =======> $firebaseData");

        setState(() {
          if (astrologerList != null && astrologerList.isNotEmpty && firebaseData.isNotEmpty) {
            for (int i = 0; i < firebaseData.length; i++) {
              if (firebaseData[i]["id"].toString() != null && firebaseData[i]["id"].toString() != "null") {
                if (firebaseData[i]["id"].toString() != "0") {
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
      } else {
        debugPrint('$TAG <======== On Value No data available ========>');
      }
    });
  }

  @override
  void initState() {
    astrologerList.addAll(widget.model.astrologerListdb);
    getFirebaseDatabaseValue();
    controller.addListener(() {
      String searchText = controller.text.toLowerCase();
      astrologerList = [];
      if (searchText.isNotEmpty) {
        for (int i = 0; i < widget.model.astrologerListdb.length; i++) {
          if (widget.model.astrologerListdb[i]['name'].toLowerCase().contains(searchText)) astrologerList.add(widget.model.astrologerListdb[i]);
        }
      } else {
        astrologerList.addAll(widget.model.astrologerListdb);
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    listner.cancel();
  }

  bool isProcess = false;

  showLoader() {
    setState(() {
      isProcess = true;

    });
  }

  hideLoader() {
    isProcess = false;
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    Chatlistmodelpage model = widget.model;
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedboxheight(10.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AllInputDesign(
                    controller: controller,
                    fillColor: colorWhite,
                    hintText: 'Search',
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: colororangeLight,
                    ),
                    focusedBorderColor: colorblack.withOpacity(0.1),
                    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
                    keyBoardType: TextInputType.text,
                    validatorFieldValue: 'Phone',
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showFilterView();
                  },
                  icon: Icon(
                    Icons.sort,
                    size: 36,
                    color: colororangeLight,
                  ),
                ),
              ],
            ),
            sizedboxheight(5.0),

            Visibility(
              visible: false,
              child: SizedBox(
                height: 5.h,
                child: ListView.builder(
                    physics: const ScrollPhysics(),
                    itemCount: model.categoryList.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          selectedIndex = index;
                            await model.chatUserList(context: context, categoryId: int.parse(model.categoryList[index]['id'].toString()));
                          astrologerList.clear();
                          astrologerList.addAll(model.astrologerListdb);
                          if(mounted) {
                            await getFirebaseDatabaseValue();
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: colorWhite,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: selectedIndex == index ? categoryIcons[index].color! : Colors.white,
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
                            children: [
                              SizedBox(
                                width: 1.w,
                              ),
                              categoryIcons[index],
                              SizedBox(
                                width: 1.w,
                              ),
                              Text(
                                model.categoryList[index]['category_name'],
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),

            // used to show the list of astrologer 18-04-2023
            model.isShimmer ? Container(margin: EdgeInsets.only(top: 25.h), child: loadingwidget()) : sizedboxheight(10.0),
            if (!model.isShimmer)
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.6,
              child: astrologerList.isEmpty
                  ? const Center(
                      child: Text(
                        "No data Found",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: astrologerList.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            debugPrint('$TAG Astrologer Data =========> ${astrologerList[index]} ');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileJyotishPage(
                                  astrolist: astrologerList[index],
                                  freeTime: 0,
                                  isFree: false,
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
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.end,
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
                                        const SizedBox(height: 10),
                                        astrologerList[index]['is_busy'] == 1
                                            ? InkWell(
                                                onTap: () {
                                                  showLoader();
                                                  if (astrologerList[index]['user_status'].toString() != "Offline") {
                                                    hideLoader();

                                                    Get.to(() => CustomerWaitListScreen(
                                                          astroId: astrologerList[index]['id'].toString(),
                                                          isCall: widget.isCall,
                                                          astroName: astrologerList[index]['name'].toString(),
                                                          perMinute: int.parse(astrologerList[index]['per_minute']),
                                                        ));
                                                  } else {
                                                    hideLoader();
                                                    Fluttertoast.showToast(msg: 'Astrologer is Offline right now.');
                                                  }
                                                  hideLoader();
                                                },
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
                                              )
                                            : InkWell(
                                                onTap: () async {
                                                  showLoader();
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

                                                      if (model1.waitListForAstrologer.isNotEmpty) {
                                                        Fluttertoast.showToast(msg: 'Some one is already in wait list. You can join wait list');
                                                        Future.delayed(const Duration(milliseconds: 100), () {
                                                          hideLoader();
                                                          Get.to(() => CustomerWaitListScreen(
                                                                astroId: astrologerList[index]['id'].toString(),
                                                                isCall: widget.isCall,
                                                                astroName: astrologerList[index]['name'].toString(),
                                                                perMinute: int.parse(astrologerList[index]['per_minute']),
                                                              ));
                                                        });
                                                      } else {
                                                        if (widget.isCall && context.mounted) {
                                                          if (model1.walletAmount >= (int.parse(astrologerList[index]['per_minute']) * 5)) {
                                                            model.initiateCall(context, astrologerList[index]['phone_no'], astrologerList[index]['id'].toString(), astrologerList[index]['per_minute'].toString(), time);
                                                          } else {
                                                            debugPrint("$TAG index ===========> $index");
                                                            hideLoader();
                                                            Future.delayed(const Duration(milliseconds: 100), () {
                                                              showBottomSheetPopUp(context, index);
                                                            });
                                                          }
                                                        } else {

                                                          if (usertype == '1') {
                                                            if (model1.walletAmount >= (int.parse(astrologerList[index]['per_minute']) * 5)) {
                                                              bool status = await model.getChatStatus(context, astrologerList[index]['id']);

                                                              if (status) {
                                                                hideLoader();
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
                                                                    showBottomSheetPopUp(context, index);
                                                                  });
                                                                } else {
                                                                  Fluttertoast.showToast(msg: 'Astrologer is busy...');
                                                                  String type = "";
                                                                  if (widget.isCall) {
                                                                    type = "Call";
                                                                  } else {
                                                                    type = "Chat";
                                                                  }
                                                                  await model1.addUserToAstrologerWaitList(astroId: astrologerList[index]['id'], type: type);
                                                                }
                                                              }
                                                            } else {
                                                              debugPrint("$TAG index ===========> $index");
                                                              Future.delayed(const Duration(milliseconds: 100), () {
                                                                showBottomSheetPopUp(context, index);
                                                              });
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
                                                        }
                                                      }
                                                    } else {
                                                      if (model1.walletAmount < (int.parse(astrologerList[index]['per_minute']) * 5)) {
                                                        Future.delayed(const Duration(milliseconds: 100), () {
                                                          showBottomSheetPopUp(context, index);
                                                        });
                                                      } else {
                                                        Fluttertoast.showToast(msg: 'Astrologer is busy...');
                                                        String type = "";
                                                        if (widget.isCall) {
                                                          type = "Call";
                                                        } else {
                                                          type = "Chat";
                                                        }
                                                        await model1.addUserToAstrologerWaitList(astroId: astrologerList[index]['id'], type: type);
                                                      }
                                                    }
                                                  } else {
                                                    hideLoader();
                                                    Fluttertoast.showToast(msg: 'Astrologer is Offline right now.');
                                                  }

                                                  hideLoader();
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(right: 10, top: 10),
                                                  padding: const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: HexColor('#EFEFEF'), width: 1),
                                                  ),
                                                  child: Icon(
                                                    widget.isCall ? Icons.call : Icons.chat_outlined,
                                                    color: colororangeLight,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                        astrologerList[index]['is_busy'] == 1
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
                      },
                    ),
            ),
          ],
        ),
       isProcess ?loadingForKundaliTabs():Container(),
      ],
    );
  }

  showFilterView() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            return Container(
              margin: EdgeInsets.only(top: 2.h),
              child: Wrap(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sort & Filter',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close))
                      ],
                    ),
                  ),
                  Container(
                    height: 1.h,
                  ),
                  dividerHorizontal(),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                          ),
                        ),
                        child: Column(
                          children: [
                            filterParam('Sort by', 0, setState),
                            filterParam('Skill', 1, setState),
                            filterParam('Language', 2, setState),
                            filterParam('Gender', 3, setState),
                            // filterParam('Offer', 4, setState),
                            Container(
                              height: 25.h,
                            ),
                          ],
                        ),
                      ),
                      showDataOfFilterParameter(setState)
                    ],
                  ),
                  dividerHorizontal(),
                  Container(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            resetFilter();
                          },
                          child: Container(
                            width: 40.w,
                            alignment: Alignment.center,
                            child: const Text(
                              'Reset',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (selectedSort != null || selectedSkillCount > 0 || selectedLanguageCount > 0 || selectedGenderCount > 0 /*|| selectedOfferCount > 0*/) {
                              applyFilter();
                            } else {
                              Fluttertoast.showToast(msg: "Please select filter");
                            }
                          },
                          child: Container(
                            height: 6.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: colororangeLight,
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Apply',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 2.h,
                  ),
                ],
              ),
            );
          });
        });
  }

  resetFilter() {
    selectedSort = null;
    selectedSkillCount = 0;
    selectedLanguageCount = 0;
    selectedGenderCount = 0;
    //selectedOfferCount = 0;
    resetAllFilter(languageList);
    resetAllFilter(genderList);
    //resetAllFilter(offerList);
    resetAllFilter(skillList);

    astrologerList.clear();
    astrologerList.addAll(widget.model.astrologerListdb);
    setState(() {});
    Navigator.pop(context);
  }

  resetAllFilter(List<FilterModel> list) {
    for (FilterModel model in list) {
      if (model.isSelected) {
        model.isSelected = false;
      }
    }
  }

  applyFilter() {
    List filterList = [];
    astrologerList = [];
    astrologerList.addAll(widget.model.astrologerListdb);
    if (selectedSort != null) {
      sortListData(astrologerList);
    }

    for (var item in astrologerList) {
      if (checkItemExist(languageList, item['user_language'])) {
        filterList.add(item);
        debugPrint("$TAG apply filter item =======> $item");
        continue;
      }
      if (checkItemExist(skillList, item['user_expertise'])) {
        filterList.add(item);
        continue;
      }
      if (checkItemGenderExist(genderList, item['gender'])) {
        debugPrint("$TAG apply gender List filter item name =======> ${item['name']}");
        debugPrint("$TAG apply gender List filter item gender =======> ${item['gender']}");
        filterList.add(item);
        continue;
      }
    }

    astrologerList.clear();
    astrologerList.addAll(filterList);

    // if (filterList.isNotEmpty) {
    //   astrologerList.clear();
    //   astrologerList.addAll(filterList);
    // }

    setState(() {});
    Navigator.pop(context);
  }

  sortListData(List<dynamic> filterList) {
    if (selectedSort != null) {
      if (selectedSort!.name == 'Experience: Low to High') {
        filterList.sort((a, b) {
          return a['user_experience'].toString().toLowerCase().compareTo(b['user_experience'].toString().toLowerCase());
        });
      } else if (selectedSort!.name == 'Experience: High to Low') {
        filterList.sort((a, b) {
          return b['user_experience'].toString().toLowerCase().compareTo(a['user_experience'].toString().toLowerCase());
        });
      } else if (selectedSort!.name == 'Price: Low to High') {
        filterList.sort((a, b) {
          return int.parse(a['per_minute']).compareTo(int.parse(b['per_minute']));
        });
      } else if (selectedSort!.name == 'Price: High to Low') {
        filterList.sort((a, b) {
          return int.parse(b['per_minute']).compareTo(int.parse(a['per_minute']));
        });
      } else if (selectedSort!.name == 'Rating: High to Low') {
        filterList.sort((a, b) {
          return b['user_rating'].toString().toLowerCase().compareTo(a['user_rating'].toString().toLowerCase());
        });
      }
    }
  }

  checkItemExist(List<FilterModel> list, item) {
    for (FilterModel model in list) {
      if (model.isSelected) {
        if (item != null) {
          debugPrint("check item exist user lang =======> ${item.toLowerCase()}");
          debugPrint("check item exist filter lang =======> ${model.name.toLowerCase()}");
          if (item.toLowerCase().toString().contains(model.name.toLowerCase().toString())) {
            return true;
          }
        }
      }
    }
    return false;
  }

  checkItemGenderExist(List<FilterModel> list, item) {
    for (FilterModel model in list) {
      if (model.isSelected) {
        if (item != null) {
          debugPrint("check item exist user lang =======> ${item.toLowerCase()}");
          debugPrint("check item exist filter lang =======> ${model.name.toLowerCase()}");
          if (item.toLowerCase().toString().startsWith(model.name.toLowerCase().toString())) {
            return true;
          }
        }
      }
    }
    return false;
  }

  Widget showDataOfFilterParameter(setState) {
    if (selectedParameterIndex == 0) {
      return buildSortList(sortList, setState);
    } else if (selectedParameterIndex == 1) {
      return buildParameterList(1, skillList, setState);
    } else if (selectedParameterIndex == 2) {
      return buildParameterList(2, languageList, setState);
    } else if (selectedParameterIndex == 3) {
      return buildParameterList(3, genderList, setState);
    }
    /*else if (selectedParameterIndex == 4) {
      return buildParameterList(4, offerList, setState);
    }*/
    return Container(
      height: 20.h,
    );
  }

  Widget buildSortList(list, setState) {
    return SizedBox(
      height: 50.h,
      width: 55.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 2.h,
          ),
          InkWell(
            onTap: () {
              setState(() {
                selectedSort = null;
              });
            },
            child: Container(
              width: 50.w,
              alignment: Alignment.centerRight,
              child: const Text(
                'Clear',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: 4.h,
          // ),
          ListView.builder(
            itemCount: list.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedSort = list[index];
                  });
                },
                child: Row(
                  children: [
                    Radio<FilterModel>(
                      value: list[index],
                      groupValue: selectedSort,
                      onChanged: (value) {
                        setState(() {
                          selectedSort = list[index];
                        });
                      },
                      fillColor: MaterialStateProperty.all<Color>(colororangeLight),
                    ),
                    SizedBox(
                      width: 41.w,
                      child: Text(
                        list[index].name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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

  Widget buildParameterList(type, list, setState) {
    return SizedBox(
      height: 50.h,
      width: 50.w,
      // margin: EdgeInsets.symmetric(vertical: 1.h),
      child: ListView.builder(
        // physics: ScrollPhysics(),
        itemCount: list.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (!list[index].isSelected) {
                if (type == 1) {
                  selectedSkillCount += 1;
                } else if (type == 2) {
                  selectedLanguageCount += 1;
                } else if (type == 3) {
                  selectedGenderCount += 1;
                } /*else if (type == 4) {
                  selectedOfferCount += 1;
                }*/
              } else {
                if (type == 1) {
                  selectedSkillCount -= 1;
                } else if (type == 2) {
                  selectedLanguageCount -= 1;
                } else if (type == 3) {
                  selectedGenderCount -= 1;
                } /*else if (type == 4) {
                  selectedOfferCount -= 1;
                }*/
              }
              setState(() {
                list[index].isSelected = !list[index].isSelected;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    list[index].isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: colororangeLight,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    list[index].name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget filterParam(String name, int index, setState) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedParameterIndex = index;
        });
      },
      child: Container(
        height: 6.h,
        width: 160,
        decoration: BoxDecoration(
          color: selectedParameterIndex == index ? Colors.white : Colors.grey.shade200,
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            SizedBox(
              width: 30.w,
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if ((index == 0 && selectedSort != null) || (index == 1 && selectedSkillCount > 0) || (index == 2 && selectedLanguageCount > 0) || (index == 3 && selectedGenderCount > 0) /*|| (index == 4 && selectedOfferCount > 0)*/)
              Container(
                height: 1.h,
                width: 1.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colororangeLight,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void showBottomSheetPopUp(BuildContext context, int index) {
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
}

class FilterModel {
  String name;
  bool isSelected;

  FilterModel({required this.name, required this.isSelected});
}
