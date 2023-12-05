import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';
import 'contactuspageWidget.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: getappbarcommon(context, 'Contact Us'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            discribeProbfield(context),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Screenshots (opational)',
                  style: Theme.of(context).textTheme.headline1,
                ),
                sizedboxheight(10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    addscreenshotfield(context),
                    addscreenshotfield(context),
                    addscreenshotfield(context),
                  ],
                )
              ],
            ),
            sizedboxheight(40.0),
            submitBtn(context),
          ],
        ),
      ),
    );
  }
}
