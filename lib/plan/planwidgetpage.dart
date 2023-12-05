import 'package:astrologyapp/common/apiErroralertdiloge.dart';
import 'package:astrologyapp/common/commonwidgets/button.dart';
import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/dashboard/dashboardModelPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

// Widget unlockpremiumwidget(context) {
//   return Container(
//     // color: colorsanderchat,
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           width: 88,
//           height: 88,
//           child: CircleAvatar(
//             backgroundColor: colororangeLight.withOpacity(0.1),
//             child: Container(width: 50, height: 50, child: Image(image: AssetImage('assets/icons/crown.png'))),
//           ),
//         ),
//         sizedboxheight(20.0),
//         Text(
//           'Unlock Premium',
//           style: textstyletitleHeading6(context)!.copyWith(fontWeight: fontWeight700),
//         ),
//         sizedboxheight(5.0),
//         Text(
//           'No Commitment. Cancel Anytime',
//           style: textstylesubtitle1(context),
//         ),
//       ],
//     ),
//   );
// }

List planbanifitlist = [
  'Advanced Palmistry Readings',
  'Daily Horoscope Based On The',
  'Detailed Compatibility Report',
  'By World-Famous Astrologers'
];

Widget planbanifitwidget() {
  return Container(
      height: 140,
      decoration:
          BoxDecoration(color: colorsanderchat, borderRadius: BorderRadius.circular(15), border: borderCustom()),
      child: Center(
        child: ListView.builder(
            itemCount: planbanifitlist.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 5, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    sizedboxwidth(20.0),
                    Icon(
                      Icons.check_sharp,
                      size: 18,
                      color: colororangeLight,
                    ),
                    sizedboxwidth(5.0),
                    Text(
                      planbanifitlist[index],
                      style: textstyletitleHeading6(context)!.copyWith(fontWeight: fontWeight600),
                    ),
                  ],
                ),
              );
            }),
      ));
}

Widget mostpopularwidget(context, model) {
  return Container(
    height: 114,
    child: Stack(
      children: [
        Column(
          children: [
            Spacer(),
            Material(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              color: model.color1 ? colororangeLight.withOpacity(0.6) : HexColor('#FFEFEF'),
              // color: colororangeLight,
              child: InkWell(
                onTap: () {
                  var dbcontroller = Provider.of<DashboardModelPage>(context, listen: false);
                  if (dbcontroller.isGeustLoggedIn) {
                    geustloginfirst(context);
                  } else {
                    model.mostpopularplan(context);
                   // print('planamount ${model.planamount}');
                   // print('selectplanname ${model.selectplanname}');
                   // print('planEnddate ${model.planEnddate}');
                  }
                },
                child: Container(
                  width: deviceWidth(context, 1.0),
                  height: 102,
                  padding: EdgeInsets.only(top: 17, left: 10, right: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            model.planListdata['plan_free_name'].toString(),
                            style: textstyletitleHeading6(context)!.copyWith(fontWeight: fontWeight700),
                          ),
                          sizedboxwidth(10.0),
                          // Text(
                          //   model.planListdata['plan_name'].toString(),
                          //   style: textstyletitleHeading6(context)!.copyWith(fontWeight: fontWeight700),
                          // ),
                        ],
                      ),
                      sizedboxheight(5.0),
                      Text(
                        model.planListdata['plan_free_description'].toString(),
                        style: textstylesubtitle1(context),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
            left: deviceWidth(context, 0.28),
            child: Container(
              width: 130,
              height: 28,
              decoration: BoxDecoration(
                  color: colorWhite,
                  border: Border.all(color: colororangeLight.withOpacity(0.8)),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text(
                'MOST POPULAR',
                style: textstylesubtitle2(context)!.copyWith(color: colororangeLight),
              )),
            ))
      ],
    ),
  );
}

Widget monthlyPlanwidget(context, model) {
  return Material(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    color: model.color2 ? colororangeLight.withOpacity(0.6) : HexColor('#F3F1FF'),
    child: InkWell(
      onTap: () {
        var dbcontroller = Provider.of<DashboardModelPage>(context, listen: false);
        if (dbcontroller.isGeustLoggedIn) {
          geustloginfirst(context);
        } else {
          model.monthlyplan(context);
         // print('planamount ${model.planamount}');
         // print('selectplanname ${model.selectplanname}');
         // print('planEnddate ${model.planEnddate}');
        }
      },
      child: Container(
        width: deviceWidth(context, 1.0),
        height: 68,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.planListdata['plan_monthly'].toString(),
                  style: textstyletitleHeading6(context)!.copyWith(fontWeight: fontWeight700),
                ),
                sizedboxwidth(5.0),
                Text(
                  model.planListdata['plan_monthly_amount'].toString(),
                  style: textstyletitleHeading6(context)!.copyWith(fontWeight: fontWeight700),
                ),
                Text(
                  ' Pay',
                  style: textstyletitleHeading6(context)!.copyWith(fontWeight: fontWeight700),
                ),
              ],
            ),
            sizedboxheight(5.0),
            Text(
              model.planListdata['month_descrption'].toString(),
              style: textstylesubtitle1(context),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            )
          ],
        ),
      ),
    ),
  );
}

Widget yearlyPlanwidget(context, model) {
  return Material(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    color: model.color3 ? colororangeLight.withOpacity(0.6) : HexColor('#FFF5D7'),
    child: InkWell(
      onTap: () {
        var dbcontroller = Provider.of<DashboardModelPage>(context, listen: false);
        if (dbcontroller.isGeustLoggedIn) {
          geustloginfirst(context);
        } else {
          model.yearlyplan(context);
         // print('planamount ${model.planamount}');
         // print('selectplanname ${model.selectplanname}');
         // print('planEnddate ${model.planEnddate}');
        }
      },
      child: Container(
        width: deviceWidth(context, 1.0),
        height: 68,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.planListdata['plan_yearly'].toString(),
                  style: textstyletitleHeading6(context)!.copyWith(fontWeight: fontWeight700),
                ),
                sizedboxwidth(5.0),
                Text(
                  model.planListdata['plan_yearly_amt'].toString(),
                  style: textstyletitleHeading6(context)!.copyWith(fontWeight: fontWeight700),
                ),
                Text(
                  ' Pay',
                  style: textstyletitleHeading6(context)!.copyWith(fontWeight: fontWeight700),
                ),
              ],
            ),
            sizedboxheight(5.0),
            Text(
              model.planListdata['yearly_descrption'].toString(),
              style: textstylesubtitle1(context),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    ),
  );
}

Button startplanbtn(BuildContext context, model) {
  return Button(
      btnWidth: deviceWidth(context, 1.0),
      btnHeight: 55,
      buttonName: 'START',
      key: Key('pay'),
      borderRadius: BorderRadius.circular(15.0),
      btnColor: colororangeLight,
      onPressed: () async {
        var dbcontroller = Provider.of<DashboardModelPage>(context, listen: false);
        if (dbcontroller.isGeustLoggedIn) {
          geustloginfirst(context);
        } else {
          await model.getLastplanexpiredate(context);
          if (model.lastplanActivated == true) {
            Fluttertoast.showToast(msg: 'Your Last Plan Allready Activated');
           // print('lastplanActivated ${model.lastplanActivated}');
          } else if (model.color1 == false && model.color2 == false && model.color3 == false)
            apiErrorAlertdialog(context, 'Please Select Plan ');
          else if (model.planamount != '0') {
            model.openCheckout(context, model.planamount);
          } else {
            model.addplan('Freeplan');
          }

         // print('select anount ${model.planamount}');
        }
      });
}
