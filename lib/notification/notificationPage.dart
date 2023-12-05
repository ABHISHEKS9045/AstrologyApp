import 'package:astrologyapp/common/appbar/appbarcustom.dart';
import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:astrologyapp/notification/notificationModelPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/appbar/appbarmodal.dart';
import 'notificationpageWidget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var list = Provider.of<NotificationModelPage>(context, listen: false);
      await list.getNotificationList(context, '1');
      if(mounted) {
        var model = Provider.of<AppBarModalPage>(context, listen: false);
        model.resetCount();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop({'result': true});
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            bgImagecommon(context),
            SafeArea(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: AppBarCustom(
                        title: 'NOTIFICATION',
                      ),
                    ),
                    sizedboxheight(20.0),
                    Consumer<NotificationModelPage>(builder: (context, model, _) {
                      return Container(
                        padding: const EdgeInsets.all(padding20),
                        width: deviceWidth(context, 1.0),
                        height: deviceheight(context, 1.0),
                        decoration: decorationtoprounded(),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: deviceheight(context, 0.8),
                                child: notificationListWidget(context, model),
                              ),
                              sizedboxheight(50.0)
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
