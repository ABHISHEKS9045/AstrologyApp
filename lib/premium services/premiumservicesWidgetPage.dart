import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/generate%20kundli/generatekundliPage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget premiumserviceBox(context) {
  return Container(
    height: deviceheight(context, 0.8),
    padding: EdgeInsets.only(bottom: 20),
    child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.only(bottom: 15),
              width: deviceWidth(context, 1.0),
              height: 200,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: colorsanderchat,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  index.isEven
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            imageColumneven(),
                            textColumn(context),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            textColumn(context),
                            sizedboxwidth(8.0),
                            imageevenodd(),
                          ],
                        )
                ],
              ));
        }),
  );
}

Stack imageevenodd() {
  return Stack(
    children: [
      Container(
        width: 115,
        height: 150,
        child: Image(
          image: AssetImage(
            'assets/icons/elips7down.png',
          ),
          // width: 44,
          // height: 135,
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
        left: 12,
        child: Container(
          width: 114,
          height: 150,
          child: Image(
            image: AssetImage('assets/icons/elips8u.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned(
        top: 20,
        child: Container(
          width: 101,
          height: 105,
          decoration: BoxDecoration(
              border: borderCustom(), borderRadius: BorderRadius.circular(15)),
          child: Image(
            // image: AssetImage('assets/icons/right.png'),
            image: AssetImage('assets/images/user.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],
  );
}

Stack imageColumneven() {
  return Stack(
    children: [
      Container(
        width: 114,
        height: 150,
        child: Image(
          image: AssetImage('assets/icons/elips8.png'),
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
        left: 15,
        bottom: 2,
        child: Container(
          width: 110,
          height: 150,
          child: Image(
            image: AssetImage(
              'assets/icons/elips7.png',
            ),
            width: 44,
            height: 135,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned(
        top: 18,
        left: 18,
        child: Container(
          width: 101,
          height: 105,
          decoration: BoxDecoration(
              //  border: borderCustom(),
              borderRadius: BorderRadius.circular(15)),
          child: Image(
            image: AssetImage('assets/images/user.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],
  );
}

Widget askqutnowbtn(context, title) {
  return Container(
    width: 140,
    height: 35,
    decoration: BoxDecoration(
        color: HexColor('#FF5F5F'),
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [HexColor('#FDCD35'), HexColor('#FD7235')])),
    child: MaterialButton(
      onPressed: () {
       // print('vinay call btn click');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => GenerateKundliPage(showBackButton: true)));
      },
      elevation: 3.0,
      child: Text(
        title,
        style: textstylesubtitle2(context)!.copyWith(
          color: colorWhite,
        ),
      ),
    ),
  );
}

Widget textColumn(context) {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          child: Text('Ask Our Principal Astrologer',
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.left,
              style: textstyletitleHeading6(context)!.copyWith(fontSize: 20)),
        ),
        sizedboxheight(7.0),
        // Container(
        //   width: 150,
        //   child: Text(
        //       'type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing',
        //       overflow: TextOverflow.ellipsis,
        //       maxLines: 3,
        //       textAlign: TextAlign.left,
        //       style: textstylesubtitle2(context)!.copyWith(fontSize: 14)),
        // ),
        sizedboxheight(7.0),
        askqutnowbtn(context, 'Ask Question Now')
      ],
    ),
  );
}
