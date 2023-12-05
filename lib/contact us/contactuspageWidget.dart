import 'package:astrologyapp/about/privecy%20policy/privecyPolicyPage.dart';
import 'package:astrologyapp/common/commonwidgets/button.dart';
import 'package:astrologyapp/common/styles/const.dart';

import 'package:flutter/material.dart';

Widget discribeProbfield(context) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Describe your problem',
          style: Theme.of(context).textTheme.headline1,
        ),
        sizedboxheight(5.0),
        Container(
             decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadius.circular(8),
      border: Border.all(color: colorgreyblack.withOpacity(0.1)),
        boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: TextField(
              style: Theme.of(context).textTheme.headline6,
              decoration: InputDecoration(
                border: InputBorder.none,     
                contentPadding: const EdgeInsets.all(15.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 5,
            )),
      ],
    ),
  );
}

Widget addscreenshotfield(context) {
  return InkWell(
    onTap: () {},
    child: Container(
      width: 100,
      height: 85,
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(8),
      border: Border.all(color: colorgreyblack.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
          child: Container(
              width: 20,
              height: 20,
              child: Image(image: AssetImage('assets/images/plusicon.png')))),
    ),
  );
}

Widget submitBtn(
  BuildContext context,
) {
  return Button(
    btnWidth: deviceWidth(context, 1.0),
    btnHeight: 55,
    buttonName: 'SUBMIT',
    key: Key('submitbtn'),
    // borderRadius: BorderRadius.circular(7.0),
    // btnColor: ,
    // color: colorRed,
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PrivecyPolicyPage()));
    },
  );
}
