import 'dart:math';

import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/formtextfield/myTextField.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/dashboard/dailyHoroscopePage.dart';
import 'package:astrologyapp/dashboard/rashicontain/rashiviewpage.dart';
import 'package:astrologyapp/dashboard/viewAllAstrologes.dart';
import 'package:astrologyapp/generate%20kundli/open%20kundli/horoscopeMatching.dart';
import 'package:astrologyapp/profile%20jyotish/profileJyotishPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../freeconsultation/FreeConsultation.dart';
import '../generate kundli/generatekundliPage.dart';
import '../order history/OrderHistoryPage.dart';
import 'dashboardModelPage.dart';

const String TAG = "Dashboard Widget";

CarouselSlider dashboardSlider(BuildContext context, DashboardModelPage model) {
  // debugPrint("$TAG banner images =====> ${model.bannerDataList}");
  return CarouselSlider.builder(
    itemCount: model.bannerDataList.length,
    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
      // final
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: deviceWidth(context, 1.0),
            height: 150,
            child: ClipRRect(
              borderRadius: borderRadiuscircular(7.0),
              child: CachedNetworkImage(
                imageUrl: model.bannerDataList[itemIndex]['img_url'],
                placeholder: (context, url) => const Image(
                  image: AssetImage(
                    'assets/images/1.jpg',
                  ),
                  fit: BoxFit.fill,
                ),
                errorWidget: (context, url, error) => const Image(
                  image: AssetImage(
                    'assets/images/1.jpg',
                  ),
                  fit: BoxFit.fill,
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      );
    },
    carouselController: model.buttonCarouselController,
    options: CarouselOptions(
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      onPageChanged: (index, reason) {
        model.valueset(index);
      },
      scrollDirection: Axis.horizontal,
      viewportFraction: 0.8,
      aspectRatio: 16 / 9,
      initialPage: 0,
    ),
  );
}

Widget customPageIndicator(DashboardModelPage model) {
  return AnimatedSmoothIndicator(
    activeIndex: model.activeindex,
    count: model.bannerDataList.length,
    effect: ScrollingDotsEffect(
      activeStrokeWidth: 1.6,
      activeDotScale: 1.4,
      maxVisibleDots: 5,
      radius: 8,
      spacing: 8,
      dotHeight: 10,
      dotWidth: 10,
      activeDotColor: colororangeLight,
      dotColor: Colors.black12,
    ),
  );
}

Widget cardTitleWidget(context, String leadingText, String trailingText, DashboardModelPage model) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(
        leadingText,
        style: textstyletitleHeading6(context)!.copyWith(fontSize: 19),
      ),
      if (leadingText == 'Active Astrologers')
        InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              trailingText,
              style: textstylesubtitle2(context)!.copyWith(
                color: colororangeLight,
                fontSize: 18,
              ),
            ),
          ),
          onTap: () async {
            if (leadingText == 'Active Astrologers') {
              if(model.isGeustLoggedIn) {
                await geustloginfirst(context);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ViewAllAstrologers(
                          isCall: false,
                        ),
                  ),
                );
              }
            }
          },
        ),
    ],
  );
}

Widget titleHeaderRow(BuildContext context, DashboardModelPage model, var amount, bool isGuestLoggedIn) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
            ),
            sizedboxheight(5.0),
            Text(
              model.userdataMap['name'] != null ? model.userdataMap['name'].toString() : "Guest",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
            )
          ],
        ),
        InkWell(
          onTap: () {
            if (isGuestLoggedIn == false) {
              Get.to(() => const OrderHistoryPage());
            }
          },
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colorWhite),
            child: Center(
              child: amount != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                      child: Text('₹ ${double.parse(amount.toString()).toStringAsFixed(2)}'),
                    )
                  : const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                      child: Text('₹ 0.00'),
                    ),
            ),
          ),
        )
      ],
    ),
  );
}

List rashinameList = ['Mesh', 'Vrashub', 'Mithun', 'Kark', 'Singh', 'Kanya', 'Tula', 'Vrushichik', 'Dhanu', 'Makar', 'Kumbha', 'Meen'];

