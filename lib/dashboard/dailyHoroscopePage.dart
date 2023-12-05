import 'package:astrologyapp/common/shimmereffect.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../common/MaterialDesignIndicator.dart';
import '../common/appbar/chatpageAppbar.dart';
import '../common/styles/const.dart';
import 'dashboardModelPage.dart';

class DailyHoroscopePage extends StatefulWidget {
  const DailyHoroscopePage({Key? key}) : super(key: key);

  @override
  State<DailyHoroscopePage> createState() => _DailyHoroscopePageState();
}

class _DailyHoroscopePageState extends State<DailyHoroscopePage> with TickerProviderStateMixin {

  List rashiImageList = [
    'assets/icons/meshimage.png',
    'assets/icons/vrashabRashi.png',
    'assets/icons/mithun.png',
    'assets/icons/kark.png',
    'assets/icons/singh.png',
    'assets/icons/kanya.png',
    'assets/icons/tula.png',
    'assets/icons/vrashichik.png',
    'assets/icons/dhanu.png',
    'assets/icons/makar.png',
    'assets/icons/kumbh.png',
    'assets/icons/meen.png'
  ];
  List rashinameList = ['Mesh', 'Vrashub', 'Mithun', 'Kark', 'Singh', 'Kanya', 'Tula', 'Vrushichik', 'Dhanu', 'Makar', 'Kumbha', 'Meen'];
  List ascendantList = ['aries', 'taurus', 'gemini', 'cancer', 'leo', 'virgo', 'libra', 'scorpius', 'sagittarius', 'capricorn', 'aquarius', 'pisces'];

