import 'package:astrologyapp/common/commonwidgets/button.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/introduction/introductionModelPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget skipButton(BuildContext context, IntroductionModelPage model) {
  return Container(
    alignment: Alignment.topRight,
    child: TextButton(
      onPressed: () {
        model.updateStatusForIntro();
      },
      child: Text(
        'Skip',
        style: textstyletitleHeading6(context)!.copyWith(
          color: colororangeLight,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

CarouselSlider customCarouselWidget(IntroductionModelPage model) {
  return CarouselSlider.builder(
    itemCount: 3,
    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 28.h,
            width: 28.h,
            child: Image(
              image: AssetImage(
                model.images[model.activeIndex],
              ),
            ),
          ),
          Text(
            model.titleList[model.activeIndex],
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            model.messageList[model.activeIndex],
            style: textstylesubtitle1(context)?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          sizedboxheight(20.0),
        ],
      );
    },
    carouselController: model.buttonCarouselController,
    options: CarouselOptions(
      height: 410,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 700),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      onPageChanged: (int index, CarouselPageChangedReason reason) {
        model.updateIndex(index);
      },
      scrollDirection: Axis.horizontal,
      viewportFraction: 0.95,
      aspectRatio: 2.0,
      initialPage: 0,
    ),
  );
}

Widget customPageIndicator(IntroductionModelPage model) {
  return AnimatedSmoothIndicator(
    activeIndex: model.activeIndex,
    count: 3,
    effect: ScrollingDotsEffect(
      activeStrokeWidth: 2.5,
      activeDotScale: 1.5,
      maxVisibleDots: 5,
      radius: 10,
      spacing: 15,
      dotHeight: 10,
      dotWidth: 10,
      activeDotColor: colororangeLight,
      dotColor: Colors.black12,
    ),
  );
}

Button customNextButton(BuildContext context, IntroductionModelPage model) {
  return Button(
    btnWidth: MediaQuery.of(context).size.width / 2,
    btnHeight: 45,
    buttonName: 'NEXT',
    key: const Key('login_submit'),
    borderRadius: BorderRadius.circular(15.0),
    btnColor: colororangeLight,
    onPressed: () {
      model.buttonCarouselController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.linear);
      if (model.activeIndex == 2) {
        model.updateStatusForIntro();
      }
    },
  );
}
