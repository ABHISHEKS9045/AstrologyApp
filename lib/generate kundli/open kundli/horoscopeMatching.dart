import 'package:astrologyapp/generate%20kundli/open%20kundli/showHoroscopeMatch.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../GoogleSearchScreen.dart';
import '../../common/commonwidgets/button.dart';
import '../../common/commonwidgets/commonWidget.dart';
import '../../common/formtextfield/myTextField.dart';
import '../../common/formtextfield/validations_field.dart';
import '../../common/shimmereffect.dart';
import '../../common/styles/const.dart';
import '../../dashboard/dashboardModelPage.dart';
import '../../login Page/loginpageWidget.dart';
import '../generatekundaliModelPage.dart';

class HoroscopeMatchingPage extends StatefulWidget {
  const HoroscopeMatchingPage({Key? key}) : super(key: key);

  @override
  _HoroscopeMatchingPageState createState() => _HoroscopeMatchingPageState();
}

class _HoroscopeMatchingPageState extends State<HoroscopeMatchingPage> {
  final formkey = GlobalKey<FormState>();
  TextEditingController boyNameController = TextEditingController();
  TextEditingController girlNameController = TextEditingController();

  DateTime? bPickDate;
  DateTime? gPickDate;
  TimeOfDay? bSelectedTime, gSelectedTime;
  String bSelectedPlace = "", bSelectedTimeString = "", gSelectedTimeString = "", gSelectedPlace = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<GenratekundliModelPage>(builder: (context, model, _) {
      return Stack(
        children: [
          bgImagecommon(context),
          SingleChildScrollView(
            child: Column(
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
                        border: Border.all(color: colorgreyblack.withOpacity(0.1)),
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
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'HOROSCOPE MATCHING',
                      style: textstyletitleHeading6(context)!.copyWith(color: colorWhite, fontWeight: fontWeight900, letterSpacing: 1, fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 83.h,
                  child: Container(
                    width: 100.w,
                    decoration: decorationtoprounded(),
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30 )),
                    //     color: Colors.white
                    // ),
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: SingleChildScrollView(
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Column(
                        children: [
                          Consumer<GenratekundliModelPage>(builder: (context, model, _) {
                            return Stack(
                              children: [
                                Column(
                                  children: [
                                    sizedboxheight(30.0),
                                    Form(
                                      key: formkey,
                                      // ignore: deprecated_member_use
                                      // autovalidate: model.autovalidate,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 55.h,
                                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                                            decoration: BoxDecoration(
                                              border: borderCustom(),
                                              borderRadius: borderRadiuscircular(15.0),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 2.5.h,
                                                ),
                                                const Text(
                                                  "Boy's Details",
                                                  style: TextStyle(fontSize: 18),
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                AllInputDesign(
                                                  fillColor: colorWhite,
                                                  controller: boyNameController,
                                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                                  hintText: 'Enter Name',
                                                  textInputAction: TextInputAction.next,
                                                  prefixIcon: const Image(image: AssetImage('assets/icons/people.png')),
                                                  focusedBorderColor: colororangeLight,
                                                  enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
                                                  keyBoardType: TextInputType.text,
                                                  validatorFieldValue: 'name',
                                                  validator: validateName,
                                                ),
                                                // fullnamekundli(model, modelprofileview),
                                                SizedBox(
                                                  height: 1.5.h,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    FocusScope.of(context).unfocus();
                                                    showKundaliDatePicker(0);
                                                  },
                                                  child: AllInputDesign(
                                                    enabled: false,
                                                    // labelText: model.gettext(),
                                                    fillColor: colorWhite,
                                                    hintText: bPickDate == null ? 'Enter Birth Date' : DateFormat('dd-MM-yyyy').format(bPickDate!),
                                                    prefixIcon: const Image(image: AssetImage('assets/icons/call.png')),
                                                    focusedBorderColor: colororangeLight,
                                                    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
                                                    keyBoardType: TextInputType.text,
                                                    // validatorFieldValue: 'name',
                                                    // validator: validate,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 1.5.h,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    selectTime(0);
                                                  },
                                                  child: AllInputDesign(
                                                    fillColor: colorWhite,
                                                    enabled: false,
                                                    hintText: bSelectedTime == null ? 'Enter Birth Time' : bSelectedTimeString,
                                                    // hintText:  modelprofileview.userdataMap['birth_time'].toString(),
                                                    // labelText: model.gettimetext(),
                                                    prefixIcon: const Image(image: AssetImage('assets/icons/time.png')),
                                                    focusedBorderColor: colororangeLight,
                                                    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
                                                  ),
                                                ),
                                                // birthtimekundli(context, model, modelprofileview),
                                                SizedBox(
                                                  height: 1.5.h,
                                                ),
                                                // birthplacekundli(model,modelprofileview),
                                                InkWell(
                                                  onTap: () async {
                                                    bSelectedPlace = await Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleSearchScreen()));
                                                    //// print("place"+selectedPlace.toString());
                                                  },
                                                  child: AllInputDesign(
                                                    // key: Key("dob"),
                                                    enabled: false,
                                                    // labelText: model.gettext(),
                                                    fillColor: colorWhite,
                                                    hintText: bSelectedPlace == "" ? 'Enter Birth Address' : bSelectedPlace,
                                                    prefixIcon: const Icon(Icons.home),
                                                    focusedBorderColor: colororangeLight,
                                                    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
                                                    keyBoardType: TextInputType.text,
                                                  ),
                                                )
                                                // googleplace(model, modelprofileview)
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Container(
                                            height: 55.h,
                                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                                            decoration: BoxDecoration(
                                              border: borderCustom(),
                                              borderRadius: borderRadiuscircular(15.0),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 2.5.h,
                                                ),
                                                const Text(
                                                  "Girl's Details",
                                                  style: TextStyle(fontSize: 18),
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                // fullnamekundli(model, modelprofileview),
                                                // SizedBox(height: 1.5.h,),
                                                // dobkundli(context, model, modelprofileview),
                                                // SizedBox(height: 1.5.h,),
                                                // birthtimekundli(context, model, modelprofileview),
                                                // SizedBox(height: 1.5.h,),
                                                // // birthplacekundli(model,modelprofileview),
                                                // googleplace(model, modelprofileview)
                                                AllInputDesign(
                                                  fillColor: colorWhite,
                                                  controller: girlNameController,
                                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                                  hintText: 'Enter Name',
                                                  textInputAction: TextInputAction.next,
                                                  prefixIcon: const Image(image: AssetImage('assets/icons/people.png')),
                                                  focusedBorderColor: colororangeLight,
                                                  enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
                                                  keyBoardType: TextInputType.text,
                                                  validatorFieldValue: 'name',
                                                  validator: validateName,
                                                ),
                                                // fullnamekundli(model, modelprofileview),
                                                SizedBox(
                                                  height: 1.5.h,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    FocusScope.of(context).unfocus();
                                                    showKundaliDatePicker(1);
                                                  },
                                                  child: AllInputDesign(
                                                    enabled: false,
                                                    // labelText: model.gettext(),
                                                    fillColor: colorWhite,
                                                    hintText: gPickDate == null ? 'Enter Birth Date' : DateFormat('dd-MM-yyyy').format(gPickDate!),
                                                    prefixIcon: const Image(image: AssetImage('assets/icons/call.png')),
                                                    focusedBorderColor: colororangeLight,
                                                    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
                                                    keyBoardType: TextInputType.text,
                                                    // validatorFieldValue: 'name',
                                                    // validator: validate,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 1.5.h,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    selectTime(1);
                                                  },
                                                  child: AllInputDesign(
                                                    fillColor: colorWhite,
                                                    enabled: false,
                                                    hintText: gSelectedTime == null ? 'Enter Birth Time' : gSelectedTimeString,
                                                    // hintText:  modelprofileview.userdataMap['birth_time'].toString(),
                                                    // labelText: model.gettimetext(),
                                                    prefixIcon: const Image(image: AssetImage('assets/icons/time.png')),
                                                    focusedBorderColor: colororangeLight,
                                                    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
                                                  ),
                                                ),
                                                // birthtimekundli(context, model, modelprofileview),
                                                SizedBox(
                                                  height: 1.5.h,
                                                ),
                                                // birthplacekundli(model,modelprofileview),
                                                InkWell(
                                                  onTap: () async {
                                                    gSelectedPlace = await Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleSearchScreen()));
                                                    //// print("place"+selectedPlace.toString());
                                                  },
                                                  child: AllInputDesign(
                                                    // key: Key("dob"),
                                                    enabled: false,
                                                    // labelText: model.gettext(),
                                                    fillColor: colorWhite,
                                                    hintText: gSelectedPlace == "" ? 'Enter Birth Address' : gSelectedPlace,
                                                    prefixIcon: const Icon(Icons.home),
                                                    focusedBorderColor: colororangeLight,
                                                    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
                                                    keyBoardType: TextInputType.text,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    sizedboxheight(20.0),
                                    Button(
                                      btnWidth: deviceWidth(context, 1.0),
                                      btnHeight: 55,
                                      buttonName: 'MATCH HOROSCOPE',
                                      borderRadius: BorderRadius.circular(15.0),
                                      btnColor: colororangeLight,
                                      onPressed: () async {
                                        if (boyNameController.text.toString().isEmpty && bPickDate == null && bSelectedTime == null && bSelectedPlace.isEmpty) {
                                          Fluttertoast.showToast(msg: 'Please add Boy\'s details');
                                        } else if (girlNameController.text.toString().isEmpty && gPickDate == null && gSelectedTime == null && gSelectedPlace.isEmpty) {
                                          Fluttertoast.showToast(msg: 'Please add Girl\'s details');
                                        } else {
                                          var dbcontroller = Provider.of<DashboardModelPage>(context, listen: false);
                                          if (dbcontroller.isGeustLoggedIn) {
                                            geustloginfirst(context);
                                          } else {
                                            Map<String, dynamic> map = {
                                              'm_name': boyNameController.text,
                                              'm_date': bPickDate!.day,
                                              'm_month': bPickDate!.month,
                                              'm_year': bPickDate!.year,
                                              'm_hour': bSelectedTime!.hour,
                                              'm_minute': bSelectedTime!.minute,
                                              'm_place': bSelectedPlace,
                                              'm_only_time': bSelectedTimeString,
                                              'm_only_date': DateFormat('dd-MM-yyyy').format(bPickDate!),

                                              'f_name': girlNameController.text,
                                              'f_date': gPickDate!.day,
                                              'f_month': gPickDate!.month,
                                              'f_year': gPickDate!.year,
                                              'f_hour': gSelectedTime!.hour,
                                              'f_minute': gSelectedTime!.minute,
                                              'f_place': gSelectedPlace,
                                              'f_only_time': gSelectedTimeString,
                                              'f_only_date': DateFormat('dd-MM-yyyy').format(gPickDate!),

                                              // 'userid': 'aman946',
                                              // 'authcode': '621457c19852983c83f06ff992ee36d4'
                                            };

                                            var horoscopeRes = await model.matchHoroscope(
                                              boyNameController,
                                              bPickDate!,
                                              bSelectedTime!,
                                              bSelectedPlace,
                                              girlNameController,
                                              gPickDate!,
                                              gSelectedTime!,
                                              gSelectedPlace,
                                            );

                                            var manglikRes = await model.matchManglikReport(
                                              context,
                                              boyNameController,
                                              bPickDate!,
                                              bSelectedTime!,
                                              bSelectedPlace,
                                              girlNameController,
                                              gPickDate!,
                                              gSelectedTime!,
                                              gSelectedPlace,
                                            );
                                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                                              return ShowHoroscopeMatchPage(
                                                horoscopeResponseData: horoscopeRes,
                                                manglikResponseData: manglikRes,
                                                userData: map,
                                              );
                                            }));
                                          }
                                        }
                                      },
                                    ),
                                    sizedboxheight(50.0),
                                  ],
                                ),
                                model.isShimmer
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 150),
                                        child: loadingwidget(),
                                      )
                                    : Container()
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          // model.isShimmer ? loadingwidget() : Container()
        ],
      );
    }));
  }

  showKundaliDatePicker(choice) async {
    //choice 0 for boy 1 for girl
    if (choice == 0) {
      bPickDate = DateTime.now();
    } else {
      gPickDate = DateTime.now();
    }
    DateTime currentDate = DateTime.now();
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2050),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: colororangeLight, // <-- SEE HERE
                onPrimary: Colors.white, // <-- SEE HERE
                // onSurface: Colors.white, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: colororangeLight, //
                ),
              ),
            ),
            child: child!,
          );
        }) as DateTime;
    if (pickedDate != currentDate) currentDate = pickedDate;
    if (choice == 0) {
      bPickDate = pickedDate;
    } else {
      gPickDate = pickedDate;
    }
    setState(() {});
  }

  selectTime(choice) async {
    //choice 0 for boy and 1 for girl
    if (choice == 0 && bSelectedTime == null) {
      bSelectedTime = TimeOfDay.now();
    } else if (choice == 1 && gSelectedTime == null) {
      gSelectedTime = TimeOfDay.now();
    }
    TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: choice == 0 ? bSelectedTime! : gSelectedTime!,
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: colororangeLight, // <-- SEE HERE
                onPrimary: Colors.white, // <-- SEE HERE
                // onSurface: Colors.white, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: colororangeLight, //
                ),
              ),
            ),
            child: child!,
          );
        });
    if (choice == 0) {
      if (timeOfDay != bSelectedTime) {
        bSelectedTime = timeOfDay as TimeOfDay;
      }
      final hours = bSelectedTime!.hour.toString().padLeft(2, '0');
      final minutes = bSelectedTime!.minute.toString().padLeft(2, '0');
      bSelectedTimeString = "$hours:$minutes";
    } else {
      if (timeOfDay != gSelectedTime) {
        gSelectedTime = timeOfDay as TimeOfDay;
      }
      final hours = gSelectedTime!.hour.toString().padLeft(2, '0');
      final minutes = gSelectedTime!.minute.toString().padLeft(2, '0');
      gSelectedTimeString = "$hours:$minutes";
    }
    setState(() {});
  }
}
