import 'package:astrologyapp/common/commonwidgets/button.dart';
import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/formtextfield/myTextField.dart';
import 'package:astrologyapp/common/formtextfield/validations_field.dart';
import 'package:astrologyapp/common/shimmereffect.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/dashboard/dashboardModelPage.dart';
import 'package:astrologyapp/generate%20kundli/generatekundaliModelPage.dart';
import 'package:astrologyapp/generate%20kundli/open%20kundli/kundlidetails.dart';
import 'package:astrologyapp/generate%20kundli/openkundlimodelpage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import '../GoogleSearchScreen.dart';

Widget fullnamekundli(model, modelprofileview) {
  return AllInputDesign(
    key: const Key("fullname"),
    fillColor: colorWhite,
    controller: model.kundliName,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    hintText: modelprofileview.userdataMap['name'].toString() != 'null' ? modelprofileview.userdataMap['name'].toString() : 'Enter Name',
    textInputAction: TextInputAction.next,
    prefixIcon: const Image(
      image: AssetImage(
        'assets/icons/people.png',
      ),
    ),
    focusedBorderColor: colororangeLight,
    enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
    keyBoardType: TextInputType.text,
    validatorFieldValue: 'name',
    validator: validateName,
  );
}

Widget dobkundli(context, GenratekundliModelPage model, DashboardModelPage modelprofileview) {
  return InkWell(
    onTap: () {
      model.selectDate(context);
    },
    child: AllInputDesign(
      key: const Key("dob"),
      enabled: false,
      // labelText: model.gettext(),
      fillColor: colorWhite,
      hintText: model.gettext(modelprofileview) != 'null' ? model.gettext(modelprofileview) : 'Enter Birth Date',
      prefixIcon: const Image(
        image: AssetImage(
          'assets/icons/call.png',
        ),
      ),
      focusedBorderColor: colororangeLight,
      enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
      // keyBoardType: TextInputType.datetime,
      // validatorFieldValue: 'name',
      // validator: validate,
    ),
  );
}

Widget birthtimekundli(context, model, modelprofileview) {
  return InkWell(
    onTap: () {
      model.selectTime(context);
    },
    child: AllInputDesign(
      key: const Key("time"),
      fillColor: colorWhite,
      enabled: false,
      hintText: model.gettimetext(modelprofileview) != 'null' ? model.gettimetext(modelprofileview) : 'Enter Birth Time',
      // hintText:  modelprofileview.userdataMap['birth_time'].toString(),
      // labelText: model.gettimetext(),
      prefixIcon: const Image(
        image: AssetImage(
          'assets/icons/time.png',
        ),
      ),
      focusedBorderColor: colororangeLight,
      enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
    ),
  );
}

// Widget birthplacekundli(model, modelprofileview) {
//   return AllInputDesign(
//     key: Key("place"),
//     fillColor: colorWhite,
//     hintText: modelprofileview.userdataMap['birth_place'].toString()!='null'? modelprofileview.userdataMap['birth_place'].toString():'Enter Birth Address',
//     controller: model.kundliPlace,
//     floatingLabelBehavior: FloatingLabelBehavior.never,
//     prefixIcon: Image(image: AssetImage('assets/icons/location.png')),
//     focusedBorderColor: colororangeLight,
//     enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
//     keyBoardType: TextInputType.emailAddress,
//     validatorFieldValue: 'name',
//     validator: validaterequired,
//   );
// }

Widget googleplace(model, modelprofileview) {
  return InkWell(
    onTap: () {
      Get.to(() => GoogleSearchScreen());
    },
    child: AllInputDesign(
      key: const Key("dob"),
      enabled: false,
      // labelText: model.gettext(),
      fillColor: colorWhite,
      hintText: model.togglselectaddrestap(modelprofileview) != 'null' ? model.togglselectaddrestap(modelprofileview) : 'Enter Birth Address',
      prefixIcon: const Icon(Icons.home),
      focusedBorderColor: colororangeLight,
      enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
      keyBoardType: TextInputType.text,
    ),
  );
}

