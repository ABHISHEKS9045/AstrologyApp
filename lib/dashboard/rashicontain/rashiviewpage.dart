import 'package:astrologyapp/common/appbar/chatpageAppbar.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/shimmereffect.dart';
import '../dashboardModelPage.dart';
import 'rashiviewpageWidget.dart';

class RashiDetailsPage extends StatefulWidget {
  String rashiName;
  String rashiImage;
  String ascendantName;

  RashiDetailsPage({required this.rashiName, required this.rashiImage, required this.ascendantName});

  @override
  _RashiDetailsPageState createState() => _RashiDetailsPageState();
}

class _RashiDetailsPageState extends State<RashiDetailsPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DashboardModelPage>(context, listen: false).rashiDetailsAPI(context, widget.ascendantName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DashboardModelPage>(builder: (BuildContext context, DashboardModelPage model, _) {
        return model.isShimmer
            ? loadingwidget()
            : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/BackGround.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                width: deviceWidth(context, 1.0),
                height: deviceheight(context, 1.0),
                child: model.rashiDetails != null ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            appbarrashiScreen(context, widget.rashiName),
                            sizedboxheight(20.0),
                            Container(
                              child: Column(
                                children: [
                                  headingandTextWidget(context, widget.rashiName, model.rashiDetails, widget.rashiImage),
                                  sizedboxheight(20.0),
                                  // contactInfotWidget(context),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ) : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      appbarrashiScreen(context, widget.rashiName),
                      Container(
                        child: Center(
                          child: Text(
                            "No data available",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
