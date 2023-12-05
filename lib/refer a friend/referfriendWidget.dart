import 'package:astrologyapp/common/commonwidgets/button.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget referfriendHeader(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Share',
        style: textstyleHeading1(context)!.copyWith(color: colorblack),
      ),
      sizedboxheight(10.0),
      Text(
        'Connect Aastro refer to your friends.',
        style: textstyletitleHeading6(context),
        overflow: TextOverflow.ellipsis,
        maxLines: 5,
      ),
    ],
  );
}

List gridicon = [
  'assets/icons/referfbicon.png',
  'assets/icons/gmail1.png',
  'assets/icons/insta.png',
  'assets/icons/twitter.png',
  'assets/icons/whatsapp.png',
  'assets/icons/messenger.png',
];

Widget sharelistView(context) {
  return Container(
    width: MediaQuery.of(context).size.height,
    height: MediaQuery.of(context).size.height * 0.45,
    padding: EdgeInsets.all(5),
    child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            childAspectRatio: 3 / 3,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            child: Container(
              width: 30,
              height: 30,
              child: Image(
                image: AssetImage(gridicon[index]),
                fit: BoxFit.fill,
                color:
                    gridicon[index] == gridicon[3] ? Colors.blueAccent : null,
              ),
            ),
            decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: colorgreyblack.withOpacity(0.2))
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.grey.withOpacity(0.1),
                //       spreadRadius: 2,
                //       blurRadius: 10,
                //       offset: Offset(0, 3),
                //     ),
                //   ],
                ),
          );
        }),
  );
}

Widget shareBtn(BuildContext context, formKey, _shareText) {
  return Button(
    btnWidth: deviceWidth(context, 1.0),
    btnHeight: 55,
    buttonName: 'SHARE',
    key: Key('sharefriend'),
    borderRadius: BorderRadius.circular(7.0),
    btnColor: colororangeLight,
    onPressed: () {
     // print('aman');
      _shareText();
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => ProfilePage()));
      //// print('vinay112 ${gridicon[3]}');
    },
  );
}
