import 'package:astrologyapp/common/appbar/appbarcustom.dart';
import 'package:astrologyapp/common/shimmereffect.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/dashboard/dashboardModelPage.dart';
import 'package:astrologyapp/plan/planModelPage.dart';
import 'package:astrologyapp/plan/planwidgetpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({Key? key}) : super(key: key);

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  // ignore: unused_field
  static const platform = const MethodChannel('razorpay_flutter');

  @override
  void initState() {
    super.initState();
    var model = Provider.of<PlanModelPage>(context, listen: false);
    Future.delayed(Duration(seconds: 1));
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await model.viewplan(context);
      var dbcontroller = Provider.of<DashboardModelPage>(context, listen: false);
      if (!dbcontroller.isGeustLoggedIn) {
        // print('plan last date');
        await model.getLastplanexpiredate(context);
      }
    });
    model.razorpay = Razorpay();
    model.razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, model.handlePaymentSuccess);
    model.razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, model.handlePaymentError);
    model.razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, model.handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<PlanModelPage>(builder: (context, modal, _) {
          return modal.isShimmer
              ? shimmer()
              : Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  width: deviceWidth(context, 1.0),
                  height: deviceheight(context, 1.0),
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/BackGround.png'), fit: BoxFit.fill)),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      sizedboxheight(15.0),
                      AppBarCustom(
                        title: 'PLAN',
                      ),
                      // unlockpremiumwidget(context),
                      sizedboxheight(20.0),
                      planbanifitwidget(),
                      sizedboxheight(20.0),
                      mostpopularwidget(context, modal),
                      sizedboxheight(15.0),
                      monthlyPlanwidget(context, modal),
                      sizedboxheight(15.0),
                      yearlyPlanwidget(context, modal),
                      sizedboxheight(15.0),
                      startplanbtn(context, modal),
                    ],
                  )),
                );
        }),
      ),
    );
  }
}