  var selectedIndex = 0;
  var tabs = [
    Tab(
      text: 'Yesterday',
    ),
    Tab(
      text: 'Today',
    ),
    Tab(
      text: 'Tomorrow',
    ),
  ];
  late TabController _tabController;
  var list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    list = Provider.of<DashboardModelPage>(context, listen: false);

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      Future.delayed(Duration(seconds: 1));
      await list.rashiDetailsAPI(context, ascendantList[selectedIndex]);
      await list.previousRashiDetailsAPI(context, ascendantList[selectedIndex]);
      await list.nextRashiDetailsAPI(context, ascendantList[selectedIndex]);
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime day = DateTime.now();
    String dateString = DateFormat('dd-MM-yyyy').format(day);
    String pdateString = DateFormat('dd-MM-yyyy').format(day.subtract(Duration(days: 1)));
    String ndateString = DateFormat('dd-MM-yyyy').format(day.add(Duration(days: 1)));
    return Consumer<DashboardModelPage>(builder: (context, model, _) {
      return Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'assets/BackGround.png',
              fit: BoxFit.fill,
            ),
            if (model.isShimmer)
              loadingwidget()
            else if(model.previousRashiDetails != null && model.rashiDetails != null && model.nextRashiDetails != null)
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      appbarrashiScreen(context, 'Daily Horoscope'),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          height: 15.h,
                          child: ListView.builder(
                            itemCount: rashinameList.length,
                            scrollDirection: Axis.horizontal,
                            physics: AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  await list.rashiDetailsAPI(context, ascendantList[index]);
                                  await list.previousRashiDetailsAPI(context, ascendantList[index]);
                                  await list.nextRashiDetailsAPI(context, ascendantList[index]);

                                  setState(() {
                                    selectedIndex = index;
                                  });
                                  // RashiContainviewPage(
                                  //   rashiName: rashinameList[index],
                                  //   rashiContain: rashiContainList[index],
                                  //   rashirashiImageList: rashirashiImageList[index],
                                  // ));
                                },
                                child: Container(
                                  // width: 80,
                                  height: 100,
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: colorWhite,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 1.w),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 10,
                                              offset: Offset(3, 3),
                                            ),
                                          ],
                                        ),
                                        padding: EdgeInsets.all(10),
                                        child: Image(
                                          image: AssetImage(rashiImageList[index]),
                                          height: 5.h,
                                          width: 5.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      sizedboxheight(5.0),
                                      Text(
                                        rashinameList[index],
                                        overflow: TextOverflow.ellipsis,
                                        style: textstylesubtitle1(context)!.copyWith(color: selectedIndex == index ? colororangeLight : Colors.black),
                                      )
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
                        TabBar(
                          controller: _tabController,
                          labelColor: colororangeLight,
                          unselectedLabelColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: MaterialDesignIndicator(indicatorHeight: 4, indicatorColor: colororangeLight),
                          tabs: tabs,
                          labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        SizedBox(
                          height: 80.h,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              horoscopeView(model.previousRashiDetails, pdateString),
                              horoscopeView(model.rashiDetails, dateString),
                              horoscopeView(model.nextRashiDetails, ndateString),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              )
            else
              showEmptyView()
          ],
        ),
      );
    });
  }

  horoscopeView(rashiDetails, dateString) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 95.w,
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: colororangeLight, width: 2)),
            child: Column(
              children: [
                Text(
                  dateString,
                  style: TextStyle(color: colororangeLight, fontWeight: FontWeight.w500, fontSize: 21),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  'Your daily horoscope is ready!',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lucky Colors',
                          style: TextStyle(fontSize: 19),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'White',
                          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lucky Number',
                          style: TextStyle(fontSize: 19),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          '8',
                          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            'Daily Horoscope',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.redAccent, width: 2), borderRadius: BorderRadius.circular(15), color: Colors.redAccent.withOpacity(0.1)),
            padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 4.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      'Love',
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  rashiDetails['personal_life'],
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.black12.withOpacity(0.5), fontSize: 16, height: 0.16.h),
                )
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.orangeAccent, width: 2), borderRadius: BorderRadius.circular(15), color: Colors.orangeAccent.withOpacity(0.1)),
            padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 4.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.shopping_bag,
                      color: Colors.orangeAccent,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      'Career',
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  rashiDetails['profession'],
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.black12.withOpacity(0.5), fontSize: 16, height: 0.16.h),
                )
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.green, width: 2), borderRadius: BorderRadius.circular(15), color: Colors.green.withOpacity(0.1)),
            padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 4.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.medical_services,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      'Health',
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  rashiDetails['health'],
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.black12.withOpacity(0.5), fontSize: 16, height: 0.16.h),
                )
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.yellow, width: 2), borderRadius: BorderRadius.circular(15), color: Colors.yellow.withOpacity(0.1)),
            padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 4.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      'Luck',
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  rashiDetails['luck'],
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.black12.withOpacity(0.5), fontSize: 16, height: 0.16.h),
                )
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.pinkAccent, width: 2), borderRadius: BorderRadius.circular(15), color: Colors.purpleAccent.withOpacity(0.1)),
            padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 4.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.airplanemode_active,
                      color: Colors.pinkAccent,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      'Travel',
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  rashiDetails['travel'],
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.black12.withOpacity(0.5), fontSize: 16, height: 0.16.h),
                )
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.lightBlueAccent, width: 2), borderRadius: BorderRadius.circular(15), color: Colors.lightBlueAccent.withOpacity(0.1)),
            padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 4.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.water_drop,
                      color: Colors.lightBlueAccent,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      'Emotions',
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  rashiDetails['emotions'],
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.black12.withOpacity(0.5), fontSize: 16, height: 0.16.h),
                )
              ],
            ),
          ),
          SizedBox(
            height: 17.h,
          ),
        ],
      ),
    );
  }

  Widget showEmptyView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          appbarrashiScreen(context, 'Daily Horoscope'),
          Spacer(),
          Center(
            child: Text(
              "Services not available at this time.",
              style: TextStyle(color: colororangeLight, fontWeight: FontWeight.w500, fontSize: 21),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}