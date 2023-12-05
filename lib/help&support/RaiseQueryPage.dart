import 'package:astrologyapp/help&support/help&supportpageWidget.dart';
import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';

import '../common/appbar/chatpageAppbar.dart';
import '../common/styles/const.dart';
import '../login Page/loginpageWidget.dart';
import 'SupportProvider.dart';

class RaiseQueryPage extends StatefulWidget {

  final String requestType;
  final String? amount;
  final String? requestId;

  const RaiseQueryPage({super.key, required this.requestType, this.amount, this.requestId});

  @override
  State<RaiseQueryPage> createState() => _RaiseQueryPageState();
}

class _RaiseQueryPageState extends State<RaiseQueryPage> {

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
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: appbarbackbtnnotification(
                          context,
                          'RAISE YOUR QUERY',
                        ),
                      ),
                      sizedboxheight(deviceheight(context, 0.04)),
                      Container(
                        width: deviceWidth(context, 1.0),
                        height: deviceheight(context, 0.9),
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
                        child: SingleChildScrollView(
                          child: Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 30),
                                queryDropdownWidget("Query Type", model),
                                const SizedBox(height: 20),
                                writeQueryBoxWidget("Write your query", model),
                                const SizedBox(height: 20),
                                submitButton(context, model, model.type, widget.requestType, widget.amount, widget.requestId),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}