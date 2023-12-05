import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/cupertino.dart';

Widget detailuserkundli(context, title, subtitle) {
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
            style: textstylesubtitle1(context)!
                .copyWith(fontWeight: fontWeight900),
          )
        ],
      ),
    ),
  );
}

Widget kundaliTableRow(context, title, subtitle) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: colororangeLight,
      child: Row(
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
            style: textstylesubtitle1(context)!
                .copyWith(fontWeight: fontWeight900),
          )
        ],
      ),
    ),
  );
}

Widget detailuserkundliImage(context, model) {
  return Container(
    child: Image.network(model.kundliUrl.toString()),
  );
}

Container userkundlidetailcontainer(BuildContext context, model) {
  return Container(
    height: 260,
    decoration: BoxDecoration(
      border: borderCustom(),
      borderRadius: borderRadiuscircular(10.0),
    ),
    child: Column(
      children: [
        detailuserkundli(
            context, 'Name', model.kundligenratedetailslist['name'].toString()),
        dividerHorizontal(),
        Expanded(
            child: Row(
          children: [
            kundaliTableRow(context, 'Birth Date',
                model.kundligenratedetailslist['dob'].toString()),
            detailuserkundli(context, 'Birth Date',
                model.kundligenratedetailslist['dob'].toString()),
            dividerVertical(),
            detailuserkundli(context, 'Birth Time',
                model.kundligenratedetailslist['birth_time'].toString()),
          ],
        )),
        dividerHorizontal(),
        detailuserkundli(context, 'Birth Place',
            model.kundligenratedetailslist['birth_place'].toString()),
        dividerHorizontal(),
        Expanded(
            child: Row(
          children: [
            detailuserkundli(context, 'Latitude',
                model.kundligenratedetailslist['latitude'].toString()),
            dividerVertical(),
            detailuserkundli(context, 'Longitude',
                model.kundligenratedetailslist['longitude'].toString()),
            dividerVertical(),
            detailuserkundli(context, 'Time Zone',
                model.kundligenratedetailslist['timezone'].toString()),
          ],
        )),
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
            decoration: BoxDecoration(
                color: colorWhite,
                border: borderCustom(),
                borderRadius: borderRadiuscircular(10.0)),
            child: Column(
              children: [
                detailuserkundli(context, 'Tithi', 'Shukla-Navami'),
                dividerHorizontal(),
                Expanded(
                    child: Row(
                  children: [
                    detailuserkundli(context, 'Birth Date', '02/10/1995'),
                    dividerVertical(),
                    detailuserkundli(context, 'Birth Time', '14:00'),
                  ],
                )),
                dividerHorizontal(),
                Expanded(
                    child: Row(
                  children: [
                    detailuserkundli(context, 'Day', 'Monday'),
                    dividerVertical(),
                    detailuserkundli(context, 'Nakshatra', 'Purva Shadha'),
                  ],
                )),
                dividerHorizontal(),
                Expanded(
                    child: Row(
                  children: [
                    detailuserkundli(context, 'Karan', 'Baalav'),
                    dividerVertical(),
                    detailuserkundli(context, 'Yog', 'Atigand'),
                  ],
                )),
                dividerHorizontal(),
                Expanded(
                    child: Row(
                  children: [
                    detailuserkundli(context, 'Sunrise', '6:17:21'),
                    dividerVertical(),
                    detailuserkundli(context, 'Sunset', '18:12:55'),
                  ],
                )),
                dividerHorizontal(),
                Expanded(
                    child: Row(
                  children: [
                    detailuserkundli(context, 'Amanta', 'Ashwin'),
                    dividerVertical(),
                    detailuserkundli(context, 'Purnimanta', 'Ashwin'),
                  ],
                )),
                dividerHorizontal(),
                Expanded(
                    child: Row(
                  children: [
                    detailuserkundli(context, 'Vikram', 'Sardhari'),
                    dividerVertical(),
                    detailuserkundli(context, 'shak', 'Yuva'),
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
