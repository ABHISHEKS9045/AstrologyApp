import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/edit%20profile/editprofilepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../dashboard/dashboardModelPage.dart';

// profile profile widget
Widget profileHeader(context, DashboardModelPage model) {
  return Container(
    height: 140.0,
    margin: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Stack(
      children: [
        Container(
          width: deviceWidth(context, 1.0),
          height: 120,
          decoration: BoxDecoration(color: HexColor('#FFE7E5'), borderRadius: BorderRadius.circular(8)),
        ),
        Positioned(
          top: 20,
          left: 15,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.83,
            child: Row(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      height: 82,
                      child: InkWell(
                        onTap: () {

                        },
                        child: ClipRRect(
                          borderRadius: borderRadiuscircular(15.0),
                          child: model.userdataMap['profile_image'].toString() != "null"
                              ? Image.network(
                                  model.userdataMap['image_url'].toString(),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, exception, stackTrack) => const Center(child: Text('Not found')),
                                )
                              : const Image(image: AssetImage('assets/images/user.png'), fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    sizedboxwidth(10.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sizedboxheight(10.0),
                        Text(
                          model.userdataMap['name'].toString(),
                          style: textstyletitleHeading6(context),
                        ),
                        sizedboxheight(5.0),
                        Row(
                          children: [
                            const Icon(Icons.phone_callback_outlined),
                            sizedboxwidth(8.0),
                            Text(
                              model.userdataMap['phone_no'].toString(),
                              style: textstyletitleHeading6(context)!.copyWith(fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(),
                      ),
                    );
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: colororangeLight),
                    ),
                    child: const Center(
                      child: Image(
                        image: AssetImage(
                          'assets/icons/edit.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

// profile email widget
Widget mailWidget(BuildContext context, DashboardModelPage model) {
  return model.userdataMap['email'].toString() != 'null'
      ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: InkWell(
            child: Container(
              decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.circular(11),
                border: Border.all(
                  color: colorgreyblack.withOpacity(0.2),
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: HexColor('#FFE7E5'),
                  radius: 20,
                  child: Image(
                    image: const AssetImage(
                      'assets/icons/email.png',
                    ),
                    color: HexColor('#CD7F7F'),
                  ),
                ),
                title: Text(
                  'Email Address',
                  style: textstylesubtitle1(context)!.copyWith(fontSize: 12),
                ),
                subtitle: Text(
                  model.userdataMap['email'].toString(),
                  style: textstyletitleHeading6(context),
                  overflow: TextOverflow.ellipsis,
                ),
                // trailing: Container(
                //   width: 20,
                //   height: 20,
                //   child: Image(
                //     image: AssetImage(
                //       'assets/icons/mail1.png',
                //     ),
                //     color: HexColor('#CD7F7F'),
                //   ),
                // ),
              ),
            ),
          ),
        )
      : Container();
}

// profile birth time widget
Widget birthTimeWidget(BuildContext context, DashboardModelPage model) {
  return model.userdataMap['birth_time'].toString() != 'null'
      ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: InkWell(
            child: Container(
              decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.circular(11),
                border: Border.all(
                  color: colorgreyblack.withOpacity(0.2),
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                    backgroundColor: HexColor('#EEEEFC'),
                    radius: 20,
                    child: Icon(
                      Icons.watch_later_outlined,
                      color: HexColor('#8080D3'),
                    )),
                title: Text(
                  'Birth Time',
                  style: textstylesubtitle1(context)!.copyWith(fontSize: 12),
                ),
                subtitle: Text(
                  model.userdataMap['birth_time'].toString(),
                  style: textstyletitleHeading6(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        )
      : Container();
}

// profile mobile number widget
Widget mobileNumberWidget(BuildContext context, DashboardModelPage model) {
  return model.userdataMap['phone_no'].toString() != 'null'
      ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadius.circular(11),
              border: Border.all(
                color: colorgreyblack.withOpacity(0.2),
              ),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: HexColor('#DAF8E7'),
                radius: 20,
                child: Image(
                  image: const AssetImage(
                    'assets/icons/call.png',
                  ),
                  color: HexColor('#499F6E'),
                ),
              ),
              title: Text(
                'Mobile Number',
                style: textstylesubtitle1(context)!.copyWith(fontSize: 12),
              ),
              subtitle: Text(
                model.userdataMap['phone_no'].toString(),
                style: textstyletitleHeading6(context),
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/icons/check.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                width: 23,
                height: 22,
              ),
            ),
          ),
        )
      : Container();
}

// profile gender widget
Widget genderWidget(BuildContext context, DashboardModelPage model) {
  return model.userdataMap['gender'].toString() != 'null'
      ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: InkWell(
            child: Container(
              decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.circular(11),
                border: Border.all(
                  color: colorgreyblack.withOpacity(0.2),
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: HexColor('#FCF1DC'),
                  radius: 20,
                  child: Image(
                    image: const AssetImage(
                      'assets/icons/gender.png',
                    ),
                    color: HexColor('#C79F52'),
                  ),
                ),
                title: Text(
                  'Gender',
                  style: textstylesubtitle1(context)!.copyWith(fontSize: 12),
                ),
                subtitle: Text(
                  model.userdataMap['gender'].toString(),
                  style: textstyletitleHeading6(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        )
      : Container();
}

// profile date of birth widget
Widget dobWidget(BuildContext context, DashboardModelPage model) {
  return model.userdataMap['dob'].toString() != 'null'
      ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: InkWell(
            child: Container(
              decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.circular(11),
                border: Border.all(
                  color: colorgreyblack.withOpacity(0.2),
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: HexColor('#FDE1E2'),
                  radius: 20,
                  child: Image(
                    image: const AssetImage(
                      'assets/icons/dob.png',
                    ),
                    color: HexColor('#DB676B'),
                  ),
                ),
                title: Text(
                  'Date Of Birth',
                  style: textstylesubtitle1(context)!.copyWith(fontSize: 12),
                ),
                subtitle: Text(
                  model.userdataMap['dob'].toString(),
                  style: textstyletitleHeading6(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        )
      : Container();
}

// profile page address widget
Widget addressWidget(BuildContext context, DashboardModelPage model) {
  return model.userdataMap['birth_place'].toString() != 'null'
      ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: InkWell(
            child: Container(
              decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.circular(11),
                border: Border.all(
                  color: colorgreyblack.withOpacity(0.2),
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: HexColor('#E0F5F6'),
                  radius: 20,
                  child: Image(
                    image: const AssetImage(
                      'assets/icons/location.png',
                    ),
                    color: HexColor('#57BBBF'),
                  ),
                ),
                title: Text(
                  'Place of Birth',
                  style: textstylesubtitle1(context)!.copyWith(fontSize: 12),
                ),
                subtitle: Text(
                  model.userdataMap['birth_place'].toString(),
                  style: textstyletitleHeading6(context),
                ),
              ),
            ),
          ),
        )
      : Container();
}

Widget perMinuteWidget(BuildContext context, DashboardModelPage model) {
  return model.userdataMap['per_minute'].toString() != 'null'
      ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: InkWell(
            child: Container(
              decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.circular(11),
                border: Border.all(
                  color: colorgreyblack.withOpacity(0.2),
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: HexColor('#E0F5F6'),
                  radius: 20,
                  child: Icon(
                    Icons.access_time,
                    color: HexColor('#57BBBF'),
                  ),
                ),
                title: Text(
                  'Per minute charge',
                  style: textstylesubtitle1(context)!.copyWith(fontSize: 12),
                ),
                subtitle: Text(
                  model.userdataMap['per_minute'].toString(),
                  style: textstyletitleHeading6(context),
                ),
              ),
            ),
          ),
        )
      : Container();
}

Widget languageWidget(BuildContext context, DashboardModelPage model) {
  return model.userdataMap['user_language'].toString() != 'null'
      ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: InkWell(
            child: Container(
              decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.circular(11),
                border: Border.all(
                  color: colorgreyblack.withOpacity(0.2),
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: HexColor('#E0F5F6'),
                  radius: 20,
                  child: Icon(
                    Icons.language,
                    color: HexColor('#57BBBF'),
                  ),
                ),
                title: Text(
                  'Known languages',
                  style: textstylesubtitle1(context)!.copyWith(fontSize: 12),
                ),
                subtitle: Text(
                  model.userdataMap['user_language'].toString().replaceAll(",", ", "),
                  style: textstyletitleHeading6(context),
                ),
              ),
            ),
          ),
        )
      : Container();
}

Widget skillWidget(BuildContext context, DashboardModelPage model) {
  return model.userdataMap['user_expertise'].toString() != 'null'
      ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: InkWell(
            child: Container(
              decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.circular(11),
                border: Border.all(
                  color: colorgreyblack.withOpacity(0.2),
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: HexColor('#E0F5F6'),
                  radius: 20,
                  child: Image(
                    image: const AssetImage(
                      'assets/icons/certificate.png',
                    ),
                    width: 20,
                    height: 20,
                    color: HexColor('#57BBBF'),
                  ),
                ),
                title: Text(
                  'Expertise you have',
                  style: textstylesubtitle1(context)!.copyWith(fontSize: 12),
                ),
                subtitle: Text(
                  model.userdataMap['user_expertise'].toString().replaceAll(",", ", "),
                  style: textstyletitleHeading6(context),
                ),
              ),
            ),
          ),
        )
      : Container();
}

Widget aboutUsWidget(BuildContext context, DashboardModelPage model) {
  return model.userdataMap['user_aboutus'].toString() != 'null'
      ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: InkWell(
            child: Container(
              decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.circular(11),
                border: Border.all(
                  color: colorgreyblack.withOpacity(0.2),
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: HexColor('#E0F5F6'),
                  radius: 20,
                  child: Icon(
                    Icons.info_outline,
                    size: 20,
                    color: HexColor('#57BBBF'),
                  ),
                ),
                title: Text(
                  'About your self',
                  style: textstylesubtitle1(context)!.copyWith(fontSize: 12),
                ),
                subtitle: Text(
                  model.userdataMap['user_aboutus'],
                  style: textstyletitleHeading6(context),
                ),
              ),
            ),
          ),
        )
      : Container();
}

Widget onlineOfflineWidget(BuildContext context, DashboardModelPage model) {
  return ListTile(
    // leading: const Icon(
    //   Icons.,
    // ),
    title: Text(
      'Online / Offline',
      style: Theme.of(context).textTheme.titleLarge,
    ),
    trailing: Transform.scale(
      scale: 0.8,
      child: CupertinoSwitch(
        value: model.astrologerOnline,
        activeColor: colororangeLight,
        onChanged: (bool value) {
          model.updateAstrologerStatus(value);
        },
      ),
    ),
  );
}

Widget callActiveWidget(BuildContext context, DashboardModelPage model) {
  return ListTile(
    // leading: const Icon(
    //   Icons.call,
    // ),
    title: Text(
      'Available On Call',
      style: Theme.of(context).textTheme.titleLarge,
    ),
    trailing: Transform.scale(
      scale: 0.8,
      child: CupertinoSwitch(
        value: model.astrologerCall,
        activeColor: colororangeLight,
        onChanged: (value) {
          model.updateAstrologerCallStatus(value);
        },
      ),
    ),
  );
}

Widget chatActiveWidget(BuildContext context, DashboardModelPage model) {
  return ListTile(
    // leading: const Icon(
    //   Icons.chat_outlined,
    // ),
    title: Text(
      'Available On Chat',
      style: Theme.of(context).textTheme.titleLarge,
    ),
    trailing: Transform.scale(
      scale: 0.8,
      child: CupertinoSwitch(
        value: model.astrologerChat,
        activeColor: colororangeLight,
        onChanged: (value) {
          model.updateAstrologerChatStatus(value);
        },
      ),
    ),
  );
}

Widget setAvailabilityWidget(BuildContext context, DashboardModelPage model) {
  return ListTile(
    title: Text(
      'Free Availability',
      style: Theme.of(context).textTheme.titleLarge,
    ),
    trailing: Transform.scale(
      scale: 0.8,
      child: CupertinoSwitch(
        value: model.isSetAvailability,
        activeColor: colororangeLight,
        onChanged: (value) {
          model.isSetAvailabilityStatus(value);
        },
      ),
    ),
  );
}


Widget freeAvailabilityDropDownWidget(BuildContext context, DashboardModelPage dashBoardModel) {
  return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: deviceWidth(context, 0.9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.transparent,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            focusColor: Colors.white,
            value: dashBoardModel.availability,
            style: const TextStyle(color: Colors.white),
            iconEnabledColor: Colors.black,
            items: dashBoardModel.freeAvailability.map<DropdownMenuItem<String>>((String valueGender) {
              return DropdownMenuItem<String>(
                value: valueGender,
                child: Text(
                  valueGender,
                  overflow: TextOverflow.ellipsis,
                  style: textstyletitleHeading6(context),
                ),
              );
            }).toList(),
            hint:  Text("Set Availability",
              style: textstyletitleHeading6(context),
            ),
            onChanged: (String? value) {
              debugPrint(value);
              dashBoardModel.updateAvailability(value);
            },
          ),
        ),
      );
}


