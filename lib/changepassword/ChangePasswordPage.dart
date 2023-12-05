import 'package:astrologyapp/common/commonwidgets/toast.dart';
import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/appbar/chatpageAppbar.dart';
import '../common/commonwidgets/button.dart';
import '../common/commonwidgets/commonWidget.dart';
import '../common/formtextfield/myTextField.dart';
import '../common/styles/const.dart';
import '../forgetpass/password change page3/changepassmodelpage.dart';
import '../login Page/loginpageWidget.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String TAG = "_ChangePasswordPageState";

  String? userId;

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  Future<void> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString("login_user_id");
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            bgImagecommon(context),
            Consumer<ChangePassModelPage>(builder: (context, model, _) {
              return SafeArea(
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: appbarbackbtnnotification(
                          context,
                          'RESET PASSWORD',
                        ),
                      ),

                      sizedboxheight(
                        deviceheight(context, 0.05),
                      ),
                      Container(
                        padding: const EdgeInsets.all(padding20),
                        width: deviceWidth(context, 1.0),
                        decoration: decorationtoprounded(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            titleTextWidget(context),
                            sizedboxheight(32.0),
                            newPasswordWidget(model),
                            sizedboxheight(25.0),
                            confirmPasswordWidget(model),
                            sizedboxheight(50.0),
                            saveBtn(context, model, userId),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget titleTextWidget(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedboxheight(10.0),
        Text("Reset Password", style: textstyleHeading2(context)),
        sizedboxheight(20.0),
      ],
    );
  }

  Widget newPasswordWidget(ChangePassModelPage model) {
    return AllInputDesign(
      inputHeaderName: 'New Password',
      obsecureText: model.obscuretext1,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: colorWhite,
      hintText: 'New Password',
      textInputAction: TextInputAction.next,
      controller: model.newPassword,
      enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
      focusedBorderColor: colororangeLight,
      maxLines: 1,
      prefixIcon: const Image(
        image: AssetImage(
          'assets/icons/Lock.png',
        ),
      ),
      suffixIcon: GestureDetector(
        child: const Icon(
          Icons.visibility,
          size: 20.0,
        ),
        onTap: () {
          model.toggle1();
        },
      ),
      keyBoardType: TextInputType.text,
    );
  }

  Widget confirmPasswordWidget(ChangePassModelPage model) {
    return AllInputDesign(
      inputHeaderName: 'Confirm Password',
      obsecureText: model.obscuretext2,
      fillColor: colorWhite,
      hintText: 'Confirm Password',
      floatingLabelBehavior: FloatingLabelBehavior.never,
      textInputAction: TextInputAction.done,
      controller: model.confirmPassword,
      enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
      focusedBorderColor: colororangeLight,
      maxLines: 1,
      prefixIcon: const Image(
        image: AssetImage(
          'assets/icons/Lock.png',
        ),
      ),
      suffixIcon: GestureDetector(
        child: const Icon(
          Icons.visibility,
          size: 20.0,
        ),
        onTap: () {
          model.toggle2();
        },
      ),
      keyBoardType: TextInputType.text,
    );
  }

  Widget saveBtn(BuildContext context, ChangePassModelPage model, String? userid) {
    return Button(
      btnWidth: deviceWidth(context, 1.0),
      btnHeight: 45,
      buttonName: 'SAVE',
      borderRadius: BorderRadius.circular(15.0),
      btnColor: colororangeLight,
      onPressed: () {
        if (model.newPassword.text.toString().trim().isEmpty) {
          Constants.showToast("Please provide new password");
        } else if (model.newPassword.text.toString().trim().length < 6 && model.newPassword.text.toString().trim().length > 12) {
          Constants.showToast("Password length is 6 to 12 characters");
        } else if (model.confirmPassword.text.toString().trim().isEmpty) {
          Constants.showToast("Please provide confirm password");
        } else if (model.confirmPassword.text.toString().trim().length < 6 && model.confirmPassword.text.toString().trim().length > 12) {
          Constants.showToast("Password length is 6 to 12 characters");
        } else if (model.newPassword.text.toString().trim() != model.confirmPassword.text.toString().trim()) {
          Constants.showToast("Password does not matched");
        } else {
          model.changepasswordsubmit(context, userid!);
        }
      },
    );
  }
}