List ascendantList = ['aries', 'taurus', 'gemini', 'cancer', 'leo', 'virgo', 'libra', 'scorpius', 'sagittarius', 'capricorn', 'aquarius', 'pisces'];

List rashiContainList = [
  'Mesh (Aries)Rashi is a very important sign that carries a great weight on its shoulders. According to the ancient Vedic texts, Mesh Rashi is the sign of God Brahma who is the creator of the Universe. The ruling planet of Aries is Mangal Graha (Mars). The planet Mars is a factor of might and enthusiasm in life. It is put in the category of the fixed zodiac and its quality is fire-dominant.',
  "Taurus, Vrish, or Vrishabha Rashi is the 2nd Sign of the Hindu Zodiac. It is an Earth Sign, which shows the hard-working, rock-solid, stable and practical nature of Taurus or Vrishabha Rashi. Ruled by Venus, they, however, are also driven tremendously to materialistic pleasures.  Most of Taurus born are connoisseurs of good food and a good life. Paradoxically, though, they are fixed in their approach; they disregard change. They are loyal and attached to their loved ones, jobs, employers, project, friends and almost everyone and everything. Many believe them to be the most dependable Sign in the whole Hindu Zodiac, simply because they hate the idea of ‘change’. This attribute makes Vrishabha quite headstrong.",
  "Gemini or Mithuna is the third sign of the zodiac. The sign is ruled by mercury. This zodiac sign is represented by the symbol of 'The twins’. Gemini zodiac natives are known to be the versatile, quick-witted, energetic, attractive and youthful. Gemini zodiac sign natives has dual nature. In the favorable situations, they are quite creative, energetic and enthusiastic while in the unfavorable conditions, they become restless and irritating. Their dual nature is applicable to their decision-making as well. Many times, Gemini zodiac sign natives take any decision and in a very small span of time, they can switch to the any other decision even just opposite decision as well. Gemini zodiac or mithun rashi natives can not stick to their decisions and opinions for a long period",
  "Kark Rashi (Cancer) stands 4th in the Hindu Zodiac. Lovers of home and family, they are sensitive, emotional, harmonious, dedicated yet fixed. Most Cancer-born value their home, loved ones, and comforts more than anything else. Their most noble goal lies in sheltering and providing every comfort to their loved ones. Soothing and caring, Karkatas are also quick in offering help to others. On their part, they try and avoid/ duck conflicts, as much as possible. This very trait makes them quiet and controlled about their own feelings.",
  "Singh Rashi is the fifth Moon sign of the zodiac. Singh Rashi in English is called Leo Moon Sign. If the Moon was transiting through the Leo zodiac sign at the time of your birth, then your Moon sign is said to be Leo. According to Vedic Astrology, the Lord of Leo Moon sign is the Sun, the planet of life, energy, power and creativity. It speaks of the warm, spontaneous and confident personality that Simha Rashi people exhibit. Leo Moon sign is associated with the Fire element which bestows fiery and passionate feelings. The masculine energy of the Leo Moon sign makes Simha Rashi natives extroverted and authoritative. The Leo Moon sign exhibits fixed quality. It rules the fifth house of the astrology chart which represents pleasure, artistic talents, entertainment, recreation, romance and social inclinations. ",
  "Kanya Rashi, much like its symbol and name is feminine, lady-like, graceful, and duty-bound. The 6th Sign of the Hindu Zodiac, Kanya Rashi is also a meticulous perfectionist. Most Kanya Rashi born natives are sincere and caring to the fault – towards their families, friends, and loved ones. People born under Kanya Rashi are open to helping others, especially the ones who are close to others. Expert communicators, they also are often good at giving advice, and thus, you may find them being the ‘proverbial agony aunt’ of their circle. They also make good parents and are pretty protective of their mate, family, and loved ones. They are said to be the fitness-conscientious Sign of the Zodiac – so dedicated in their pursuit of fitness, health and well being of their own selves as well as others’.",
  "Tula Rashi is the fifth Moon sign of the zodiac. Tula Rashi in English is called Libra Moon Sign. If the Moon was transiting through the Libra Zodiac sign at the time of your birth, then your Moon sign is said to be Libra. According to Vedic Astrology, the Lord of Libra Moon sign is Venus, the planet of love, beauty and romance. It is associated with the Air element that governs the communication, exchange of ideas and protocols. Tula Rashi relates to the cardinal sign that highlights the need to act and restore the balance. It exhibits the masculine energy that offers Libra Moon sign men and women desire to be independent. The energy emphasizes the need to be with people to feel better and content. Tula Rashi rules the sixth house of the astrology chart which governs relationships, marriage, partnerships, commitment, sexual fantasies, passion, possessiveness, law, treaties, divorce, conflicts etc.",
  "Vrishchik Rashi is the eighth Moon sign of the zodiac. Vrischika Rashi in English is called Scorpio Moon Sign. If the Moon was transiting through the Scorpio Zodiac sign at the time of your birth, then your Moon sign will be Scorpio. According to Vedic Astrology, the Lord of Scorpio Moon sign is Mars, the planet of passion, aggression and high energy. It is associated with the Water element which makes this sign an ultra-sensitive Moon sign. It also signifies the magical, imaginative, and psychological attributes of the native. Vrischika Rashi relates to the fixed sign that highlights self-reliance, enthusiasm and stubbornness. It exhibits the feminine energy that offers Scorpio Moon sign men and women desire to be intuitive, emotional and receptive. Vrischika Rashi rules the eighth house of the astrology chart which governs transformation, intimacy, secrets, obstacles, longevity, death and unexpected illness etc. ",
  "As planet Jupiter rules the Dhanu Rashi, it signifies wealth, motivation, intelligence and good luck. People born in Dhanus Rasi will be interested in mysticism and philosophy. They give importance to the rank and riches of people. Their capabilities are very different from person to person and span from scholarship to plagiarism. They are known for their truthful nature and never hesitate to tell it, however hurtful it might be. They are independent and go-getters even though they are soft-spoken and modest.",
  "Makara Rashi, the upward climbing, always forward moving Mountain Goat, represents the 10th Sign of the Hindu Zodiac. Committed to responsibilities, Makar Rashi – Capricorn represents the work side of life.Often calm, to the degree of appearing slightly cold, meticulous, and dogged in their persistence for quality and productivity, Capricorns are often a notch above their counterparts.",
  "Aquarius (Kumbha, Kumbh Rashi) is the 11th Sign of the Zodiac. Kumbh Rashi – A distinctive symbol of all, reflects the true sense of humanity. According to Vedic Astrology, Aquarius is known as the Sign of discoverers, inventors, adventurers, and visionaries. An Aquarius-born individual is modern, independent, and freedom-loving. Good-humored and cheerful by nature, they tend to have plenty of social charm.",
  "Meena Rashi Pisces) is the 12th and the last Sign of the Hindu Zodiac. Pisces Rashi is known that they somehow take up different attributes of all the other 11 Signs. Pisces is a water sign and has Sattva guna. The lord of Pisces Rashi is Jupiter. The dreamy and romantic Pisces (Meen Rashi) is known for its charming creative side, which, to some, is like free flowing poetry, while to others is akin to a fresh floral blossom. Many find generous and compassionate Meena Rashi people to be selfless, while others may feel that they are a smidgen rigid or fixed."
];
List rashiImageList = [
  'assets/icons/meshimage.png',
  'assets/icons/vrashabRashi.png',
  'assets/icons/mithun.png',
  'assets/icons/kark.png',
  'assets/icons/singh.png',
  'assets/icons/kanya.png',
  'assets/icons/tula.png',
  'assets/icons/vrashichik.png',
  'assets/icons/dhanu.png',
  'assets/icons/makar.png',
  'assets/icons/kumbh.png',
  'assets/icons/meen.png'
];
List rashirashiImageList = [
  'assets/icons/meshimage.png',
  'assets/icons/vrashabRashi.png',
  'assets/icons/mithun.png',
  'assets/icons/kark.png',
  'assets/icons/singh.png',
  'assets/icons/kanya.png',
  'assets/icons/tula.png',
  'assets/icons/vrashichik.png',
  'assets/icons/dhanu.png',
  'assets/icons/makar.png',
  'assets/icons/kumbh.png',
  'assets/icons/meen.png'
];

