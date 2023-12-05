import 'package:astrologyapp/common/appbar/chatpageAppbar.dart';
import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/generate%20kundli/open%20kundli/ReportTab.dart';
import 'package:astrologyapp/generate%20kundli/open%20kundli/ashtakVargTab.dart';
import 'package:astrologyapp/generate%20kundli/open%20kundli/basicTabScreen.dart';
import 'package:astrologyapp/generate%20kundli/open%20kundli/dashaTabScreen.dart';
import 'package:astrologyapp/generate%20kundli/open%20kundli/kpTabScreen.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../openkundlimodelpage.dart';
import 'chartTabScreen.dart';

class KundlidetailsPage extends StatefulWidget {
  final kundaliList;

  KundlidetailsPage({this.kundaliList});

  @override
  _KundlidetailsPageState createState() => _KundlidetailsPageState();
}

class _KundlidetailsPageState extends State<KundlidetailsPage> with SingleTickerProviderStateMixin {

  String TAG = "_KundlidetailsPageState";

  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();
  final formKey = GlobalKey<FormState>();

  void _printScreen() {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final doc = pw.Document();

      final image = await WidgetWraper.fromKey(
        key: _printKey,
        pixelRatio: 2.0,
      );
      doc.addPage(pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Expanded(
                child: pw.Image(image),
              ),
            );
          }));

      return doc.save();
    });
  }

  late TabController _tabController;

  final _tabs = [
    const Tab(text: 'Basic'),
    const Tab(text: 'Charts'),
    const Tab(text: 'KP'),
    const Tab(text: 'Ashtakvarga'),
    const Tab(text: 'Dasha'),
    const Tab(text: 'Report'),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var list = Provider.of<Openkundlimodelpage>(context, listen: false);
      debugPrint("$TAG kudali Chardasha Details");
      await list.kudaliChardashaDetails(widget.kundaliList);
      debugPrint("$TAG kudali Yogindasha Details");
      await list.kudaliYogindashaDetails(widget.kundaliList);
      debugPrint("$TAG kudali Chart Details");
      await list.kudaliChart(widget.kundaliList, "D1");
      debugPrint("$TAG kudali Panchang Details");
      await list.kudaliPanchangDetails(widget.kundaliList);
      debugPrint("$TAG load Planet Nakshatra Details");
      await list.loadPlanetNakshatraDetails1(widget.kundaliList);
      debugPrint("$TAG load Astro Details");
      await list.loadAstroDetails(widget.kundaliList);
      debugPrint("$TAG load Planet Sign Details");
      await list.loadPlanetSignDetails(widget.kundaliList);
      debugPrint("$TAG load KP Planet Details");
      await list.loadKPPlanetDetails(widget.kundaliList);
      debugPrint("$TAG load KP Cusp Details");
      await list.loadKPCuspDetails(widget.kundaliList);
      debugPrint("$TAG load Rudraksha Recc Details");
      await list.loadRudrakshaRecc(widget.kundaliList);
      debugPrint("$TAG load Gemstone Recc Details");
      await list.loadGemstoneRecc(widget.kundaliList);
      debugPrint("$TAG load Manglik Details");
      await list.loadManglikDetails(widget.kundaliList);
      debugPrint("$TAG load Kalpasara Details");
      await list.loadKalpasaraDetails(widget.kundaliList);
      debugPrint("$TAG load Sadesati Details");
      await list.loadSadesatiDetails(widget.kundaliList);
      debugPrint("$TAG load Current Sadesati Details");
      await list.loadCurrentSadesatiDetails(widget.kundaliList);
      // await list.kudaliPanchangDetails(context,widget.kundaliList);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Openkundlimodelpage>(builder: (BuildContext context, Openkundlimodelpage model, _) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Stack(
            children: [
              bgImagecommon(context),
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    sizedboxheight(40.0),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: appbarbackbtnnotification(context, 'DETAILS')),
                    sizedboxheight(10.0),
                    RepaintBoundary(
                      key: _printKey,
                      child: Container(
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                          width: deviceWidth(context, 1.0),
                          height: deviceheight(context, 0.85),
                          decoration: decorationtoprounded(),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TabBar(
                                  onTap: (index) {
                                    setState(() {
                                      _tabController.index = index;
                                    });
                                  },
                                  isScrollable: true,
                                  controller: _tabController,
                                  labelColor: colororangeLight,
                                  unselectedLabelColor: Colors.black,
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80.0),
                                    color: colororangeLight.withOpacity(0.2),
                                  ),
                                  tabs: _tabs,
                                  // labelPadding: EdgeInsets.symmetric(horizontal: 1.6.w),
                                  // indicatorPadding: EdgeInsets.all(0),
                                  labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                ),
                                sizedboxheight(2.h),

                                Builder(
                                  builder: (_) {
                                    if (_tabController.index == 0) {
                                      return BasicTabScreen(kundaliList: widget.kundaliList);
                                    } else if (_tabController.index == 1) {
                                      return ChartTab(
                                        kundaliList: widget.kundaliList,
                                      );
                                    } else if (_tabController.index == 2) {
                                      return KPTabScreen(
                                        kundaliList: widget.kundaliList,
                                      );
                                    } else if (_tabController.index == 3) {
                                      return AshtakVargTabScreen(
                                        kundaliList: widget.kundaliList,
                                      );
                                    } else if (_tabController.index == 4) {
                                      return DashaTabScreen(
                                        kundaliList: widget.kundaliList,
                                      );
                                    } else {
                                      return ReportTabScreen(kundaliList: widget.kundaliList);
                                    }
                                  },
                                )
                                // sizedboxheight(30.0),
                                /*TabBarView(
                                  controller: _tabController,
                                  children: [
                                    BasicTabScreen(kundaliList: widget.kundaliList),
                                    ChartTab(kundaliList: widget.kundaliList,),
                                    DashaTabScreen(kundaliList: widget.kundaliList)
                                    // userBasicDetailsTab(context, widget.kundaliList),
                                    // detailuserkundliImage1(context, widget.kundaliList),
                                    // panchangBirthdetail(context),
                                    // userBirthDetails(context, widget.kundaliList),
                                    // userAstroDetails(context, widget.kundaliList),
                                  ],
                                ),*/
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 40,
                right: 10,
                child: GestureDetector(
                  onTap: _printScreen,
                  child: const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

/*
class KundlidetailsPage extends StatelessWidget {
  KundlidetailsPage({Key? key, this.kundlilist}) : super(key: key);

}
*/
