import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../common/appbar/chatpageAppbar.dart';
import '../common/shimmereffect.dart';
import '../common/styles/const.dart';
import '../login Page/loginpageWidget.dart';
import 'SupportProvider.dart';
import 'help&supportpageWidget.dart';

class CustomerRefundRaiseQueryPage extends StatefulWidget {

  final String requestType;
  final String amount;
  final String requestId;


  const CustomerRefundRaiseQueryPage({super.key, required this.requestType, required this.amount, required this.requestId});

  @override
  State<CustomerRefundRaiseQueryPage> createState() => _CustomerRefundRaiseQueryPageState();
}

class _CustomerRefundRaiseQueryPageState extends State<CustomerRefundRaiseQueryPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var model = Provider.of<SupportProvider>(context, listen: false);
      model.getRequestDetails(widget.requestType, widget.requestId);
    });
    super.initState();
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
                            child: model.isLoading
                                ? Container(
                              margin: EdgeInsets.only(top: 25.h),
                              child: loadingwidget(),
                            ): Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 30),
                                showAstrologerInfo(context, model),
                                const SizedBox(height: 20),
                                // queryDropdownWidget("Query Type", model),
                                const SizedBox(height: 20),
                                writeQueryBoxWidget("Write your query", model),
                                const SizedBox(height: 20),
                                submitButton(context, model, "1", widget.requestType, widget.amount, widget.requestId),
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
