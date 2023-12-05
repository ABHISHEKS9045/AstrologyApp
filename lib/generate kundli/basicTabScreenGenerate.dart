import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../common/commonwidgets/commonWidget.dart';
import '../common/shimmereffect.dart';
import '../common/styles/const.dart';
import 'generatekundaliModelPage.dart';
import 'open kundli/kundlidetailswidgetPage.dart';

class BasicTabScreenGenerate extends StatefulWidget {
  final kundaliList;

  const BasicTabScreenGenerate({Key? key, this.kundaliList}) : super(key: key);

  @override
  _BasicTabScreenGenerateState createState() => _BasicTabScreenGenerateState();
}

class _BasicTabScreenGenerateState extends State<BasicTabScreenGenerate> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kundaliList = widget.kundaliList;
    return Consumer<GenratekundliModelPage>(builder: (context, model, _) {
      return model.isShimmer
          ? Center(child: loadingForKundaliTabs())
          : SizedBox(
              height: 71.h,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Basic Details',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    userkundlidetailcontainer1(context, kundaliList),
                    SizedBox(
                      height: 2.h,
                    ),
                    manglikWidget(model),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Text(
                      'Panchang Details',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    userBasicPanchangDetails(context, model),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Text(
                      'Avakhada Details',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    GenerateAvakhadaDetails(context, model),
                  ],
                ),
              ),
            );
    });
  }

  Widget GenerateAvakhadaDetails(BuildContext context, kundlilist) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      height: 85.h,
      // padding: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        border: borderCustom(),
        borderRadius: borderRadiuscircular(15.0),
      ),
      child: Column(
        children: [
          detailuserkundliRowTop(context, 'Varna', kundlilist.astroDetails['Varna'], 0, true),
          detailuserkundliRow(context, 'Vashya', kundlilist.astroDetails['Vashya'], 1),
          detailuserkundliRow(context, 'Yoni', kundlilist.astroDetails['Yoni'], 0),
          detailuserkundliRow(context, 'Gan', kundlilist.astroDetails['Gan'], 1),
          detailuserkundliRow(context, 'Nadi', kundlilist.astroDetails['Nadi'], 0),
          detailuserkundliRow(context, 'Sign', kundlilist.astroDetails['sign'], 1),
          detailuserkundliRow(context, 'Sign Lord', kundlilist.astroDetails['SignLord'], 0),
          detailuserkundliRow(context, 'Nakshatra-Charan', kundlilist.astroDetails['Naksahtra'], 1),
          detailuserkundliRow(context, 'Yog', kundlilist.astroDetails['Yog'], 0),
          detailuserkundliRow(context, 'Karan', kundlilist.astroDetails['Karan'], 1),
          detailuserkundliRow(context, 'Tithi', kundlilist.astroDetails['Tithi'], 0),
          detailuserkundliRow(context, 'Yunja', kundlilist.astroDetails['yunja'], 1),
          detailuserkundliRow(context, 'Tatva', kundlilist.astroDetails['tatva'], 0),
          detailuserkundliRow(context, 'Name Alphabate', kundlilist.astroDetails['name_alphabet'], 1),
          detailuserkundliRowTop(context, 'Paya', kundlilist.astroDetails['paya'], 0, false),
        ],
      ),
    );
  }

  manglikWidget(GenratekundliModelPage model) {
    bool isManglik = false;
    if (model.manglikDetails != null && model.manglikDetails['is_present'] != null) {
      isManglik = model.manglikDetails['is_present'];
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Manglik Analysis',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), border: Border.all(color: isManglik ? Colors.red : Colors.green, width: 2)),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), border: Border.all(color: isManglik ? Colors.red : Colors.green), color: isManglik ? Colors.red : Colors.green),
                child: Text(
                  isManglik ? 'Yes' : 'No',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(
                width: 3.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.kundligenratedetailslist!['name'].toString(),
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    if(model.manglikDetails != null)
                    Text(
                      model.manglikDetails['manglik_report'] ?? "",
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container userkundlidetailcontainer1(BuildContext context, model) {
    return Container(
      height: 35.h,
      decoration: BoxDecoration(
        border: borderCustom(),
        borderRadius: borderRadiuscircular(15.0),
      ),
      child: Column(
        children: [
          detailuserkundliRowTop(context, 'Name', model.kundligenratedetailslist['name'].toString(), 0, true),
          detailuserkundliRow(context, 'Birth Date', model.kundligenratedetailslist['dob'].toString(), 1),
          detailuserkundliRow(context, 'Birth Time', model.kundligenratedetailslist['birth_time'].toString(), 0),
          detailuserkundliRow(context, 'Birth Place', model.kundligenratedetailslist['birth_place'].toString(), 1),
          detailuserkundliRow(context, 'Latitude', model.kundligenratedetailslist['latitude'].toString(), 0),
          detailuserkundliRow(context, 'Longitude', model.kundligenratedetailslist['longitude'].toString(), 1),
          detailuserkundliRowTop(context, 'Time Zone', model.kundligenratedetailslist['timezone'].toString(), 0, false),
        ],
      ),
    );
  }

  Widget userBasicPanchangDetails(BuildContext context, kundlilist) {
    return Container(
      height: 32.h,
      decoration: BoxDecoration(
        border: borderCustom(),
        borderRadius: borderRadiuscircular(15.0),
      ),
      child: Column(
        children: [
          detailuserkundliRowTop(context, 'Tithi', kundlilist.panchangDetails['tithi'], 0, true),
          detailuserkundliRow(context, 'Karan', kundlilist.panchangDetails['karan'], 1),
          detailuserkundliRow(context, 'Yog', kundlilist.panchangDetails['yog'], 0),
          detailuserkundliRow(context, 'Nakshatra', kundlilist.panchangDetails['nakshatra'], 1),
          detailuserkundliRow(context, 'Sunrise', kundlilist.panchangDetails['sunrise'], 0),
          detailuserkundliRowTop(context, 'Sunset', kundlilist.panchangDetails['sunset'], 1, false),
        ],
      ),
    );
  }
}
