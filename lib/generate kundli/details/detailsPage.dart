import 'package:astrologyapp/common/appbar/chatpageAppbar.dart';
import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/generate%20kundli/ReportTabGenerate.dart';
import 'package:astrologyapp/generate%20kundli/generatekundaliModelPage.dart';
import 'package:astrologyapp/generate%20kundli/kpTabGenerate.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../ashtakVargTabGenerate.dart';
import '../basicTabScreenGenerate.dart';
import '../chartTabScreenGenerate.dart';
import '../dashaTabScreenGenerate.dart';

class DetailKundliPage extends StatefulWidget {
  final model;

  DetailKundliPage({this.model});

  @override
  _DetailKundliPageState createState() => _DetailKundliPageState();
}

class _DetailKundliPageState extends State<DetailKundliPage> with TickerProviderStateMixin {
  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();

  final formKey = GlobalKey<FormState>();
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
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      // Future.delayed(Duration(seconds: 3));

      // var list = Provider.of<GenratekundliModelPage>(context, listen: false);
      await widget.model.kudaliChardashaDetails(context, widget.model);
      await widget.model.kudaliPanchangDetails(context, widget.model);
      await widget.model.loadPlanetNakshtraDetails(context, widget.model);
      await widget.model.loadAstroDetails(context, widget.model);
      await widget.model.loadPlanetSignDetails(context, widget.model);
      await widget.model.loadKPPlanetDetails(context, widget.model);
      await widget.model.loadKPCuspDetails(context, widget.model);
      await widget.model.loadRudrakshaRecc(context, widget.model);
      await widget.model.loadGemstoneRecc(context, widget.model);
      await widget.model.loadManglikDetails(context, widget.model);
      await widget.model.loadKalpasaraDetails(context, widget.model);
      await widget.model.loadSadesatiDetails(context, widget.model);
      await widget.model.YoginidahsDetails(context, widget.model);
      await widget.model.loadCurrentSadesatiDetails(context, widget.model);

      // print('open kundli list init');
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            bgImagecommon(context),
            Consumer<GenratekundliModelPage>(builder: (context, model, _) {
              return Container(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      sizedboxheight(10.0),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: appbarbackbtnnotification(context, 'DETAILS')),
                      sizedboxheight(18.0),
                      RepaintBoundary(
                        key: _printKey,
                        child: Container(
                            padding: const EdgeInsets.all(padding20),
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
                                        return BasicTabScreenGenerate(kundaliList: model);
                                      } else if (_tabController.index == 1) {
                                        return ChartTabGenerate(
                                          kundaliList: model,
                                        );
                                      } else if (_tabController.index == 2) {
                                        return KPTabGenerate(
                                          kundaliList: model,
                                        );
                                      } else if (_tabController.index == 3) {
                                        return AshtakVargTabGenerate(
                                          kundaliList: model,
                                        );
                                      } else if (_tabController.index == 4) {
                                        return DashaTabScreenGenerate(kundaliList: model);
                                      } else {
                                        return ReportTabGenerate(kundaliList: model);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              );
            }),
            Positioned(
              top: 40,
              right: 10,
              child: GestureDetector(
                onTap: _printScreen,
                child: const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*class DetailKundliPage extends StatelessWidget {
  DetailKundliPage({Key? key}) : super(key: key);
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

  final _selectedColor = Color(0xff1a73e8);
  final _unselectedColor = Color(0xff5f6368);
  final _tabs = [
    Tab(text: 'Tab1'),
    Tab(text: 'Tab2'),
    Tab(text: 'Tab3'),
  ];



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            bgImagecommon(context),
            SafeArea(child: Consumer<GenratekundliModelPage>(builder: (context, model, _) {
              return Container(
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      sizedboxheight(10.0),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: appbarbackbtnnotification(context, 'DETAILS')),
                      sizedboxheight(18.0),

                      RepaintBoundary(
                        key: _printKey,
                        child: Container(
                            padding: EdgeInsets.all(padding20),
                            width: deviceWidth(context, 1.0),
                            height: deviceheight(context, 0.85),
                            decoration: decorationtoprounded(),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TabBar(
                                    controller: _tabController,
                                    labelColor: _selectedColor,
                                    unselectedLabelColor: _unselectedColor,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    indicator: MaterialDesignIndicator(
                                        indicatorHeight: 4, indicatorColor: _selectedColor),
                                    tabs: _tabs,
                                  ),
                                  sizedboxheight(20.0),
                                  userkundlidetailcontainer(context, model),
                                  sizedboxheight(20.0),
                                  detailuserkundliImage(context, model),
                                  // panchangBirthdetail(context),
                                  sizedboxheight(20.0)
                                ],
                              ),
                            )),
                      ),
                      sizedboxheight(50.0),
                    ],
                  ),
                ),
              );
            })),
            Positioned(
              top: 40,
              right: 10,
              child: GestureDetector(
                onTap: _printScreen,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
