import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/login%20Page/loginpageWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'changepassmodelpage.dart';
import 'changepasswidgetpage.dart';

class ChangePassPage extends StatelessWidget {

  final userid;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ChangePassPage({Key? key, this.userid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            bgImagecommon(context),
            Consumer<ChangePassModelPage>(builder: (context, model, _) {
              return Form(
                key: _formKey,
                child: SafeArea(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        sizedboxheight(
                          deviceheight(context, 0.12),
                        ),
                        sizedboxheight(
                          deviceheight(context, 0.03),
                        ),
                        Container(
                          padding: const EdgeInsets.all(padding20),
                          width: deviceWidth(context, 1.0),
                          decoration: decorationtoprounded(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              otptextpasswidget(context),
                              sizedboxheight(32.0),
                              newPasswordwidget(model),
                              sizedboxheight(25.0),
                              confirmPasswordwidget(model),
                              sizedboxheight(30.0),
                              newpasssavebtn(context, model, _formKey, userid),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
