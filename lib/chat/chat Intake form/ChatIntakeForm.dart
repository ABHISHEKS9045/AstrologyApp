
import 'dart:async';

import 'package:astrologyapp/common/bottomnavbar/bottomnavbar.dart';
import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../common/commonwidgets/button.dart';
import '../../common/shimmereffect.dart';
import '../../my wallet/mywalletpage.dart';
import '../chatlist/chatlistmodelpage.dart';

class ChatIntakeForm extends StatefulWidget {
  final int chatTime;
  final isForHistory;
  final perMinute;
  final name;
  final image;
  final astroid;
  final bool isFree;
  final sender_id;

  const ChatIntakeForm({super.key, required this.chatTime, this.sender_id, this.isForHistory, required this.perMinute, required this.name, required this.image, required this.astroid, required this.isFree});

  @override
  State<ChatIntakeForm> createState() => _ChatIntakeFormState();
}

class _ChatIntakeFormState extends State<ChatIntakeForm> {
  String TAG = "_ChatIntakeFormState";

  final formKey = GlobalKey<FormState>();

  TextEditingController phoneCont = TextEditingController();

  List<String> maritalStatus = ['Single', 'Married', 'Divorce']; // Option 2
  List<String> occupation = ['Private', 'Business', 'Government', "Other"]; // Option 2
  List<String> concernTopic = ['Marriage', 'Business', 'Job', "Education", 'Exam', 'Home', "Personal", 'career', "Other"]; // Option 2
  String _selectedLocation = ''; // Option 2

  int? _radioValue = 0;
  String gender = '';
  String concernValue = '';
  String maritalStatusValu = '';
  String occupationValue = '';

