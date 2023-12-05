import 'package:astrologyapp/common/formtextfield/myTextField.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/help&support/SupportProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/Material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../common/commonwidgets/button.dart';
import 'RaiseQueryPage.dart';

Widget loadSupportTicketsData(BuildContext context, SupportProvider model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Text(
        "Your Queries",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      model.ticketList.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: deviceheight(context, 0.6),
                  child: Center(
                    child: Text(
                      'No Data Found',
                      style: textstyleHeading3(context),
                    ),
                  ),
                ),
              ],
            )
          :
      Container(
       height: deviceheight(context, 0.60),
       width: deviceWidth(context, 1.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          // physics: const BouncingScrollPhysics(),
          // shrinkWrap: true,
          itemCount: model.ticketList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10, top: 10),
              padding: const EdgeInsets.all(10.0),
              width: deviceWidth(context, 1.0),
              decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.circular(15),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ticket Id: ${model.ticketList[index]['ticketId'].toString()}",
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: HexColor('#000000'),
                    ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Text(
                    "Request amount: ₹ ${model.ticketList[index]['amount'].toString()}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Approve amount: ₹ ${model.ticketList[index]['approve_amt'].toString()}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Date: ${model.ticketList[index]['date'].toString()}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Status: ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: HexColor('#000000'),
                        ),
                      ),
                      Text(
                        checkStatus(model.ticketList[index]['status']),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: checkStatusColor(model.ticketList[index]['status']),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}

String checkStatus(var status) {
  if (status == 1) {
    return "DONE";
  } else if (status == 2) {
    return "REJECTED";
  } else if (status == 3) {
    return "On Hold";
  } else {
    return "Progress";
  }
}

Color checkStatusColor(var status) {
  if (status == 1) {
    return Colors.green;
  } else if (status == 2) {
    return Colors.red;
  } else if (status == 3) {
    return Colors.lime;
  } else {
    return colororangeLight;
  }
}

Widget raiseQuery(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only( left: 20, right: 20, bottom: 10),
    child: Button(
      btnWidth: deviceWidth(context, 1.0),
      btnHeight: 45,
      buttonName: 'Raise a Query',
      borderRadius: BorderRadius.circular(13.0),
      btnColor: colororangeLight,
      onPressed: () async {
        Get.to(() => const RaiseQueryPage(
              requestType: 'query',
            ));
      },
    ),
  );
}

Widget queryDropdownWidget(String heading, SupportProvider model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        heading,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        items: model.queryTypeList
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: colorblack,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (String? value) {
          if (value != null) {
            if (value == model.queryTypeList[0]) {
              model.updateSelectedType("1");
            } else if (value == model.queryTypeList[1]) {
              model.updateSelectedType("2");
            } else {
              model.updateSelectedType("3");
            }
          }
        },
        onSaved: (value) {},
      ),
    ],
  );
}

Widget writeQueryBoxWidget(String heading, SupportProvider model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        heading,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      sizedboxheight(10.0),
      AllInputDesign(
        controller: model.controller,
        hintText: 'Message',
        textInputAction: TextInputAction.done,
        enabledOutlineInputBorderColor: colororangeLight.withOpacity(0.6),
        focusedBorderColor: colororangeLight,
        minLines: 7,
        maxLines: 7,
        keyBoardType: TextInputType.multiline,
        maxLength: 1500,
      ),
    ],
  );
}

Widget submitButton(BuildContext context, SupportProvider model, String type, String requestType, String? amount, String? requestId) {
  return Container(
    margin: const EdgeInsets.only(top: 10, bottom: 10),
    child: Button(
      btnWidth: deviceWidth(context, 1.0),
      btnHeight: 45,
      buttonName: 'Submit Query',
      borderRadius: BorderRadius.circular(15.0),
      btnColor: colororangeLight,
      onPressed: () async {
        if (type == "") {
          Fluttertoast.showToast(msg: "Please select query type");
        } else if (model.controller.text.toString().trim().isEmpty) {
          Fluttertoast.showToast(msg: "Please write your query");
        } else {
          model.sendQueryToServer(context, type, model.controller.text.toString().trim(), requestType, requestId, amount);
        }
      },
    ),
  );
}

Widget showAstrologerInfo(BuildContext context, SupportProvider model) {
  return model.refundQueryData != null
      ? Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipOval(
              child: SizedBox(
                height: 60,
                width: 60,
                child: CachedNetworkImage(
                  imageUrl: model.refundQueryData["image_url"],
                  errorWidget: (context, url, error) {
                    return const Image(
                      image: AssetImage(
                        'assets/images/1.jpg',
                      ),
                      fit: BoxFit.cover,
                    );
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              model.refundQueryData["astro_name"],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            sizedboxheight(10.0),
          ],
        )
      : Container();
}

Widget showRefundAmountWidget(BuildContext context, SupportProvider model, var amount) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        "Amount to be refunded ₹ $amount",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      sizedboxheight(10.0),
      AllInputDesign(
        controller: model.controller,
        hintText: 'Message',
        textInputAction: TextInputAction.done,
        enabledOutlineInputBorderColor: colororangeLight.withOpacity(0.6),
        focusedBorderColor: colororangeLight,
        minLines: 7,
        maxLines: 7,
        keyBoardType: TextInputType.multiline,
        maxLength: 1500,
      ),
    ],
  );
}
