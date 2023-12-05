import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/order%20history/OrderHistoryProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

Widget orderhistorydetailwidget(context, title, subtitle) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textstylesubtitle1(context),
          ),
          sizedboxheight(3.0),
          Text(
            subtitle,
            overflow: TextOverflow.ellipsis,
            style: textstylesubtitle1(context)!.copyWith(fontWeight: fontWeight900),
          )
        ],
      ),
    ),
  );
}

Container orderhistorydetailwidgetcontainer(BuildContext context, currentplan) {
  final model = Provider.of<OrderHistoryProvider>(context, listen: false);
  return Container(
    height: 260,
    decoration: BoxDecoration(
      border: borderCustom(),
      borderRadius: borderRadiuscircular(10.0),
    ),
    child: Column(
      children: [
        orderhistorydetailwidget(context, 'Plan Name', currentplan['plan_name'].toString()),
        dividerHorizontal(),
        Expanded(
            child: Row(
          children: [
            orderhistorydetailwidget(context, 'Start Date', currentplan['plan_start'].toString()),
            dividerVertical(),
            orderhistorydetailwidget(context, 'End Date', currentplan['plan_end'].toString()),
          ],
        )),
        dividerHorizontal(),
        orderhistorydetailwidget(context, 'Plan Status', model.myplanstatus ? 'Activeted' : 'Expire'),
        dividerHorizontal(),
        // Expanded(
        //     child: Row(
        //   children: [
        //     orderhistorydetailwidget(context, 'Latitude',  model.currentplan['latitude'].toString()),
        //     dividerVertical(),
        //     orderhistorydetailwidget(context, 'Longitude',  model.currentplan['longitude'].toString()),
        //     dividerVertical(),
        //     orderhistorydetailwidget(context, 'Time Zone', model.currentplan['timezone'].toString()),
        //   ],
        // )),
      ],
    ),
  );
}

Widget panchangBirthdetail(context) {
  return Container(
    height: 550,
    decoration: BoxDecoration(borderRadius: borderRadiuscircular(10.0)),
    child: Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          width: deviceWidth(context, 1.0),
          height: 70,
          decoration: BoxDecoration(
              color: colororangeLight,
              border: borderCustom(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
          child: Text(
            'Panchang at Birth',
            style: textstyletitleHeading6(context)!.copyWith(color: colorWhite),
          ),
        ),
        Positioned(
          top: 55,
          child: Container(
            height: 495,
            width: deviceWidth(context, 0.9),
            // height: double.maxFinite,
            decoration: BoxDecoration(color: colorWhite, border: borderCustom(), borderRadius: borderRadiuscircular(10.0)),
            child: Column(
              children: [
                orderhistorydetailwidget(context, 'Tithi', 'Shukla-Navami'),
                dividerHorizontal(),
                Expanded(
                    child: Row(
                  children: [
                    orderhistorydetailwidget(context, 'Birth Date', '02/10/1995'),
                    dividerVertical(),
                    orderhistorydetailwidget(context, 'Birth Time', '14:00'),
                  ],
                )),
                dividerHorizontal(),
                Expanded(
                    child: Row(
                  children: [
                    orderhistorydetailwidget(context, 'Day', 'Monday'),
                    dividerVertical(),
                    orderhistorydetailwidget(context, 'Nakshatra', 'Purva Shadha'),
                  ],
                )),
                dividerHorizontal(),
                Expanded(
                    child: Row(
                  children: [
                    orderhistorydetailwidget(context, 'Karan', 'Baalav'),
                    dividerVertical(),
                    orderhistorydetailwidget(context, 'Yog', 'Atigand'),
                  ],
                )),
                dividerHorizontal(),
                Expanded(
                    child: Row(
                  children: [
                    orderhistorydetailwidget(context, 'Sunrise', '6:17:21'),
                    dividerVertical(),
                    orderhistorydetailwidget(context, 'Sunset', '18:12:55'),
                  ],
                )),
                dividerHorizontal(),
                Expanded(
                    child: Row(
                  children: [
                    orderhistorydetailwidget(context, 'Amanta', 'Ashwin'),
                    dividerVertical(),
                    orderhistorydetailwidget(context, 'Purnimanta', 'Ashwin'),
                  ],
                )),
                dividerHorizontal(),
                Expanded(
                    child: Row(
                  children: [
                    orderhistorydetailwidget(context, 'Vikram', 'Sardhari'),
                    dividerVertical(),
                    orderhistorydetailwidget(context, 'shak', 'Yuva'),
                  ],
                )),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
