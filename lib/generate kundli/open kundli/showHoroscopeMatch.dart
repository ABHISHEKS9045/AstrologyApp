import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../common/commonwidgets/commonWidget.dart';
import '../../common/styles/const.dart';
import '../../login Page/loginpageWidget.dart';
import '../generatekundaliModelPage.dart';

class ShowHoroscopeMatchPage extends StatefulWidget {
  final horoscopeResponseData, manglikResponseData, userData;

  ShowHoroscopeMatchPage({this.horoscopeResponseData, this.manglikResponseData, this.userData});

  @override
  _ShowHoroscopeMatchPageState createState() => _ShowHoroscopeMatchPageState();
}

class _ShowHoroscopeMatchPageState extends State<ShowHoroscopeMatchPage> {
  @override
  Widget build(BuildContext context) {
    final responseHoroscope = widget.horoscopeResponseData;
    final responseManglik = widget.manglikResponseData;
    final userData = widget.userData;
    return Scaffold(
      body: responseHoroscope == null
          ? Container(
        child: Stack(
          children: [
            bgImagecommon(context),
            Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5.w,
                    ),
                    Container(
                      width: 36,
                      height: 34,
                      decoration: BoxDecoration(
                        color: colorWhite,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: colorgreyblack.withOpacity(0.1),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: colorblack,
                              size: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    const Text(
                      'COMPATIBILITY SCORE',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: deviceWidth(context, 1.0),
                  height: deviceheight(context, 0.83),
                  decoration: decorationtoprounded(),
                  child: const Center(
                    child: Text(
                      "Service not available at this time.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
          : Consumer<GenratekundliModelPage>(builder: (context, GenratekundliModelPage model, _) {
              return Stack(
                children: [
                  bgImagecommon(context),
                  Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 5.w,
                          ),
                          Container(
                            width: 36,
                            height: 34,
                            decoration: BoxDecoration(
                              color: colorWhite,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: colorgreyblack.withOpacity(0.1),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // print('click back2 appbar');
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: colorblack,
                                    size: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          const Text(
                            'COMPATIBILITY SCORE',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        width: 28.w,
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${responseHoroscope['total']['received_points']}/",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              responseHoroscope['total']['total_points'].toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Expanded(
                        child: Container(
                          child: SingleChildScrollView(
                            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                            child: Container(
                              width: 100.w,
                              decoration: decorationtoprounded(),
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  const Text(
                                    'Details',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  pointWidget(
                                    "Compatibility (Varna)",
                                    responseHoroscope['varna']['description'],
                                    responseHoroscope['varna']['received_points'],
                                    responseHoroscope['varna']['total_points'],
                                    Colors.orange,
                                  ),
                                  pointWidget(
                                    "Love (Bhakut)",
                                    responseHoroscope['bhakut']['description'],
                                    responseHoroscope['bhakut']['received_points'],
                                    responseHoroscope['bhakut']['total_points'],
                                    Colors.lightGreen,
                                  ),
                                  pointWidget(
                                    "Mental Compatibility (Maitri)",
                                    responseHoroscope['maitri']['description'],
                                    responseHoroscope['maitri']['received_points'],
                                    responseHoroscope['maitri']['total_points'],
                                    Colors.purple,
                                  ),
                                  pointWidget(
                                    "Health (Nadi)",
                                    responseHoroscope['nadi']['description'],
                                    responseHoroscope['nadi']['received_points'],
                                    responseHoroscope['nadi']['total_points'],
                                    Colors.blue,
                                  ),
                                  pointWidget(
                                    "Dominance (Vashya)",
                                    responseHoroscope['vashya']['description'],
                                    responseHoroscope['vashya']['received_points'],
                                    responseHoroscope['vashya']['total_points'],
                                    Colors.pink,
                                  ),
                                  // pointWidget("Temperament (Gana)",response['gana']['description'],response['gana']['received_points'].toString(),response['gana']['total_points'],Colors.orange),
                                  pointWidget(
                                    "Destiny (Tara)",
                                    responseHoroscope['tara']['description'],
                                    responseHoroscope['tara']['received_points'],
                                    responseHoroscope['tara']['total_points'],
                                    Colors.green,
                                  ),
                                  pointWidget(
                                    "Physical Compatibility (Yoni)",
                                    responseHoroscope['yoni']['description'],
                                    responseHoroscope['yoni']['received_points'],
                                    responseHoroscope['yoni']['total_points'],
                                    Colors.orange,
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  const Text(
                                    'Manglik Report',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          model.onlydate = userData['m_only_date'];
                                          model.onlytime = userData['m_only_time'];
                                          model.setAddress(userData['m_place']);
                                          model.kundliName.text = userData['m_name'];

                                          model.kundalisubmit(context, model);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.blue.shade300,
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.blue.shade300, width: 3),
                                                  borderRadius: BorderRadius.circular(50),
                                                ),
                                                child: Icon(
                                                  Icons.male,
                                                  size: 60,
                                                  color: Colors.blue.shade300,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Text(
                                                'Male',
                                                style: TextStyle(
                                                  color: Colors.blue.shade300,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                responseManglik['male']['is_present'] == true ? 'Manglink' : "Non Manglink",
                                                style: TextStyle(color: Colors.blue.shade300, fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Text(
                                                'Tap to\nView Kundali',
                                                style: TextStyle(
                                                  color: Colors.blue.shade300,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          model.onlydate = userData['f_only_date'];
                                          model.onlytime = userData['f_only_time'];
                                          model.setAddress(userData['f_place']);
                                          model.kundliName.text = userData['f_name'];

                                          model.kundalisubmit(context, model);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 2.h,
                                            horizontal: 4.w,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.pinkAccent.shade100,
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.pinkAccent.shade100,
                                                    width: 3,
                                                  ),
                                                  borderRadius: BorderRadius.circular(50),
                                                ),
                                                child: Icon(
                                                  Icons.female,
                                                  size: 60,
                                                  color: Colors.pinkAccent.shade100,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Text(
                                                'Female',
                                                style: TextStyle(
                                                  color: Colors.pinkAccent.shade100,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                responseManglik['female']['is_present'] == true ? 'Manglink' : "Non Manglink",
                                                style: TextStyle(
                                                  color: Colors.pinkAccent.shade100,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Text(
                                                'Tap to\nView Kundali',
                                                style: TextStyle(
                                                  color: Colors.pinkAccent.shade100,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            }),
    );
  }

  pointWidget(name, des, recP, totalP, MaterialColor color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      padding: EdgeInsets.only(left: 5.w, top: 2.h, bottom: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.shade300, width: 2),
        color: color.shade50,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 62.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(des)
              ],
            ),
          ),
          SizedBox(
            height: 8.h,
            width: 20.w,
            child: CircularPercentIndicator(
              radius: 4.h,
              lineWidth: 5.0,
              percent: recP / totalP,
              center: Text(
                "$recP/$totalP",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              progressColor: color.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
