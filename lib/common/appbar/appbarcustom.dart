import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';
import 'appbarCustomWidget.dart';

class AppBarCustom extends StatefulWidget {
  final leading;
  final Widget? action0;
  final Widget? action1;
  final Widget? action2;
  final Widget? action3;
  final Widget? action4;
  final title;

  AppBarCustom({
    Key? key,
    this.leading,
    this.action0,
    this.action1,
    this.action2,
    this.action3,
    this.action4,
    this.title,
  }) : super(key: key);

  @override
  _AppBarCustomState createState() => _AppBarCustomState();
}

class _AppBarCustomState extends State<AppBarCustom> {
  List appicon = [];

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: (widget.title == 'ACCOUNT SETTING' ||
              widget.title == 'CHAT' ||
              // widget.title == 'PLAN' ||
              /* widget.title == 'NOTIFICATION' ||*/
              widget.title == '' ||
              widget.title == 'MY PROFILE' ||
              // widget.title == 'Edit PROFILE' ||
              widget.title == 'SETTING')
          ? 55
          : 36,
      toolbarHeight: widget.title == null ||
              widget.title == 'Edit PROFILE' ||
              widget.title == 'NOTIFICATION' ||
              widget.title == 'PLAN' ||
              widget.title == 'MY WALLET'
          ? 36
          : 55,
      leading: (widget.title == 'ACCOUNT SETTING' ||
              // widget.title == 'PLAN' ||
              widget.title == 'CHAT' ||
              /* widget.title == 'NOTIFICATION' ||*/
              widget.title == '' ||
              widget.title == 'MY PROFILE' ||
              // widget.title == 'Edit PROFILE' ||
              widget.title == 'SETTING')
          ? drawerLeading(context)
          : backButtonLeading(context),
      title: Text(
        widget.title != null ? widget.title : '',
        style: textstyletitleHeading6(context)!.copyWith(
            color: widget.title == 'REFER A FRIEND' || widget.title == 'PLAN'
                ? colorblack
                : colorWhite,
            fontWeight: fontWeight900,
            // letterSpacing: 1,
            fontSize: 19),
      ),
      centerTitle: true,
      actions: [
        if (widget.title == 'CHAT')
          Row(
            children: [
              //notificationWidget(context),
              sizedboxwidth(5.0),
              // userporifilePic()
            ],
          )
        else if (widget.title == 'MY PROFILE' ||
            widget.title == 'Edit PROFILE' ||
            widget.title == 'SETTING' ||
            widget.title == 'PLAN' ||
            widget.title == 'ACCOUNT SETTING' ||
            widget.title == 'PREMIUM SERVICES' ||
            // widget.title == 'NOTIFICATION' ||
            widget.title == '')
          Container()
          // notificationactionWidget(context)
        else
          Row(
            children: [
              // videocallAction(),
              // sizedboxwidth(5.0),
              // audiocallAction()
            ],
          )
      ],
    );
  }
}
