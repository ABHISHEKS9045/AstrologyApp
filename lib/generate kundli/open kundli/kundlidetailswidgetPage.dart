import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget detailuserkundli(context, title, subtitle) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
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

Widget detailuserkundliRowTop(context, title, subtitle, index, isTop) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: index == 0 ? colororangeLight.withOpacity(0.4) : Colors.white,
        borderRadius: isTop ? const BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)) : const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
      ),
      padding: const EdgeInsets.only(right: 10, left: 15),
      width: double.maxFinite,
      child: Row(
        children: [
          SizedBox(
            width: 40.w,
            child: Text(
              title,
              style: textstylesubtitle1(context),
            ),
          ),
          sizedboxheight(3.0),
          Text(
            subtitle,
            overflow: TextOverflow.ellipsis,
            style: textstylesubtitle1(context)!.copyWith(fontWeight: fontWeight900),
          ),
        ],
      ),
    ),
  );
}

Widget detailuserkundliRow(context, title, subtitle, index) {
  return Expanded(
    child: Container(
      color: index == 0 ? colororangeLight.withOpacity(0.4) : Colors.white,
      padding: const EdgeInsets.only(right: 10, left: 15),
      width: double.maxFinite,
      child: Row(
        children: [
          SizedBox(
            width: 40.w,
            child: Text(
              title,
              style: textstylesubtitle1(context),
            ),
          ),
          sizedboxheight(3.0),
          Expanded(
            child: Text(
              subtitle.toString(),
              overflow: TextOverflow.ellipsis,
              style: textstylesubtitle1(context)!.copyWith(fontWeight: fontWeight900),
            ),
          )
        ],
      ),
    ),
  );
}

Widget detailuserkundliImage1(context, kundlilist) {
  return Container(
    child: Image.network(kundlilist['generate_kundli_image'].toString()),
  );
}

/*Widget userBasicDetailsTab(context,kundaliList){
  return Container(
    // height: 80.h,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Basic Details',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
        SizedBox(height: 2.h,),
        userkundlidetailcontainer1(context,kundaliList),
        SizedBox(height: 2.h,),
        Text('Manglik Analysis',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
        SizedBox(height: 2.h,),
        Container(
          padding: EdgeInsets.all(13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.green,width: 2)
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.green),
                  color: Colors.green
                ),
                child: Text('No',style: TextStyle(color: Colors.white,fontSize: 18),),
              ),
              SizedBox(width: 3.w,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(kundaliList['kundli_user_name'].toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                    SizedBox(height: 1.h,),
                    Text('Since mars is in second house and in libra sign person is not manglink.',style: TextStyle(fontSize: 14),)
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 2.h,),
        Text('Panchang Details',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
        SizedBox(height: 2.h,),
        userBasicPanchangDetails(context,kundaliList),
      ],
    ),
  );
}*/
Container userkundlidetailcontainer1(BuildContext context, kundlilist) {
  return Container(
    height: 35.h,
    decoration: BoxDecoration(
      border: borderCustom(),
      borderRadius: borderRadiuscircular(15.0),
    ),
    child: Column(
      children: [
        detailuserkundliRowTop(context, 'Name', kundlilist['kundli_user_name'].toString(), 0, true),
        detailuserkundliRow(context, 'Birth Date', kundlilist['dob'].toString(), 1),
        detailuserkundliRow(context, 'Birth Time', kundlilist['birth_time'].toString(), 0),
        detailuserkundliRow(context, 'Birth Place', kundlilist['birth_place'].toString(), 1),
        detailuserkundliRow(context, 'Latitude', kundlilist['lat'].toString(), 0),
        detailuserkundliRow(context, 'Longitude', kundlilist['long'].toString(), 1),
        detailuserkundliRowTop(context, 'Time Zone', kundlilist['time_zone'].toString(), 0, false),
      ],
    ),
  );
}

Widget userBasicPanchangDetails(BuildContext context, kundlilist) {
  return Container(
    height: 32.h,
    decoration: BoxDecoration(
      border: borderCustom(),
      borderRadius: borderRadiuscircular(15.0),
    ),
    child: Column(
      children: [
        detailuserkundliRowTop(context, 'Tithi', 'Shukla Ekadashi', 0, true),
        detailuserkundliRow(context, 'Karan', 'Vishti', 1),
        detailuserkundliRow(context, 'Yog', 'Sandhya', 0),
        detailuserkundliRow(context, 'Nakshatra', 'Kritika', 1),
        detailuserkundliRow(context, 'Sunrise', "7:14:02 AM", 0),
        detailuserkundliRowTop(context, 'Time Zone', "5:34:55 PM", 1, false),
      ],
    ),
  );
}
/*Container userkundlidetailcontainer1(BuildContext context, kundlilist) {
  return Container(
    height: 260,
    decoration: BoxDecoration(
      border: borderCustom(),
      borderRadius: borderRadiuscircular(10.0),
    ),
    child: Column(
      children: [
        detailuserkundli(
            context, 'Name', kundlilist['kundli_user_name'].toString()),
        dividerHorizontal(),
        Expanded(
            child: Row(
          children: [
            detailuserkundli(
                context, 'Birth Date', kundlilist['dob'].toString()),
            dividerVertical(),
            detailuserkundli(
                context, 'Birth Time', kundlilist['birth_time'].toString()),
          ],
        )),
        dividerHorizontal(),
        detailuserkundli(
            context, 'Birth Place', kundlilist['birth_place'].toString()),
        dividerHorizontal(),
        Expanded(
            child: Row(
          children: [
            detailuserkundli(context, 'Latitude', kundlilist['lat'].toString()),
            dividerVertical(),
            detailuserkundli(
                context, 'Longitude', kundlilist['long'].toString()),
            dividerVertical(),
            detailuserkundli(
                context, 'Time Zone', kundlilist['time_zone'].toString()),
          ],
        )),
      ],
    ),
  );
}*/