Widget generatekundiliBtn(BuildContext context, formKey, model) {
  return Button(
    btnWidth: deviceWidth(context, 1.0),
    btnHeight: 55,
    buttonName: 'Generate Kundli',
    key: const Key('genratekundli'),
    borderRadius: BorderRadius.circular(15.0),
    btnColor: colororangeLight,
    onPressed: () async {
      var dbcontroller = Provider.of<DashboardModelPage>(context, listen: false);
      if (dbcontroller.isGeustLoggedIn) {
        geustloginfirst(context);
      } else
        model.kundalisubmit(context, model);
    },
  );
}

Widget genrateKundliTabBarview(context, formkey) {
  final modelprofileview = Provider.of<DashboardModelPage>(context, listen: false);
  return SingleChildScrollView(
    child: Consumer<GenratekundliModelPage>(builder: (context, GenratekundliModelPage model, _) {
      return Stack(
        children: [
          Column(
            children: [
              sizedboxheight(30.0),
              Form(
                key: formkey,
                // ignore: deprecated_member_use
                // autovalidate: model.autovalidate,
                child: Container(
                  height: 280,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: borderCustom(),
                    borderRadius: borderRadiuscircular(15.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      fullnamekundli(model, modelprofileview),
                      dobkundli(context, model, modelprofileview),
                      birthtimekundli(context, model, modelprofileview),
                      // birthplacekundli(model,modelprofileview),
                      googleplace(model, modelprofileview)
                    ],
                  ),
                ),
              ),
              sizedboxheight(20.0),
              generatekundiliBtn(context, formkey, model),
              sizedboxheight(130.0),
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
  );
}

Widget openkundlitabbarview(context, formkey) {
  return SingleChildScrollView(child: Consumer<Openkundlimodelpage>(builder: (context, model, _) {
    return Column(
      children: [
        sizedboxheight(15.0),
        Row(
          children: [
            Text(
              'All Kundlis',
              style: textstyletitleHeading6(context),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        model.isShimmer ? shimmer() : recentkundlilistWidget(context, model),
        sizedboxheight(50.0),
      ],
    );
  }));
}

Widget recentkundlilistWidget(context, model) {
  return model.kundlilist.length == 0
      ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: deviceheight(context, 0.6),
              child: Center(
                child: Text(
                  'No Kundli Genrated',
                  style: textstyleHeading3(context),
                ),
              ),
            ),
          ],
        )
      : Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: ListView.builder(
              physics: const ScrollPhysics(),
              itemCount: model.kundlilist.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  // splashColor: colorblack,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KundlidetailsPage(
                          kundaliList: model.kundlilist[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    // height: 80,
                    margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      color: colorWhite,
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(
                        color: colorgreyblack.withOpacity(
                          0.2,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          borderRadius: borderRadiuscircular(10.0),
                        ),
                        child: model.kundlilist[index]['generate_kundli_image'] != null
                            ? Image.network(
                                model.kundlilist[index]['generate_kundli_image'],
                              )
                            : const Image(
                                image: AssetImage(
                                  'assets/images/user.png',
                                ),
                              ),
                      ),
                      title: Text(
                        model.kundlilist[index]['kundli_user_name'].toString(),
                        style: textstyletitleHeading6(context),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            model.kundlilist[index]['generate_date'].toString(),
                            overflow: TextOverflow.ellipsis,
                            style: textstylesubtitle2(context)!.copyWith(
                              fontSize: 15,
                            ),
                          ),
                          sizedboxwidth(3.0),
                          // Text(
                          //   model.kundlilist[index]['birth_place'].toString(),
                          //   overflow: TextOverflow.ellipsis,maxLines: 1,
                          //   style: textstylesubtitle2(context)!.copyWith(fontSize: 15),
                          // ),
                        ],
                      ),
                      // trailing: Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   children: [
                      //     Container(
                      //       width: 20,
                      //       child: InkWell(onTap: () {}, child: Icon(Icons.more_horiz_outlined)),
                      //     ),
                      //   ],
                      // )
                    ),
                  ),
                );
              }),
        );
}
