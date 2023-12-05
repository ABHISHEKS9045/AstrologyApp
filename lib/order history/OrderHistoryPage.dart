import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/shimmereffect.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:astrologyapp/order%20history/OrderHistoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../my wallet/mywalletpage.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var model = Provider.of<OrderHistoryProvider>(context, listen: false);
      await model.getUserType();
      model.getOrderHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Consumer<OrderHistoryProvider>(builder: (context, model, _) {
          return Stack(
            children: [
              bgImagecommon(context),
              SafeArea(
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      sizedboxheight(20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: appbarChatScreen(context, 'Transaction History'),
                      ),
                      sizedboxheight(40.0),
                      Container(
                        padding: const EdgeInsets.all(padding20),
                        width: deviceWidth(context, 1.0),
                        height: deviceheight(context, 0.85),
                        decoration: decorationtoprounded(),
                        child: model.isShimmer
                            ? shimmer()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'All Transaction History',
                                    style: textstyletitleHeading6(context),
                                    textAlign: TextAlign.left,
                                  ),
                                  if (model.userType == "1")
                                    Expanded(
                                      child: model.userOrdersList.isEmpty
                                          ? Center(
                                              child: Text(
                                                'No History Found',
                                                style: textstyleHeading3(context),
                                              ),
                                            )
                                          : ListView.builder(
                                              itemCount: model.userOrdersList.length,
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () async {},
                                                  child: Container(
                                                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                                                    decoration: BoxDecoration(
                                                      color: colorWhite,
                                                      borderRadius: BorderRadius.circular(11),
                                                      border: Border.all(
                                                        color: colorgreyblack.withOpacity(0.2),
                                                      ),
                                                    ),
                                                    child: ListTile(
                                                      title: Container(
                                                        margin: const EdgeInsets.only(top: 5),
                                                        child: RichText(
                                                          text: TextSpan(
                                                            text: '₹ ',
                                                            style: const TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                            children: <TextSpan>[
                                                              TextSpan(
                                                                text: model.userOrdersList[index]['wallet_amount'].toString(),
                                                                style: const TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 15,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      trailing: Container(
                                                        margin: const EdgeInsets.only(bottom: 25),
                                                        child: Text(
                                                          model.userOrdersList[index]['payment_status'].toUpperCase(),
                                                          style: const TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      subtitle: Container(
                                                        padding: const EdgeInsets.only(top: 2, bottom: 10),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              'Date: ${model.userOrdersList[index]['currents_date'].toString()} ',
                                                              style: const TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Transaction id: ${model.userOrdersList[index]['trancation_id'].toString()} ',
                                                              style: const TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                    ),
                                  if (model.userType == "2")
                                    Expanded(
                                      child: model.astrologerOrdersList.isEmpty
                                          ? Center(
                                              child: Text(
                                                'No History Found',
                                                style: textstyleHeading3(context),
                                              ),
                                            )
                                          : ListView.builder(
                                              itemCount: model.astrologerOrdersList.length,
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () async {},
                                                  child: Container(
                                                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                                                    decoration: BoxDecoration(
                                                      color: colorWhite,
                                                      borderRadius: BorderRadius.circular(11),
                                                      border: Border.all(
                                                        color: colorgreyblack.withOpacity(0.2),
                                                      ),
                                                    ),
                                                    child: ListTile(
                                                      title: Container(
                                                        margin: const EdgeInsets.only(top: 5),
                                                        child: RichText(
                                                          text: TextSpan(
                                                            text: '₹ ',
                                                            style: const TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                            children: <TextSpan>[
                                                              TextSpan(
                                                                text: model.astrologerOrdersList[index]['wallet_amount'].toString(),
                                                                style: const TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 15,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      trailing: Container(
                                                        margin: const EdgeInsets.only(bottom: 25),
                                                        child: Text(
                                                          model.astrologerOrdersList[index]['payment_status'].toString().toUpperCase(),
                                                          style: const TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      subtitle: Container(
                                                        padding: const EdgeInsets.only(top: 2, bottom: 10),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              'Date: ${model.astrologerOrdersList[index]['currents_date'].toString()} ',
                                                              style: const TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                            // Text(
                                                            //   'Transaction id: ${model.astrologerOrdersList[index]['trancation_id'].toString()} ',
                                                            //   style: const TextStyle(
                                                            //     color: Colors.black,
                                                            //     fontSize: 13,
                                                            //     fontWeight: FontWeight.w400,
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                    ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget appbarChatScreen(BuildContext context, String title) {
    return AppBar(
      leadingWidth: 36,
      toolbarHeight: 34,
      leading: backButtonLeading(context),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: textstyletitleHeading6(context)!.copyWith(
          color: colorWhite,
          fontWeight: fontWeight900,
          letterSpacing: 1,
          fontSize: 18,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            Get.to(() => MyWalletPage());
          },
          child: const SizedBox(
            width: 30,
            height: 30,
            child: Image(
              image: AssetImage(
                'assets/icons/wallet.png',
              ),
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget backButtonLeading(BuildContext context) {
    return Container(
      width: 36,
      height: 34,
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorgreyblack.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Center(
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: colorblack,
              size: 17,
            ),
          ),
        ),
      ),
    );
  }

}
/*
User
"payment_method" => 'chat_deduct',
"payment_status" => 'deduct',
'payment_method'=> 'refund',
'payment_status'=>  'earn',
Astrologer
"payment_method" => 'chat_earn',
"payment_status" => 'earn',
'payment_method'=> 'withdrawal',
'payment_status'=>  'deduct',


 */