Widget cartlisthorizontal() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5),
    height: 110,
    child: ListView.builder(
      itemCount: rashinameList.length,
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Get.to(
              () => RashiDetailsPage(
                rashiImage: rashirashiImageList[index],
                rashiName: rashinameList[index],
                ascendantName: ascendantList[index],
              ),
            );
          },
          child: Container(
            height: 70,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: colorWhite,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 1.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(3, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Image(
                    image: AssetImage(rashiImageList[index]),
                    height: 5.h,
                    width: 5.h,
                    fit: BoxFit.cover,
                  ),
                ),
                sizedboxheight(5.0),
                Text(
                  rashinameList[index],
                  overflow: TextOverflow.ellipsis,
                  style: textstylesubtitle1(context),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget cartListVertical(DashboardModelPage model, amount) {
  return ListView.builder(
    itemCount: model.astrologerListdb.length,
    scrollDirection: Axis.horizontal,
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return InkWell(
        onTap: () async {
          debugPrint("$TAG astrologerListdb selected astro data ========> ${model.astrologerListdb[index]}");
          if (model.isGeustLoggedIn) {
            await geustloginfirst(context);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProfileJyotishPage(
                      astrolist: model.astrologerListdb[index],
                      isFree: false,
                      freeTime: 0,
                    ),
              ),
            );
          }
        },
        child: Container(
          width: 100,
          margin: const EdgeInsets.only(left: 7),
          decoration: BoxDecoration(
            color: colorWhite,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.withOpacity(0.4)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(40),
                      ),
                      border: Border.all(
                        width: 1,
                        color: Colors.green,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: borderRadiuscircular(45.0),
                      child: model.astrologerListdb[index]['profile_image'] != null
                          ? CachedNetworkImage(
                              imageUrl: "$imageURL${model.astrologerListdb[index]['profile_image']}",
                              placeholder: (context, url) => const Image(
                                image: AssetImage('assets/images/user.png'),
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => const Image(
                                image: AssetImage('assets/images/user.png'),
                                fit: BoxFit.cover,
                              ),
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/user.png',
                              fit: BoxFit.contain,
                            ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7.0),
              model.astrologerListdb[index]['name'].toString() == 'null'
                  ? Container()
                  : Text(
                      model.astrologerListdb[index]['name'].toString(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
              sizedboxheight(7.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (model.astrologerListdb[index]['user_status'].toString() == "Online")
                    Container(
                      padding: const EdgeInsets.only(left: 3, right: 3, top: 1, bottom: 1),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(color: Colors.green, width: 1),
                        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                      ),
                      child: const Text(
                        "Online",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  const SizedBox(width: 7.0),
                  Text(
                    '₹${model.astrologerListdb[index]['per_minute']}/min',
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              sizedboxheight(7.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(model.astrologerListdb[index]['call_active'] == "1")
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: HexColor('#eeeeee'), width: 1),
                    ),
                    child: Icon(
                      Icons.call,
                      color: colororangeLight,
                      size: 14,
                    ),
                  ),
                  if(model.astrologerListdb[index]['chat_active'] == "1")
                  const SizedBox(width: 10),
                  if(model.astrologerListdb[index]['chat_active'] == "1")
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: HexColor('#eeeeee'), width: 1),
                    ),
                    child: Icon(
                      Icons.chat_outlined,
                      color: colororangeLight,
                      size: 14,
                    ),
                  ),
                ],
              ),
              sizedboxheight(4.0),
            ],
          ),
        ),
      );
    },
  );
}

