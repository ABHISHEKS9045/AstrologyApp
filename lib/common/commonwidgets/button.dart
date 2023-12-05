import 'dart:ui';

import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String? buttonName;
  final Key? key;
  final borderRadius;
  final double? btnWidth;
  final double? btnHeight;
  final Color? color;
  final Color? btnColor;
  final Color? btnColorGradientUp;
  final Color? btnColorGradientdown;
  final Color? borderColor;
  final Color? textColor;
  final String? imageAsset;
  final double? elevation;

  Button({
    this.buttonName,
    required this.onPressed,
    this.borderRadius,
    this.btnWidth,
    this.btnHeight,
    this.btnColor,
    this.btnColorGradientUp,
    this.btnColorGradientdown,
    this.borderColor,
    this.textColor,
    this.key,
    this.color,
    this.imageAsset,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    

    var screenSize = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Container(
        height: btnHeight ?? 43.0,
        width: btnWidth ?? screenSize,
        decoration: BoxDecoration(
          gradient:  LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [HexColor('#F9921F'), HexColor('#F9921F')]),
          color: btnColor ?? Colors.transparent,
          borderRadius: borderRadius ?? BorderRadius.circular(7.0),
        ),
        child: MaterialButton(
        splashColor: Colors.black,
        // animationDuration: Duration(seconds: 10),
        hoverColor: Colors.black26,
       
        
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(7.0),
            side: BorderSide(color: borderColor ?? Colors.transparent),
          ),
          key: key,
          elevation: elevation ?? 3,
          color: color,
          onPressed: onPressed,
          child: imageAsset != null && buttonName != null
              ? Material(
                child: Row(
                    children: [
                      Image.asset(
                        imageAsset!,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        buttonName!,
                        style: TextStyle(
                          inherit: true,
                          color: textColor ?? Colors.white,
                          fontFamily: 'Nunito',
                          fontWeight: fontWeight400,
                          fontSize: screenSize <= 350 ? 18.0 : 20.0,
                          letterSpacing: 0.3,
                        ),
                      )
                    ],
                  ),
              )
              : buttonName != null
                  ? Text(
                      buttonName!,
                      style: TextStyle(
                        inherit: true,
                        color: textColor ?? Colors.white,
                        fontFamily: 'Nunito',
                        fontWeight: fontWeight400,
                        fontSize: screenSize <= 350 ? 18.0 : 20.0,
                        letterSpacing: 0.3,
                      ),
                    )
                  : imageAsset != null
                      ? Image.asset(
                          imageAsset!,
                          fit: BoxFit.cover,
                        )
                      : MaterialButton(onPressed: () {}),
        ),
      ),
    );
  }
}