  Timer? _timer;
  var _start = 0.obs;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            if (timerboolValue == true) {
              if (mounted) {
                debugPrint("$TAG startTimer() redirect to home page");
                Provider.of<Chatlistmodelpage>(
                  context,
                  listen: false,
                ).rejectChatRequest(context, widget.astroid);
                Get.offUntil(
                  MaterialPageRoute(
                    builder: (context) {
                      return const BottomNavBarPage();
                    },
                  ),
                  (route) {
                    return false;
                  },
                );
              }
            }
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
      }
    });

    if (_radioValue == 0) {
      gender = 'Male';
    } else {
      gender = 'Female';
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(const Duration(seconds: 1));
      var chatModel = Provider.of<Chatlistmodelpage>(context, listen: false);
      chatModel.getWalletBalance(context);
      chatModel.profileView(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("$TAG on dispose called");
    _timer?.cancel();
  }

  @override
  void deactivate() {
    super.deactivate();
    debugPrint("$TAG on deactivate called");
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Chatlistmodelpage>(builder: (context, model, _) {
      return Scaffold(
        body: model.userdataMap['name'] == null
            ? Center(
                child: loadingwidget(),
              )
            : Stack(
                children: [
                  bgImagecommon(context),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        sizedboxheight(20.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: appbarbackbtnnotification1(context, "Chat Intake Form"),
                        ),
                        Container(
                          padding: const EdgeInsets.all(padding20),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 160,
                          decoration: decorationtoprounded(),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Please Fill',
                                  style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                sizedboxheight(25.0),
                                formWidget("Name*", model.userdataMap['name'] ?? "Name", model.nameCont, false),
                                sizedboxheight(17.0),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Phone No.*',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(top: 20),
                                            height: 30,
                                            child: const Image(
                                              image: AssetImage('assets/icons/002-india.png'),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                                            child: const Text(
                                              "IN +91",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: TextField(
                                              controller: phoneCont,
                                              cursorColor: Colors.black,
                                              decoration: InputDecoration(
                                                hintText: model.userdataMap['phone_no'] ?? "Phone No.",
                                                focusedBorder: const UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.orange),
                                                ),
                                                enabledBorder: const UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.orange),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                sizedboxheight(17.0),
                                Row(
                                  children: [
                                    const Text(
                                      'Gender*',
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          activeColor: Colors.orange,
                                          value: 0,
                                          groupValue: _radioValue,
                                          onChanged: _handleRadioValueChange,
                                        ),
                                        const Text(
                                          'MALE',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          activeColor: Colors.orange,
                                          value: 1,
                                          groupValue: _radioValue,
                                          onChanged: _handleRadioValueChange,
                                        ),
                                        const Text(
                                          'FEMALE',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                sizedboxheight(17.0),
                                InkWell(
                                  onTap: () {
                                    model.selectDate(context);
                                  },
                                  child: formWidget("Date Of Birth*", model.userdataMap['dob'] ?? "dd-mm-yyyy", model.dobCont, true),
                                ),
                                sizedboxheight(17.0),
                                InkWell(
                                  onTap: () {
                                    model.selectTime(context);
                                  },
                                  child: formWidget("Time Of Birth*", model.userdataMap['birth_time'] ?? "Time of Birth", model.timeCont, true),
                                ),
                                sizedboxheight(17.0),
                                formWidget("Place Of Birth*", model.userdataMap['birth_place'] ?? "Time of Birth", model.placeCont, false),
                                sizedboxheight(17.0),
                                FormDropdownWidget("Marital Status", maritalStatus, maritalStatusValu, 1),
                                sizedboxheight(17.0),
                                FormDropdownWidget("Occupation", occupation, occupationValue, 2),
                                sizedboxheight(17.0),
                                FormDropdownWidget("Topic of Concern", concernTopic, concernValue, 3)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
        bottomSheet: startChatBtn(context, () async {
          final model1 = Provider.of<Chatlistmodelpage>(context, listen: false);
          await model1.getWalletBalance(context);

          if(widget.isFree) {
            _start.value = 60;
            timerboolValue = true;
            startTimer();
            if (context.mounted) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return _buildPopupDialog(context, model);
                  });
                },
              );
            }
            String name = model.userdataMap['name'];
            String dob = model.userdataMap['dob'];
            String birthTime = model.userdataMap['birth_time'];
            String birthPlace = model.userdataMap['birth_place'];

            String initialMessage = "Name: $name\nDOB: $dob\nBirth Time: $birthTime\nBirth Place: $birthPlace\nMartial Status: $maritalStatusValu\nOccupation: $occupationValue\nconcern: $concernValue";

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('initial_message', initialMessage);
            if (context.mounted) {
              model.callChatInitApi(context, widget.chatTime, widget.perMinute, widget.astroid, 1);
            }
          } else if (model1.walletAmount >= (int.parse(widget.perMinute.toString()) * 5)) {
            _start.value = 60;
            timerboolValue = true;
            startTimer();
            if (context.mounted) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return _buildPopupDialog(context, model);
                  });
                },
              );
            }
            String name = model.userdataMap['name'];
            String dob = model.userdataMap['dob'];
            String birthTime = model.userdataMap['birth_time'];
            String birthPlace = model.userdataMap['birth_place'];

            String initialMessage = "Name: $name\nDOB: $dob\nBirth Time: $birthTime\nBirth Place: $birthPlace\nMartial Status: $maritalStatusValu\nOccupation: $occupationValue\nconcern: $concernValue";

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('initial_message', initialMessage);
            if (context.mounted) {
              model.callChatInitApi(context, widget.chatTime, widget.perMinute, widget.astroid, 0);
            }
          } else {
            if (context.mounted) {
              showBottomSheetPopUp(context);
            }
          }
        }),
      );
    });
  }

  Widget _buildPopupDialog(BuildContext context, model) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              // onPressed: () {
              //   if (context.mounted) {
              //     Get.offUntil(
              //       MaterialPageRoute(
              //         builder: (context) {
              //           return BottomNavBarPage();
              //         },
              //       ),
              //       (route) {
              //         return false;
              //       },
              //     );
              //   }
              // },
              onPressed: () {
                model.rejectChatRequest(context, widget.astroid);
              },
              icon: const Icon(
                Icons.clear,
              ),
            ),
          ),
          const Center(
            child: Text(
              "You are all set",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      // image: DecorationImage(image: AssetImage('assets/images/user_pic.jpeg')),
                    ),
                    child: Image.network(
                      '$imageURL${model.userdataMap['image_url']}',
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/user.png',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 23.w,
                    child: Text(
                      model.userdataMap != null ? model.userdataMap['name'] : "Name",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: 45,
                width: 90,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/icons/connecting.gif',
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          '$imageURL${widget.image}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 18.w,
                    child: Text(
                      widget.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          sizedboxheight(15.0),
          Obx(() => RichText(
                text: TextSpan(
                    text: 'You will be connecting with ${widget.name} in ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '$_start',
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ]),
              )),
          sizedboxheight(20.0),
          Text(
            "While you wait for ${widget.name} you may also explore other astrologer and join their wait list",
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        okBtn(context, () {
          Fluttertoast.showToast(msg: "if in case astrologer will be not available for or unable to accept your request until your request will be automatically closed after 1 minute.");
        }),
        sizedboxheight(12.0)
      ],
    );
  }

  Widget startChatBtn(BuildContext context, ontap) {
    return Button(
      btnWidth: deviceWidth(context, 1.0),
      btnHeight: 55,
      buttonName: 'Start Chat With ${widget.name}',
      key: const Key('chat'),
      borderRadius: BorderRadius.circular(0.0),
      btnColor: colororangeLight,
      onPressed: ontap,
    );
  }

  Widget okBtn(BuildContext context, ontap) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Button(
        btnWidth: deviceWidth(context, 1.0),
        btnHeight: 40,
        buttonName: 'Waiting...',
        key: const Key('ok'),
        borderRadius: BorderRadius.circular(8.0),
        btnColor: Colors.green,
        onPressed: ontap,
      ),
    );
  }

  Widget cancelBtn(BuildContext context, ontap) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Button(
        btnWidth: deviceWidth(context, 1.0),
        btnHeight: 40,
        buttonName: 'Close',
        key: const Key('Close'),
        borderRadius: BorderRadius.circular(8.0),
        btnColor: Colors.green,
        onPressed: ontap,
      ),
    );
  }

  Widget formWidget(String heading, String hint, TextEditingController controller, bool isDisable) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          heading.toString(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        TextField(
          controller: controller,
          cursorColor: Colors.black,
          enabled: !isDisable,
          decoration: InputDecoration(
            hintText: hint.toString(),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.orange,
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.orange,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget FormDropdownWidget(String heading, List<String> list, selectedValue, type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          heading,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        DropdownButtonFormField2(
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
            ),
            iconSize: 30,
          ),
          buttonStyleData: const ButtonStyleData(
            height: 60,
            elevation: 2,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.orange,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.orange,
              ),
            ),
          ),
          isExpanded: true,
          hint: Text(
            heading,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          items: list
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colorblack,
                    ),
                  ),
                ),
              )
              .toList(),
          validator: (value) {},
          onChanged: (value) {
            if (type == 1) {
              maritalStatusValu = value.toString();
            } else if (type == 2) {
              occupationValue = value.toString();
            } else {
              concernValue = value.toString();
            }
            setState(() {
              selectedValue = value.toString();
            });
          },
          onSaved: (value) {},
        ),
      ],
    );
  }

  Widget appbarbackbtnnotification1(context, title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 18),
      width: deviceWidth(context, 1.0),
      height: 70,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 80),
            child: backbtnleading1(context),
          ),
          Text(
            title,
            style: textstyletitleHeading6(context)!.copyWith(
              color: colorWhite,
              fontWeight: fontWeight900,
              letterSpacing: 1,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget backbtnleading1(context) {
    return Container(
      width: 34,
      height: 32,
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
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: colorblack,
              size: 17,
            ),
          ),
        ),
      ),
    );
  }

  void showBottomSheetPopUp(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 70.w,
                    child: Text(
                      "Minimum balance of 5 minutes (₹ ${widget.perMinute} / min.) is required to start chat/call with ${widget.name}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Container(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: const Text(
                'Select Amount',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              height: 0.5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: const Text(
                'Tip: 90% users choose for 100 rupees or more',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyWalletPage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      height: 5.h,
                      width: 20.w,
                      alignment: Alignment.center,
                      child: const Text(
                        '₹ 20',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      height: 5.h,
                      width: 20.w,
                      alignment: Alignment.center,
                      child: const Text(
                        '₹ 50',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      height: 5.h,
                      width: 20.w,
                      alignment: Alignment.center,
                      child: const Text(
                        '₹ 100',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      height: 5.h,
                      width: 20.w,
                      alignment: Alignment.center,
                      child: const Text(
                        '₹ 200',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 2.h,
            ),
          ],
        );
      },
    );
  }
}
