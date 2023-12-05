import 'package:astrologyapp/common/shimmereffect.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../common/MaterialDesignIndicator.dart';
import '../../common/commonwidgets/commonWidget.dart';
import '../openkundlimodelpage.dart';

class ChartTab extends StatefulWidget {
  final kundaliList;

  const ChartTab({Key? key, this.kundaliList}) : super(key: key);

  @override
  _ChartTabState createState() => _ChartTabState();
}

class _ChartTabState extends State<ChartTab> with TickerProviderStateMixin {
  ChartModel? selectedChart;

  List<ChartModel> items = [
    ChartModel(id: 'SUN', name: 'Sun Chart'),
    ChartModel(id: 'MOON', name: 'Moon Chart'),
    ChartModel(id: 'D1', name: 'Birth Chart'),
    ChartModel(id: 'D2', name: 'Hora Chart'),
    ChartModel(id: 'D3', name: 'Dreshkan Chart'),
    ChartModel(id: 'D4', name: 'Chathurthamasha Chart'),
    ChartModel(id: 'D5', name: 'Panchmansha Chart'),
    ChartModel(id: 'D7', name: 'Saptamansha Chart'),
    ChartModel(id: 'D8', name: 'Ashtamansha Chart'),
    ChartModel(id: 'D9', name: 'Navamansha Chart'),
    ChartModel(id: 'D10', name: 'Dashamansha Chart'),
    ChartModel(id: 'D12', name: 'Dwadashamsha Chart'),
    ChartModel(id: 'D16', name: 'Shodashamsha Chart'),
    ChartModel(id: 'D20', name: 'Vishamansha Chart'),
    ChartModel(id: 'D24', name: 'Chaturvimshamsha Chart'),
    ChartModel(id: 'D27', name: 'Bhamsha Chart'),
    ChartModel(id: 'D30', name: 'Trishamansha Chart'),
    ChartModel(id: 'D40', name: 'Khavedamsha Chart'),
    ChartModel(id: 'D45', name: 'Akshvedansha Chart'),
    ChartModel(id: 'D60', name: 'Shashtymsha Chart'),
    ChartModel(id: 'chalit', name: 'Chalit Chart'),
  ];
  final List<Tab> _tabs = [
    const Tab(text: 'Sun Chart'),
    const Tab(text: 'Moon Chart'),
    const Tab(text: 'Birth Chart'),
    const Tab(text: 'Hora Chart'),
    const Tab(text: 'Dreshkan Chart'),
    const Tab(text: 'Chathurthamasha Chart'),
    const Tab(text: 'Panchmansha Chart'),
    const Tab(text: 'Saptamansha Chart'),
    const Tab(text: 'Ashtamansha Chart'),
    const Tab(text: 'Navamansha Chart'),
    const Tab(text: 'Dashamansha Chart'),
    const Tab(text: 'Dwadashamsha Chart'),
    const Tab(text: 'Shodashamsha Chart'),
    const Tab(text: 'Vishamansha Chart'),
    const Tab(text: 'Chaturvimshamsha Chart'),
    const Tab(text: 'Bhamsha Chart'),
    const Tab(text: 'Trishamansha Chart'),
    const Tab(text: 'Khavedamsha Chart'),
    const Tab(text: 'Akshvedansha Chart'),
    const Tab(text: 'Shashtymsha Chart'),
    const Tab(text: 'Chalit Chart'),
  ];
  late String _selectedChart;
  var chartTypes = [
    const Tab(
      text: 'Lagna',
    ),
    const Tab(
      text: 'Navamsa',
    ),
    const Tab(
      text: 'Transit',
    ),
    const Tab(
      text: 'Divisional',
    )
  ];
  late TabController _tabController;
  late TabController _chartTypeTabController;

