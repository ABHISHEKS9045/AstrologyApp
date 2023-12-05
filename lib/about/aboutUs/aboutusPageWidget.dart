

import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';

Widget aboutUsWidget(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About US',
          style: TextStyle(
              color: colorblack,
              fontSize: 20,
              fontWeight: FontWeight.w500
          ),
        ),
        sizedboxheight(5.0),
        Text(
          "Connect Aastro is an e-commerce aggregator of astrologers, offering online astrology consultations through chat and calls. We connect customers with experienced astrologers who provide personalized guidance in areas such as palmistry, Kundali reading, and Vaastu. Discover insights and seek advice from professional astrologers conveniently through our platform.",
          style: TextStyle(
              color: colorblack,
              fontSize: 16,
              fontWeight: FontWeight.w300
          ),
        ),
      ],
    ),
  );
}

Widget contactUsWidget(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Us',
          style: TextStyle(
              color: colorblack,
              fontSize: 20,
              fontWeight: FontWeight.w500
          ),
        ),
        sizedboxheight(5.0),
        Text(
          "If you have any questions about this Agreement or our website, please contact us at \"talent@connectaastro.com\"."+
            "\n\nThank you for using our Application!",
          style: TextStyle(
              color: colorblack,
              fontSize: 16,
              fontWeight: FontWeight.w300
          ),
        ),
      ],
    ),
  );
}