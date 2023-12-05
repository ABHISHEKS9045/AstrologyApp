import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/introduction/introductionModelPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'introductionPagewidget.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/BackGround.png',
            ),
            fit: BoxFit.fill,
          ),
        ),
        width: deviceWidth(context, 1.0),
        height: deviceheight(context, 1.0),
        padding: const EdgeInsets.all(20.0),
        child: Consumer<IntroductionModelPage>(builder: (context, model, _) {
          return Column(
            children: [
              // sizedboxheight(30.0),
              Container(
                margin: EdgeInsets.only(top:
                20),
                  child: skipButton(context, model)),
              // sizedboxheight(30.0),
              customCarouselWidget(model),
              Spacer(),
              Container(
                margin: EdgeInsets.only(bottom: 14),
                  child: customPageIndicator(model)),
              // sizedboxheight(10.0),
              customNextButton(context, model),
              // const Expanded(
              //   child: Text(''),
              // ),
            ],
          );
        }),
      ),
    );
  }
}