Container userBirthDetails(BuildContext context, kundlilist) {
  return Container(
    height: 70.h,
    decoration: BoxDecoration(
      border: borderCustom(),
      borderRadius: borderRadiuscircular(10.0),
    ),
    child: Column(
      children: [
        detailuserkundli(context, 'Tithi', 'Shukla Navami'),
        dividerHorizontal(),
        Expanded(
            child: Row(
          children: [
            detailuserkundli(context, 'Birth Date', 'DOB'),
            dividerVertical(),
            detailuserkundli(context, 'Birth Time', 'Time'),
          ],
        )),
        dividerHorizontal(),
        Expanded(
            child: Row(
          children: [
            detailuserkundli(context, 'Day', 'Monday'),
            dividerVertical(),
            detailuserkundli(context, 'Nakshatra', 'Purva Shabda'),
          ],
        )),
        dividerHorizontal(),
        Expanded(
            child: Row(
          children: [
            detailuserkundli(context, 'Karan', 'Balav'),
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
            detailuserkundli(context, 'Purnimanta', 'Ashnwin'),
          ],
        )),
        dividerHorizontal(),
        Expanded(
            child: Row(
          children: [
            detailuserkundli(context, 'Vikram', 'Sarvadhari'),
            dividerVertical(),
            detailuserkundli(context, 'Shak', 'Yuva'),
          ],
        )),
        dividerHorizontal(),
      ],
    ),
  );
}

Container userAstroDetails(BuildContext context, kundlilist) {
  return Container(
    height: 70.h,
    decoration: BoxDecoration(
      border: borderCustom(),
      borderRadius: borderRadiuscircular(10.0),
    ),
    child: Column(
      children: [
        dividerHorizontal(),
        Expanded(
            child: Row(
          children: [
            detailuserkundli(context, 'Ascedent', 'Sangittarius'),
            dividerVertical(),
            detailuserkundli(context, 'Sign', 'Sangittarius'),
            dividerVertical(),
            detailuserkundli(context, 'Sign Lord', 'Jupiter'),
          ],
        )),
        dividerHorizontal(),
        Expanded(
            child: Row(
          children: [
            detailuserkundli(context, 'Nakshatra', 'Purva'),
            dividerVertical(),
            detailuserkundli(context, 'Nak Lord', 'Venus'),
            dividerVertical(),
            detailuserkundli(context, 'Charan', '4'),
          ],
        )),
        dividerHorizontal(),
        Expanded(
            child: Row(
          children: [
            detailuserkundli(context, 'Karan', 'Baalav'),
            dividerVertical(),
            detailuserkundli(context, 'Yog', 'Atigand'),
            dividerVertical(),
            detailuserkundli(context, 'Varna', 'Kshatriya'),
          ],
        )),
        dividerHorizontal(),
        Expanded(
            child: Row(
          children: [
            detailuserkundli(context, 'Vashya', 'Maanav'),
            dividerVertical(),
            detailuserkundli(context, 'Yoni', 'Vaanar'),
            dividerVertical(),
            detailuserkundli(context, 'Gan', 'Manushya'),
          ],
        )),
        dividerHorizontal(),
        Expanded(
            child: Row(
          children: [
            detailuserkundli(context, 'Nadi', 'Madhya'),
            dividerVertical(),
            detailuserkundli(context, 'Yunja', 'Parbhaag'),
            dividerVertical(),
            detailuserkundli(context, 'Tatva', 'Fire'),
          ],
        )),
        dividerHorizontal(),
        Expanded(
            child: Row(
          children: [
            detailuserkundli(context, 'Name-Alpha', 'Dhha'),
            dividerVertical(),
            detailuserkundli(context, 'Paya', 'Copper'),
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          width: deviceWidth(context, 1.0),
          height: 70,
          decoration: BoxDecoration(
              color: colororangeLight,
              border: borderCustom(),
              borderRadius: const BorderRadius.only(
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