Widget searchbar() {
  return AllInputDesign(
    key: const Key("Search"),
    fillColor: colorWhite,
    hintText: 'Search',
    prefixIcon: Icon(
      Icons.search_rounded,
      color: colororangeLight,
    ),
    focusedBorderColor: colorblack.withOpacity(0.1),
    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
    keyBoardType: TextInputType.text,
    validatorFieldValue: 'Phone',
  );
}

Widget features(context, bool isGuestLoggedIn, String? userType) {
  return Container(
    width: deviceWidth(context, 1.0),
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DailyHoroscopePage()));
            },
            child: categoryBox(
              'assets/icons/dailyhoro.png',
              'Daily\nHoroscope',
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => GenerateKundliPage(showBackButton: true)));
            },
            child: categoryBox(
              'assets/icons/Freekundli.png',
              'Free\nKundli',
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HoroscopeMatchingPage()));
            },
            child: categoryBox(
              'assets/icons/horoscopemaching.png',
              ' Horoscope\nMatching',
            ),
          ),
          InkWell(
            onTap: () {
              if (!isGuestLoggedIn && userType == "1") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FreeConsultationPage(
                            isCall: true,
                          )),
                );
              }
            },
            child: categoryBox(
              'assets/icons/freeconsultation.png',
              'Free\nConsultation',
            ),
          ),
        ],
      ),
    ),
  );
}