  String selectedPlanet = "Sign";
  int kundaliIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 21, vsync: this);
    _chartTypeTabController = TabController(length: 4, vsync: this);
    // selectedChart = items[0];

    var list = Provider.of<Openkundlimodelpage>(context, listen: false);
    _tabController.addListener(() async {
      await list.kudaliChart(widget.kundaliList, items[_tabController.index].id);
    });

    _chartTypeTabController.addListener(() async {
      if (_chartTypeTabController.index == 1) {
        await list.kudaliChart(widget.kundaliList, 'D9');
      } else {
        await list.kudaliChart(widget.kundaliList, 'D1');
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(const Duration(seconds: 3));

      var list = Provider.of<Openkundlimodelpage>(context, listen: false);
      await list.kudaliChart(widget.kundaliList, 'D1');
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _chartTypeTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Openkundlimodelpage>(builder: (context, model, _) {
      return model.isShimmer
          ? Center(child: loadingForKundaliTabs())
          : SizedBox(
              height: 73.h,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      controller: _chartTypeTabController,
                      isScrollable: true,
                      labelColor: colororangeLight,
                      unselectedLabelColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: MaterialDesignIndicator(
                        indicatorHeight: 4,
                        indicatorColor: colororangeLight,
                      ),
                      tabs: chartTypes,
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      height: 50.h,
                      child: TabBarView(
                        controller: _chartTypeTabController,
                        children: [
                          SvgPicture.string(model.chartImage),
                          SvgPicture.string(model.chartImage),
                          SvgPicture.string(model.chartImage),
                          devotionalChartType(model),
                        ],
                      ),
                    ),
                    dividerHorizontal(),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Text(
                      'Planets',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedPlanet = 'Sign';
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 0.7.h,
                              horizontal: 5.w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: selectedPlanet == 'Sign' ? colororangeLight.withOpacity(0.2) : Colors.white,
                              border: Border.all(
                                color: selectedPlanet == 'Sign' ? colororangeLight : Colors.grey,
                                width: 2,
                              ),
                            ),
                            child: const Text(
                              'Sign',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedPlanet = 'Nakshatra';
                              // print(model.planetNakhatra1Details);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 0.7.h, horizontal: 5.w),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: selectedPlanet != 'Sign' ? colororangeLight.withOpacity(0.2) : Colors.white, border: Border.all(color: selectedPlanet != 'Sign' ? colororangeLight : Colors.grey, width: 2)),
                            child: const Text(
                              'Nakshatra',
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 2.h),
                    selectedPlanet == 'Sign' ? signPlanetView(model) : nakshatraPlanetView(model),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            );
    });
  }

  signPlanetView(model) {
    List<Widget> list = [signRow('Planet', 'Sign', 'Sign Lord', "Degree", 'House', true)];

    model.planetSignDetails.forEach((element) {
      list.add(signRow(element['name'], element['sign'], element['signLord'], element['normDegree'].toStringAsPrecision(3) + '°', element['house'], false));
    });
    return Column(
      children: [
        Container(
          height: 50.h,
          decoration: BoxDecoration(
            border: borderCustom(),
            borderRadius: borderRadiuscircular(15.0),
          ),
          child: Column(
            children: list,
          ),
        ),
        SizedBox(height: 2.h),
        Container(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'UnderStanding Your Kundli',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    )),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          kundaliIndex = 0;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: kundaliIndex == 0 ? colororangeLight.withOpacity(0.2) : Colors.white, border: Border.all(color: kundaliIndex == 0 ? colororangeLight : Colors.grey, width: 2)),
                        child: const Text(
                          'General',
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          kundaliIndex = 1;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: kundaliIndex == 1 ? colororangeLight.withOpacity(0.2) : Colors.white, border: Border.all(color: kundaliIndex == 1 ? colororangeLight : Colors.grey, width: 2)),
                        child: const Text(
                          'Planetary',
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          kundaliIndex = 2;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: kundaliIndex == 2 ? colororangeLight.withOpacity(0.2) : Colors.white, border: Border.all(color: kundaliIndex == 2 ? colororangeLight : Colors.grey, width: 2)),
                        child: const Text(
                          'Yog',
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )),
        SizedBox(height: 2.h),
        IndexedStack(
          index: kundaliIndex,
          children: [
            Container(
              child: Column(
                children: [
                  understandKundali('Description', sighDescription),
                  understandKundali(
                    'Personality',
                    signPersonality,
                  ),
                  understandKundali(
                    'Health',
                    signPersonality,
                  ),
                  understandKundali(
                    'Career',
                    signCareer,
                  ),
                  understandKundali(
                    'Relationship',
                    signPersonality,
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  understandKundali('Sun Consideration', signSunConsi),
                  understandKundali(
                    'Moon Consideration',
                    signmoonConsi,
                  ),
                  understandKundali(
                    'Mercury Consideration',
                    signMercuryConsi,
                  ),
                  understandKundali(
                    'Venus Consideration',
                    signVenusConsi,
                  ),
                  understandKundali(
                    'Mars Consideration',
                    signMarsConsi,
                  ),
                  understandKundali(
                    'Jupiter Consideration',
                    signJupiterConsi,
                  ),
                  understandKundali(
                    'Saturn Consideration',
                    signsaturnConsi,
                  ),
                  understandKundali(
                    'Rahu Consideration',
                    signRahuConsi,
                  ),
                  understandKundali(
                    'Ketu Consideration',
                    signKetuConsi,
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  understandKundali('Vesi Yoga', signVesiYoga),
                  understandKundali(
                    'Lakshmi Yoga',
                    signmoonConsi,
                  ),
                  understandKundali(
                    'Kemadruma Yoga',
                    signMercuryConsi,
                  ),
                  understandKundali(
                    'Sakata Yoga',
                    signVenusConsi,
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  nakshatraPlanetView(
    model,
  ) {
    List<Widget> list = [nakshatraRow('Planet', 'Nakshatra', 'Naksh Lord', 'House', true)];

    model.planetNakhatra1Details.forEach((element) {
      list.add(nakshatraRow(element['name'], element['nakshatra'], element['nakshatraLord'], element['house'].toString(), false));
    });

    return Column(
      children: [
        Container(
          height: 50.h,
          decoration: BoxDecoration(
            border: borderCustom(),
            borderRadius: borderRadiuscircular(15.0),
          ),
          child: Column(
            children: list,
          ),
        ),
        SizedBox(height: 2.h),
        Container(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'UnderStanding Your Kundli',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    )),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          kundaliIndex = 0;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 0.7.h, horizontal: 5.w),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: kundaliIndex == 0 ? colororangeLight.withOpacity(0.2) : Colors.white, border: Border.all(color: kundaliIndex == 0 ? colororangeLight : Colors.grey, width: 2)),
                        child: const Text(
                          'General',
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          kundaliIndex = 1;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 0.7.h, horizontal: 5.w),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: kundaliIndex == 1 ? colororangeLight.withOpacity(0.2) : Colors.white, border: Border.all(color: kundaliIndex == 1 ? colororangeLight : Colors.grey, width: 2)),
                        child: const Text(
                          'Planetary',
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          kundaliIndex = 2;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 0.7.h, horizontal: 5.w),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: kundaliIndex == 2 ? colororangeLight.withOpacity(0.2) : Colors.white, border: Border.all(color: kundaliIndex == 2 ? colororangeLight : Colors.grey, width: 2)),
                        child: const Text(
                          'Yog',
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )),
        SizedBox(height: 2.h),
        IndexedStack(
          index: kundaliIndex,
          children: [
            Container(
              child: Column(
                children: [
                  understandKundali('Description', sighDescription),
                  understandKundali(
                    'Personality',
                    signPersonality,
                  ),
                  understandKundali(
                    'Health',
                    signPersonality,
                  ),
                  understandKundali(
                    'Career',
                    signCareer,
                  ),
                  understandKundali(
                    'Relationship',
                    signPersonality,
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  understandKundali('Sun Consideration', signSunConsi),
                  understandKundali(
                    'Moon Consideration',
                    signmoonConsi,
                  ),
                  understandKundali(
                    'Mercury Consideration',
                    signMercuryConsi,
                  ),
                  understandKundali(
                    'Venus Consideration',
                    signVenusConsi,
                  ),
                  understandKundali(
                    'Mars Consideration',
                    signMarsConsi,
                  ),
                  understandKundali(
                    'Jupiter Consideration',
                    signJupiterConsi,
                  ),
                  understandKundali(
                    'Saturn Consideration',
                    signsaturnConsi,
                  ),
                  understandKundali(
                    'Rahu Consideration',
                    signRahuConsi,
                  ),
                  understandKundali(
                    'Ketu Consideration',
                    signKetuConsi,
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  understandKundali('Vesi Yoga', signVesiYoga),
                  understandKundali(
                    'Lakshmi Yoga',
                    signmoonConsi,
                  ),
                  understandKundali(
                    'Kemadruma Yoga',
                    signMercuryConsi,
                  ),
                  understandKundali(
                    'Sakata Yoga',
                    signVenusConsi,
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  understandKundali(heading, content) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: borderCustom(),
        borderRadius: borderRadiuscircular(15.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 1.h),
          Text(
            content,
            style: TextStyle(fontSize: 14, height: 0.17.h, fontWeight: FontWeight.w400, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  devotionalChartType(model) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: colororangeLight,
          unselectedLabelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          indicator: MaterialDesignIndicator(indicatorHeight: 4, indicatorColor: colororangeLight),
          tabs: _tabs,
          labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 40.h,
          child: TabBarView(
            controller: _tabController,
            children: [
              SvgPicture.string(model.chartImage),
              SvgPicture.string(model.chartImage),
              SvgPicture.string(model.chartImage),
              SvgPicture.string(model.chartImage),
              SvgPicture.string(model.chartImage),
              SvgPicture.string(model.chartImage),
              SvgPicture.string(model.chartImage),
              SvgPicture.string(model.chartImage),
              SvgPicture.string(model.chartImage),
              SvgPicture.string(model.chartImage),
              SvgPicture.string(model.chartImage),
              SvgPicture.string(model.chartImage),
              SvgPicture.string(model.chartImage),
              SvgPicture.string(model.chartImage),
              SvgPicture.string(model.chartImage),
              SvgPicture.string(model.chartImage),
              SvgPicture.string(model.chartImage),
              SvgPicture.string(model.chartImage),
              SvgPicture.string(model.chartImage),
              SvgPicture.string(model.chartImage),
              SvgPicture.string(model.chartImage),
            ],
          ),
        ),
      ],
    );
  }

  signRow(name, sign, signLord, degree, house, isHeader) {
    return Expanded(
      child: Container(
        decoration: isHeader ? BoxDecoration(color: colororangeLight.withOpacity(0.4), borderRadius: const BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))) : const BoxDecoration(),
        padding: const EdgeInsets.only(right: 5, left: 5),
        width: double.maxFinite,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 12),
              width: 15.2.w,
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: textstylesubtitle1(context)!.copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            dividerVertical(),
            // sizedboxheight(3.0),
            SizedBox(
              width: 18.w,
              child: Text(
                sign,
                style: textstylesubtitle1(context)!.copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            // SizedBox(width: 3.w,),
            dividerVertical(),
            // SizedBox(width: 3.w,),
            SizedBox(
              width: 18.w,
              child: Text(
                signLord,
                style: textstylesubtitle1(context)!.copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            dividerVertical(),
            SizedBox(
              width: 18.w,
              child: Text(
                degree,
                style: textstylesubtitle1(context)!.copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            dividerVertical(),
            SizedBox(
              width: 16.w,
              child: Text(
                house.toString(),
                style: textstylesubtitle1(context)!.copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  nakshatraRow(palnet, nakshtra, nakshLord, house, isHeader) {
    return Expanded(
      child: Container(
        decoration: isHeader ? BoxDecoration(color: colororangeLight.withOpacity(0.4), borderRadius: const BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))) : const BoxDecoration(),
        padding: const EdgeInsets.only(right: 5, left: 5),
        width: double.maxFinite,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 22.w,
              child: Text(
                palnet,
                // 'Planet',
                overflow: TextOverflow.ellipsis,
                style: textstylesubtitle1(context)!.copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            dividerVertical(),
            // sizedboxheight(3.0),
            SizedBox(
              width: 22.w,
              child: Text(
                nakshtra,
                // "Nakshtra",
                style: textstylesubtitle1(context)!.copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            // SizedBox(width: 3.w,),
            dividerVertical(),
            // SizedBox(width: 3.w,),
            SizedBox(
              width: 22.w,
              child: Text(
                nakshLord,
                // "Naksh Lord",
                style: textstylesubtitle1(context)!.copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            dividerVertical(),
            SizedBox(
              width: 22.w,
              child: Text(
                house,
                // "House",
                style: textstylesubtitle1(context)!.copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChartModel {
  String id;
  String name;

  ChartModel({required this.id, required this.name});
}
