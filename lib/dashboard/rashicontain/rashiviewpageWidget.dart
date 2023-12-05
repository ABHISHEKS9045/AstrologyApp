import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget headingandTextWidget(context, rashiName, rashiContain, rashirashiImageList) {
  return Container(
    width: deviceWidth(context, 1.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: Colors.white,
          elevation: 10,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(rashirashiImageList),
                fit: BoxFit.fill,
              ),
            ),
            width: deviceWidth(context, 1.0),
            height: 250,
          ),
        ),
        sizedboxheight(10.0),
        Text(
          "$rashiName Rashi",
          style: textstyleHeading1(context)!.copyWith(
            color: colorblack,
          ),
        ),
        sizedboxheight(10.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.redAccent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
            color: Colors.redAccent.withOpacity(0.1),
          ),
          padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 4.w),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    'Love',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                rashiContain['personal_life'],
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black12.withOpacity(0.5),
                  fontSize: 16,
                  height: 0.16.h,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.orangeAccent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
            color: Colors.orangeAccent.withOpacity(0.1),
          ),
          padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 4.w),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.shopping_bag,
                    color: Colors.orangeAccent,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    'Career',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                rashiContain['profession'],
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black12.withOpacity(0.5),
                  fontSize: 16,
                  height: 0.16.h,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
            color: Colors.green.withOpacity(0.1),
          ),
          padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 4.w),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.medical_services,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    'Health',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                rashiContain['health'],
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black12.withOpacity(0.5),
                  fontSize: 16,
                  height: 0.16.h,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.yellow,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
            color: Colors.yellow.withOpacity(0.1),
          ),
          padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 4.w),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    'Luck',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                rashiContain['luck'],
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black12.withOpacity(0.5),
                  fontSize: 16,
                  height: 0.16.h,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.pinkAccent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
            color: Colors.purpleAccent.withOpacity(0.1),
          ),
          padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 4.w),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.airplanemode_active,
                    color: Colors.pinkAccent,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    'Travel',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                rashiContain['travel'],
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black12.withOpacity(0.5),
                  fontSize: 16,
                  height: 0.16.h,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.lightBlueAccent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
            color: Colors.lightBlueAccent.withOpacity(0.1),
          ),
          padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 4.w),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.water_drop,
                    color: Colors.lightBlueAccent,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    'Emotions',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                rashiContain['emotions'],
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black12.withOpacity(0.5),
                  fontSize: 16,
                  height: 0.16.h,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget contactInfotWidget(context) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Info',
          style: textstyleHeading1(context)!.copyWith(
            color: colorblack,
          ),
        ),
        sizedboxheight(10.0),
        // Container(
        //   padding: EdgeInsets.all(10.0),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(15.0),
        //     border: borderCustom(),
        //   ),
        //   child: Center(
        //     child: Text(
        //       'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, ',
        //       style: textstylesubtitle1(context),
        //       // overflow: TextOverflow.ellipsis,
        //     ),
        //   ),
        // ),
      ],
    ),
  );
}
