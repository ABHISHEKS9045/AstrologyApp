import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/help&support/SupportProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../common/appbar/chatpageAppbar.dart';
import '../common/shimmereffect.dart';
import '../login Page/loginpageWidget.dart';
import 'help&supportpageWidget.dart';

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  State<HelpSupportPage> createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var model = Provider.of<SupportProvider>(context, listen: false);
      if (mounted) {
        model.loadSupportQueries(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SupportProvider>(builder: (context, model, child) {
      return Scaffold(
        body: Stack(
          children: [
            bgImagecommon(context),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/BackGround.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: appbarbackbtnnotification(
                        context,
                        'HELP & SUPPORT',
                      ),
                    ),
                    sizedboxheight(deviceheight(context, 0.04)),
                    Expanded(
                      child: Container(
                        width: deviceWidth(context, 1.0),
                        height: deviceheight(context, 1.0),
                        decoration: BoxDecoration(
                          color: colorWhite,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/BackGround.png',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: model.isLoading
                            ? Container(
                                margin: EdgeInsets.only(top: 25.h),
                                child: loadingwidget(),
                              )
                            :
                        Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 20),
                                  raiseQuery(context),
                                  const SizedBox(height: 20),
                                  RefreshIndicator(
                                    color: colororangeLight,
                                    onRefresh: () async {
                                      if (mounted) {
                                        await model.loadSupportQueries(false);
                                      }
                                    },
                                    child: Container(

                                      margin: const EdgeInsets.only(left: 20, right: 20),
                                      child: loadSupportTicketsData(context, model),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
