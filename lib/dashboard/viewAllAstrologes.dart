import 'package:astrologyapp/chat/chatlist/chatlistmodelpage.dart';
import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/shimmereffect.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../chat/chatlist/chatinglistPageWidget.dart';
import '../common/MaterialDesignIndicator.dart';
import '../common/appbar/chatpageAppbar.dart';
import '../common/formtextfield/myTextField.dart';

class ViewAllAstrologers extends StatefulWidget {
  final bool isCall;

  const ViewAllAstrologers({super.key, required this.isCall});

  @override
  State<ViewAllAstrologers> createState() => _ViewAllAstrologersState();
}

class _ViewAllAstrologersState extends State<ViewAllAstrologers> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _tabs = [
    const Tab(text: 'Live'),
    const Tab(text: 'Upcoming'),
  ];
  TextEditingController controller = TextEditingController();
  List astrologerList = [];
  Chatlistmodelpage? model;
  int selectedIndex = 0;
  int tabSelectedIndex = 0;

  DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
  String TAG = "_ViewAllAstrologersState";
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
        setState(() {
          if (astrologerList != null && astrologerList.isNotEmpty && firebaseData.isNotEmpty) {
            for (int i = 0; i < firebaseData.length; i++) {
              if(firebaseData[i]["id"] != null && firebaseData[i]["id"].toString() != "null" && firebaseData[i]["id"].toString() != "") {
                if(firebaseData[i]["id"].toString() != "000" && firebaseData[i]["id"].toString() != "'000'") {
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
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      model = Provider.of<Chatlistmodelpage>(context, listen: false);
      await model!.chatUserList(context: context, categoryId: 0, status: "Online");
      await model!.getCategoryList(context);
      await model!.getWalletBalance(context);

      astrologerList.addAll(model!.astrologerListdb);
      getFirebaseDatabaseValue();

      setState(() {});

      controller.addListener(() {
        String searchText = controller.text.toLowerCase();
        astrologerList = [];
        if (searchText.isNotEmpty) {
          for (int i = 0; i < model!.astrologerListdb.length; i++) {
            if (model!.astrologerListdb[i]['name'].toLowerCase().contains(searchText)) astrologerList.add(model!.astrologerListdb[i]);
          }
        } else {
          astrologerList.addAll(model!.astrologerListdb);
        }
        setState(() {});
      });
    });

    _tabController.addListener(() async {
      debugPrint("$TAG controller index =======> ${_tabController.index}");

      if (_tabController.index != tabSelectedIndex) {
        debugPrint("$TAG before update tabSelectedIndex ===========> $tabSelectedIndex");
        setState(() {
          tabSelectedIndex = _tabController.index;
          selectedIndex = 0;
        });
        debugPrint("$TAG after update tabSelectedIndex ===========> $tabSelectedIndex");
        if (_tabController.index == 0) {
          await model!.chatUserList(context: context, categoryId: 0, status: "Online");
        } else if (_tabController.index == 1) {
          await model!.chatUserList(context: context, categoryId: 0, status: "Offline");
        }
        astrologerList.clear();
        astrologerList.addAll(model!.astrologerListdb);
        await getFirebaseDatabaseValue();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    listner.cancel();
    _tabController.dispose();
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
                    child: appbarbackbtnnotification(context, 'ASTROLOGERS'),
                  ),
                  sizedboxheight(15.0),
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: const MaterialDesignIndicator(
                      indicatorHeight: 2,
                      indicatorColor: Colors.white,
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
                  sizedboxheight(5.0),
                  Consumer<Chatlistmodelpage>(builder: (BuildContext context, Chatlistmodelpage model, _) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: padding20),
                      width: deviceWidth(context, 1.0),
                      decoration: decorationtoprounded(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizedboxheight(10.0),
                          // if (!model.isShimmer)
                          AllInputDesign(
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
                            validatorFieldValue: 'name',
                          ),
                          sizedboxheight(10.0),
                          // if (!model.isShimmer)
                          SizedBox(
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
                                      if (_tabController.index == 0) {
                                        await model.chatUserList(context: context, categoryId: int.parse(model.categoryList[index]['id'].toString()), status: "Online");
                                      } else if (_tabController.index == 1) {
                                        await model.chatUserList(context: context, categoryId: int.parse(model.categoryList[index]['id'].toString()), status: "Offline");
                                      }
                                      astrologerList.clear();
                                      astrologerList.addAll(model.astrologerListdb);
                                      await getFirebaseDatabaseValue();
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
                                            width: 1.w
                                          ),
                                          categoryIcons[index],
                                          SizedBox(
                                            width: 1.w
                                          ),
                                          Text(
                                            model.categoryList[index]['category_name'],
                                          ),
                                          SizedBox(
                                            width: 1.w
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          model.isShimmer ? Container(margin: EdgeInsets.only(top: 25.h), child: loadingwidget()) : sizedboxheight(10.0),
                          if (!model.isShimmer)
                            SizedBox(
                              height: 72.h,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  astrologerChatListWidget(context, astrologerList, model, widget.isCall, "Online", controller),
                                  astrologerChatListWidget(context, astrologerList, model, widget.isCall, "Offline", controller),
                                ],
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
}