Widget categoryBox(String image, String text) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colororangeLight, width: 1),
        ),
        width: 45,
        height: 45,
        child: Image.asset(image, color: colororangeLight),
      ),
      sizedboxheight(8.0),
      Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: const TextStyle(fontSize: 13, color: Colors.black),
      ),
    ],
  );
}

// Widget liveEvents() {
//   return Container(
//     padding: const EdgeInsets.symmetric(vertical: 5),
//     height: 120,
//     child: ListView.builder(
//       itemCount: 8,
//       scrollDirection: Axis.horizontal,
//       physics: const AlwaysScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemBuilder: (context, index) {
//         return Container(
//           // width: 80,
//           height: 120,
//           margin: const EdgeInsets.symmetric(horizontal: 10),
//           decoration: BoxDecoration(
//             color: colorcrema,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const CircleAvatar(
//                 radius: 35,
//                 backgroundImage: AssetImage('assets/caller.png'),
//               ),
//               sizedboxheight(5.0),
//               Text(
//                 'Darlene',
//                 overflow: TextOverflow.ellipsis,
//                 style: textstylesubtitle1(context),
//               ),
//               sizedboxheight(5.0),
//               Image.asset('assets/livebut.png')
//             ],
//           ),
//         );
//       },
//     ),
//   );
// }

