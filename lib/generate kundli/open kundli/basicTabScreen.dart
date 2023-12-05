import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../common/commonwidgets/commonWidget.dart';
import '../../common/shimmereffect.dart';
import '../../common/styles/const.dart';
import '../openkundlimodelpage.dart';
import 'kundlidetailswidgetPage.dart';

class BasicTabScreen extends StatefulWidget {
  final kundaliList;

  const BasicTabScreen({Key? key, this.kundaliList}) : super(key: key);

  @override
  _BasicTabScreenState createState() => _BasicTabScreenState();
}

class _BasicTabScreenState extends State<BasicTabScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      Future.delayed(const Duration(seconds: 3));

      // var list = Provider.of<Openkundlimodelpage>(context, listen: false);
      // await list.kudaliPanchangDetails(context,widget.kundaliList);
      // print('open kundli list init');
    });
  }

  @override
  Widget build(BuildContext context) {
    final kundaliList = widget.kundaliList;
    return Consumer<Openkundlimodelpage>(builder: (context, model, _) {
      return model.isShimmer
          ? Center(child: loadingForKundaliTabs())
          : SizedBox(
              height: 73.h,
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

                    userBasicAvakhadaDetails(context, model),

                    // SizedBox(height: 2.h,),
                  ],
                ),
              ),
            );
    });
  }

  manglikWidget(model) {
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
                      widget.kundaliList['kundli_user_name'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    if (model.manglikDetails != null && model.manglikDetails['manglik_report'] != null)
                      Text(
                        model.manglikDetails['manglik_report'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
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

  Container userkundlidetailcontainer1(BuildContext context, kundlilist) {
    String birthDate = kundlilist['birth_day'].toString() + '-' + kundlilist['birth_month'].toString() + '-' + kundlilist['birthday_year'].toString();
    return Container(
      height: 35.h,
      decoration: BoxDecoration(
        border: borderCustom(),
        borderRadius: borderRadiuscircular(15.0),
      ),
      child: Column(
        children: [
          detailuserkundliRowTop(context, 'Name', kundlilist['kundli_user_name'].toString(), 0, true),
          detailuserkundliRow(context, 'Birth Date', birthDate.toString(), 1),
          detailuserkundliRow(context, 'Birth Time', kundlilist['birth_time'].toString(), 0),
          detailuserkundliRow(context, 'Birth Place', kundlilist['birth_place'].toString(), 1),
          detailuserkundliRow(context, 'Latitude', kundlilist['lat'].toString(), 0),
          detailuserkundliRow(context, 'Longitude', kundlilist['long'].toString(), 1),
          detailuserkundliRowTop(context, 'Time Zone', kundlilist['time_zone'].toString(), 0, false),
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
      child: kundlilist.panchangDetails != null
          ? Column(
              children: [
                if (kundlilist.panchangDetails['tithi'] != null) detailuserkundliRowTop(context, 'Tithi', kundlilist.panchangDetails['tithi'], 0, true),
                if (kundlilist.panchangDetails['karan'] != null) detailuserkundliRow(context, 'Karan', kundlilist.panchangDetails['karan'], 1),
                if (kundlilist.panchangDetails['yog'] != null) detailuserkundliRow(context, 'Yog', kundlilist.panchangDetails['yog'], 0),
                if (kundlilist.panchangDetails['nakshatra'] != null) detailuserkundliRow(context, 'Nakshatra', kundlilist.panchangDetails['nakshatra'], 1),
                if (kundlilist.panchangDetails['sunrise'] != null) detailuserkundliRow(context, 'Sunrise', kundlilist.panchangDetails['sunrise'], 0),
                if (kundlilist.panchangDetails['sunset'] != null) detailuserkundliRowTop(context, 'Sunset', kundlilist.panchangDetails['sunset'], 1, false),
              ],
            )
          : Container(),
    );
  }

  Widget userBasicAvakhadaDetails(BuildContext context, kundlilist) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      height: 85.h,
      // padding: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        border: borderCustom(),
        borderRadius: borderRadiuscircular(15.0),
      ),
      child: kundlilist.astroDetails != null
          ? Column(
              children: [
                if (kundlilist.astroDetails['Varna'] != null) detailuserkundliRowTop(context, 'Varna', kundlilist.astroDetails['Varna'], 0, true),
                if (kundlilist.astroDetails['Vashya'] != null) detailuserkundliRow(context, 'Vashya', kundlilist.astroDetails['Vashya'], 1),
                if (kundlilist.astroDetails['Yoni'] != null) detailuserkundliRow(context, 'Yoni', kundlilist.astroDetails['Yoni'], 0),
                if (kundlilist.astroDetails['Gan'] != null) detailuserkundliRow(context, 'Gan', kundlilist.astroDetails['Gan'], 1),
                if (kundlilist.astroDetails['Nadi'] != null) detailuserkundliRow(context, 'Nadi', kundlilist.astroDetails['Nadi'], 0),
                if (kundlilist.astroDetails['sign'] != null) detailuserkundliRow(context, 'Sign', kundlilist.astroDetails['sign'], 1),
                if (kundlilist.astroDetails['SignLord'] != null) detailuserkundliRow(context, 'Sign Lord', kundlilist.astroDetails['SignLord'], 0),
                if (kundlilist.astroDetails['Naksahtra'] != null) detailuserkundliRow(context, 'Nakshatra-Charan', kundlilist.astroDetails['Naksahtra'], 1),
                if (kundlilist.astroDetails['Yog'] != null) detailuserkundliRow(context, 'Yog', kundlilist.astroDetails['Yog'], 0),
                if (kundlilist.astroDetails['Karan'] != null) detailuserkundliRow(context, 'Karan', kundlilist.astroDetails['Karan'], 1),
                if (kundlilist.astroDetails['Tithi'] != null) detailuserkundliRow(context, 'Tithi', kundlilist.astroDetails['Tithi'], 0),
                if (kundlilist.astroDetails['yunja'] != null) detailuserkundliRow(context, 'Yunja', kundlilist.astroDetails['yunja'], 1),
                if (kundlilist.astroDetails['tatva'] != null) detailuserkundliRow(context, 'Tatva', kundlilist.astroDetails['tatva'], 0),
                if (kundlilist.astroDetails['name_alphabet'] != null) detailuserkundliRow(context, 'Name Alphabate', kundlilist.astroDetails['name_alphabet'], 1),
                if (kundlilist.astroDetails['paya'] != null) detailuserkundliRowTop(context, 'Paya', kundlilist.astroDetails['paya'], 0, false),
              ],
            )
          : Container(),
    );
  }
}
