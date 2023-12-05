import 'package:astrologyapp/common/commonwidgets/button.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget walletbelenceWidget(context, amount) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: InkWell(
      // onTap: () {
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => ));
      // },
      child: Container(
        width: deviceWidth(context, 1.0),
        // height: 55,
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
            color: colorgreyblack.withOpacity(0.2),
          ),
        ),
        child: ListTile(
          minLeadingWidth: 5,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 32,
                  height: 26,
                  decoration: BoxDecoration(color: HexColor('#FD7235'), borderRadius: BorderRadius.circular(5)),
                  child: Image(
                    image: const AssetImage('assets/icons/wallet.png'),
                    color: colorWhite,
                  )),
            ],
          ),
          title: Text(
            'Wallet Balance',
            style: textstyletitleHeading6(context),
          ),
          subtitle: Text(
            amount != null ? '₹ ${amount.toStringAsFixed(2)}' : '₹ 0.00',
            style: textstyletitleHeading6(context),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ),
  );
}

Widget headingContainerWallet(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Recharge Wallet', style: textstyleHeading1(context)!.copyWith(color: colorblack)),
      sizedboxheight(10.0),
      Text(
        'Choose From The Available Recharge Packs.',
        style: textstylesubtitle1(context),
        overflow: TextOverflow.ellipsis,
      )
    ],
  );
}

Button proceedPayBtn(BuildContext context, openCheckout, amt) {
  var gst = (18 / 100) * amt;

  return Button(
      btnWidth: deviceWidth(context, 1.0),
      btnHeight: 45,
      buttonName: 'PROCEED TO PAY',
      key: const Key('pay'),
      borderRadius: BorderRadius.circular(15.0),
      btnColor: colororangeLight,
      onPressed: () {
        openCheckout('${amt + gst}');
      });
}

Widget rechargePackWidget(context, amount) {
  var gst = (18 / 100) * amount;
  // print(gst);
  return Container(
    width: deviceWidth(context, 1.0),
    constraints: const BoxConstraints(maxHeight: 190),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
        color: colororangeLight.withOpacity(0.2),
      ),
    ),
    child: Column(
      children: [
        Container(
          width: deviceWidth(context, 1.0),
          height: 42,
          decoration: BoxDecoration(
            color: colororangeLight,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Center(
            child: Text(
              'Recharge Pack',
              style: textstyleHeading2(context)!.copyWith(
                color: colorWhite,
                fontSize: 18,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(padding10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Amount',
                      style: textstyleHeading3(context),
                    ),
                    Text(
                      '₹ $amount',
                      style: textstyleHeading3(context),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'GST 18%',
                      style: textstyleHeading3(context),
                    ),
                    Text(
                      '₹ ${gst.toStringAsFixed(2)}',
                      style: textstyleHeading3(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        dividerCustom(1.0, 1.0, 0.0, 0.0),
        Container(
          padding: const EdgeInsets.all(padding10),
          width: deviceWidth(context, 1.0),
          height: 42,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: textstyleHeading3(context),
                ),
                Text(
                  '₹ ${amount + gst}',
                  style: textstyleHeading3(context),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