Widget horoscopeList() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5),
    height: 100,
    child: ListView.builder(
      itemCount: 8,
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(color: colorcrema, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.2),
                    image: const DecorationImage(image: AssetImage('assets/caller.png')),
                  ),
                ),
                sizedboxheight(10.0),
                Text(
                  'Darlene',
                  overflow: TextOverflow.ellipsis,
                  style: textstylesubtitle1(context),
                ),
                sizedboxheight(10.0),
                Text(
                  'Vedic',
                  style: textstylesubtitle2(context),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget behindScensList(_launchURL) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5),
    height: 100,
    child: ListView.builder(
      itemCount: 8,
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            _launchURL();
          },
          child: Container(
            // width: 80,
            height: 100,
            width: 200,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(color: colorcrema, borderRadius: BorderRadius.circular(10)),
            child: Stack(
              children: [
                Image.asset(
                  'assets/caller.png',
                  fit: BoxFit.fill,
                ),
                Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Image.asset('assets/icons/youtub.png'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

// Widget planecard(context) {
//   return InkWell(
//     onTap: () {
//       Navigator.push(context, MaterialPageRoute(builder: (context) => const PlanPage()));
//     },
//     child: Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       child: Container(
//         width: deviceWidth(context, 0.9),
//         decoration: BoxDecoration(color: colorcrema, borderRadius: BorderRadius.circular(15)),
//         child: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text.rich(
//                 TextSpan(
//                   children: [
//                     TextSpan(
//                       text: 'Connect Aastrotalk Gold at\t\t\t',
//                       style: textstyletitleHeading6(context),
//                     ),
//                     TextSpan(
//                       text: 'Rs-999 Rs 5/-',
//                       style: textstyleHeading3(context)!.copyWith(color: colororangeLight),
//                     ),
//                   ],
//                 ),
//               ),
//               sizedboxheight(10.0),
//               Text(
//                 'Flat 5% off on every session',
//                 style: textstylesubtitle2(context),
//               ),
//               sizedboxheight(15.0),
//               Container(
//                 width: 100,
//                 height: 35,
//                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colororangeLight),
//                 child: MaterialButton(
//                   elevation: 3.0,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'GET NOW',
//                         style: textstylesubtitle1(context)!.copyWith(color: colorWhite, fontSize: 12),
//                       ),
//                     ],
//                   ),
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => const PlanPage()));
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Widget clientsTestimonialList(launchURL, DashboardModelPage model) {
//   return Container(
//     padding: const EdgeInsets.symmetric(vertical: 5),
//     height: 26.h,
//     child: ListView.builder(
//       itemCount: model.clientTestimonialList.length,
//       scrollDirection: Axis.horizontal,
//       physics: const AlwaysScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemBuilder: (context, index) {
//         //print("$TAG clientTestimonialList==========?${model.clientTestimonialList.length}");
//         return Container(
//           width: 65.w,
//           margin: const EdgeInsets.only(left: 10),
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//           decoration: BoxDecoration(
//             color: colorWhite,
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(color: Colors.grey.withOpacity(0.4)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 spreadRadius: 1,
//                 blurRadius: 10,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               Text(
//
//                 model.clientTestimonialList[index]['message'].toString() != "null" ? model.clientTestimonialList[index]['message'].toString() : "",
//                 style: TextStyle(fontSize: 17, height: 0.17.h),
//                 maxLines: 5,
//                 overflow: TextOverflow.ellipsis,
//               ),
//                Divider(thickness: 1),
//               Row(
//                 children: [
//                   ClipRRect(
//                     borderRadius: borderRadiuscircular(45.0),
//                     child: CachedNetworkImage(
//                       height: 6.h,
//                       width: 7.h,
//                       imageUrl: "${model.clientTestimonialList[index]['image_url']}",
//                       placeholder: (context, url) => const Image(image: AssetImage('assets/images/user.png'), fit: BoxFit.fill),
//                       errorWidget: (context, url, error) => const Image(image: AssetImage('assets/images/user.png'), fit: BoxFit.fill),
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 3.w,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         model.clientTestimonialList[index]['user_name'],
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 0.5.h,
//                       ),
//                       Text(
//                         model.clientTestimonialList[index]['location'],
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     ),
//   );
// }

Widget newsList(DashboardModelPage model) {
  return SizedBox(
    height: 26.5.h,
    child: ListView.builder(
      itemCount: model.astroNewsList.length,
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            debugPrint("$TAG model astrology News List =======> ${model.astroNewsList[index]}");
            try {
              launchUrl(Uri.parse(model.astroNewsList[index]["news_url"]));
            } catch (e) {
              debugPrint("$TAG error when opening URL =======> ${e.toString()}");
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 0.5.w),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: SizedBox(
                width: 60.w,
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageBuilder: (context, imageProvider) => Container(
                        height: 16.h,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                          color: Colors.white,
                          image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                        ),
                      ),
                      imageUrl: model.astroNewsList[index]['image_url'],
                      placeholder: (context, url) => Image(image: const AssetImage('assets/icons/news.png'), fit: BoxFit.cover, height: 16.h),
                      errorWidget: (context, url, error) => Image(image: const AssetImage('assets/icons/news.png'), fit: BoxFit.cover, height: 16.h),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Container(
                      height: 4.5.h,
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Text(
                        model.astroNewsList[index]['title'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat('MMM dd,yyyy').format(
                            DateFormat('DD-MM-yyyy').parse(
                              model.astroNewsList[index]['news_date'],
                            ),
                          ),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget appFeatures(context) {
  return SizedBox(
    width: deviceWidth(context, 1.0),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          categoryBox('assets/icons/private.png', 'Private &\nConfidential'),
          categoryBox('assets/icons/verified.png', 'Verified\nAstrologers'),
          categoryBox('assets/icons/secure.png', 'Secure\nPayments'),
        ],
      ),
    ),
  );
}
