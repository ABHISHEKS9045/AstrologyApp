import 'package:astrologyapp/chat/chatlist/chatlistmodelpage.dart';
import 'package:flutter/Material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../common/appbar/chatpageAppbar.dart';
import '../../common/commonwidgets/commonWidget.dart';
import '../../common/shimmereffect.dart';
import '../../common/styles/const.dart';
import '../../login Page/loginpageWidget.dart';
import 'package:astrologyapp/my%20wallet/mywalletpage.dart';

class CustomerWaitListScreen extends StatefulWidget {
  final String astroId;
  final bool isCall;
  final int perMinute;
  final String astroName;

  CustomerWaitListScreen({super.key, required this.astroId, required this.isCall, required this.perMinute, required this.astroName});

  @override
  State<CustomerWaitListScreen> createState() => _CustomerWaitListScreenState();
}

class _CustomerWaitListScreenState extends State<CustomerWaitListScreen> {
  static const String TAG = "_CustomerWaitListScreenState";
  String userId = "";

  @override
  void initState() {
    getUserType();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var model = Provider.of<Chatlistmodelpage>(context, listen: false);
      model.getWalletBalance(context);
      model.getWaitCustomersList(context: context, type: "", astroId: widget.astroId);
    });
  }

  Future<void> getUserType() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userId = pref.getString('login_user_id').toString();
      debugPrint("$TAG userId ========> $userId");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Chatlistmodelpage>(builder: (context, model, child) {
      return Scaffold(
        body: Stack(
          children: [
            bgImagecommon(context),
            SingleChildScrollView(
              child: Column(
                children: [
                  sizedboxheight(40.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: appbarbackbtnnotification(context, "WAIT LIST"),
                  ),
                 // sizedboxheight(40.0),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: deviceWidth(context, 1.0),
                    height: deviceheight(context, 0.82),
                    decoration: decorationtoprounded(),
                    child: model.isShimmer
                        ? Container(
                            margin: EdgeInsets.only(top: 20.h),
                            child: loadingwidget(),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (model.walletAmount < (widget.perMinute * 5)) {
                                    Future.delayed(Duration(milliseconds: 100), () {
                                      showBottomSheetPopUp(context, widget.perMinute, widget.astroName);
                                    });
                                  } else {
                                    String type = "";
                                    if (widget.isCall) {
                                      type = "Call";
                                    } else {
                                      type = "Chat";
                                    }
                                    await model.addUserToAstrologerWaitList(astroId: int.parse(widget.astroId), type: type);

                                    Future.delayed(
                                      const Duration(milliseconds: 1000),
                                      () async {
                                        await model.getWaitCustomersList(context: context, type: "", astroId: widget.astroId);
                                      },
                                    );
                                  }
                                },
                                child: Container(
                                  height: 45,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: colororangeLight,
                                  ),
                                  child: const Text(
                                    "Join wait list",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: model.waitListForAstrologer.isNotEmpty
                                    ? showOnlyCurrentUserData(model.waitListForAstrologer)
                                    : const Expanded(
                                        child: Center(
                                          child: Text(
                                            "No data available",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  bool findId(List astroList) {
    bool status = false;
    if (astroList.isNotEmpty) {
      for (int i = 0; i < astroList.length; i++) {
        if (astroList[i]['user_id'].toString() == userId) {
          debugPrint("$TAG user id matched");
          status = true;
          break;
        }
      }
    }
    debugPrint("$TAG status value =========> $status");
    return status;
  }

  findUserData(List astroList, String userId) => astroList.where((element) => element["user_id"].toString() == userId).toList();

  Widget showOnlyCurrentUserData(List astroList) {
    int? count;
    if (astroList.isNotEmpty) {
      for (int i = 0; i < astroList.length; i++) {
        if (astroList[i]["user_id"].toString() == userId) {
          count = i;
          debugPrint("$TAG count in loop ========> $count");
          break;
        }
      }

      dynamic data;
      debugPrint("$TAG count ========> $count");
      debugPrint("$TAG selected userData ========> ${findUserData(astroList, userId)}");
      if (findUserData(astroList, userId).length > 0) {
        data = findUserData(astroList, userId)[0];
      }
      debugPrint("$TAG data =======> $data");
      if (count != null && data != null) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //const SizedBox(height: 10),
            Center(
              child: Text(
                "Hi, ${data["name"]}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Your request for "${data["user_type"]}" is registered',
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Here's your position in queue",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
           // const SizedBox(height: 20),
            Center(
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: colororangeLight,
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "${count + 1}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 36,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Center(
                      child: Text(
                        "Position",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "We'll text you when we're almost ready to see you.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Center(
              child: Text(
                "Hi, there",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Your request is not registered for wait list yet.',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Your position will be",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: colororangeLight,
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "${astroList.length + 1}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 36,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Center(
                      child: Text(
                        "Position",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Please click "Join wait list" to join',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      }
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Center(
            child: Text(
              "Hi, there",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Your request is not registered for wait list yet.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              "Your position will be",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Container(
              alignment: Alignment.center,
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: colororangeLight,
                shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "${astroList.length + 1}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 36,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Center(
                    child: Text(
                      "Position",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Please click "Join wait list" to join',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ],
      );
    }
  }

  void showBottomSheetPopUp(BuildContext context, int perMinute, String astroName) {
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
                      "Minimum balance of 5 minutes (₹ $perMinute / min.) is required to start chat/call with $astroName",
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
