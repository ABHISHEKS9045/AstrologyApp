import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'order details/orderhistorydetailPage.dart';

Widget planbuylist(context, model) {
  return SingleChildScrollView(
    child: Column(
      children: [
        sizedboxheight(15.0),
        Row(
          children: [
            Text(
              'All order History',
              style: textstyletitleHeading6(context),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        planBuyListWidget(context, model),
        sizedboxheight(50.0),
      ],
    ),
  );
}

Widget planBuyListWidget(context, model) {
  return model.planbuyList.length == 0
      ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: deviceheight(context, 0.6),
              child: Center(
                child: Text(
                  'No History Found',
                  style: textstyleHeading3(context),
                ),
              ),
            ),
          ],
        )
      : ListView.builder(
          physics: const ScrollPhysics(),
          itemCount: model.planbuyList.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                await model.getLastplanexpiredate(model.planbuyList[index]['plan_end']);
                Get.to(() => OrderhistorydetailwPage(currentplan: model.planbuyList[index]));
                await model.getLastplanexpiredate(model.planbuyList[index]['plan_end']);
              },
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
                            text: model.planbuyList[index]['wallet_amount'].toString(),
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
                      model.planbuyList[index]['payment_status'].toUpperCase(),
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
                          'Payment date : ${model.planbuyList[index]['approve_date'].toString()} ',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Transaction id : ${model.planbuyList[index]['trancation_id'].toString()} ',
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
          });
}
