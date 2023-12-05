import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common_function.dart';

class AllInputDesign extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final controller;
  final floatingLabelBehavior;
  final prefixText;
  final fillColor;
  final enabled;
  final initialValue;
  final hintText;
  final labelText;
  final textInputAction;
  final prefixStyle;
  final validator;
  final errorText;
  final keyBoardType;
  final validatorFieldValue;
  final List<TextInputFormatter>? inputFormatterData;
  final FormFieldSetter<String>? onSaved;
  final obsecureText;
  final suffixIcon;
  final prefixIcon;
  final maxLength;
  final outlineInputBorderColor;
  final outlineInputBorder;
  final enabledBorderRadius;
  final focusedBorderRadius;
  final enabledOutlineInputBorderColor;
  final focusedBorderColor;
  final hintTextStyleColor;
  final counterText;
  final cursorColor;
  final textStyleColors;
  final inputHeaderName;
  final autofillHints;
  final onEditingComplete;
  final textCapitalization;
  final maxLines;
  final minLines;

  const AllInputDesign(
      {Key? key,
      this.textStyleColors,
      this.controller,
      this.floatingLabelBehavior,
      this.initialValue,
      this.cursorColor,
      this.prefixIcon,
      this.textInputAction,
      this.outlineInputBorder,
      this.enabledBorderRadius,
      this.focusedBorderRadius,
      this.enabled,
      this.prefixText,
      this.fillColor,
      this.prefixStyle,
      this.keyBoardType,
      this.obsecureText,
      this.suffixIcon,
      this.hintText,
      this.labelText,
      this.validatorFieldValue,
      this.inputFormatterData,
      this.validator,
      this.onSaved,
      this.errorText,
      this.onChanged,
      this.maxLength,
      this.maxLines,
      this.minLines,
      this.outlineInputBorderColor,
      this.enabledOutlineInputBorderColor,
      this.focusedBorderColor,
      this.hintTextStyleColor,
      this.counterText,
      this.inputHeaderName,
      this.onEditingComplete,
      this.autofillHints,
      this.textCapitalization})
      : super(key: key);

  @override
  _AllInputDesignState createState() => _AllInputDesignState();
}

class _AllInputDesignState extends State<AllInputDesign> {
  var cf = CommonFunctions();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.inputHeaderName != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (widget.inputHeaderName != null) ? widget.inputHeaderName : '',
                    style: textstyletitleHeading6(context),
                  ),
                  sizedboxheight(7.0),
                  myTextfieldWidget(context),
                ],
              )
            : myTextfieldWidget(context),
      ],
    );
  }

  TextFormField myTextfieldWidget(BuildContext context) {
    double screensize = MediaQuery.of(context).size.width;
    return TextFormField(
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      cursorColor: widget.cursorColor ?? colorblack,
      key: Key(cf.convertKey(widget.labelText)),
      onSaved: widget.onSaved,
      onEditingComplete: widget.onEditingComplete,
      style: TextStyle(
        color: widget.textStyleColors ?? colorblack,
        fontWeight: FontWeight.w500,
        fontSize: screensize <= 350 ? 16 : 18,
      ),
      keyboardType: widget.keyBoardType,
      validator: widget.validator,
      controller: widget.controller,
      maxLength: widget.maxLength,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      minLines: widget.minLines,

      // initialValue: widget.initialValue == null ? '' : widget.initialValue,
      inputFormatters: widget.inputFormatterData,
      obscureText: widget.obsecureText != null ? widget.obsecureText : false,
      onChanged: widget.onChanged,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints,
      decoration: InputDecoration(
        // labelText: widget.labelText ?? widget.hintText ?? '',
        // labelText: widget.labelText ?? '',
        // alignLabelWithHint: true,
        labelStyle: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.w500),
        counterText: widget.counterText,
        filled: true,
        // fillColor: widget.fillColor ?? Color(0XFFF3F3F3),
        fillColor: widget.fillColor ?? colorWhite,
        hintText: (widget.hintText != null) ? widget.hintText : '',
        floatingLabelBehavior: widget.floatingLabelBehavior != null ? widget.floatingLabelBehavior : FloatingLabelBehavior.auto,
        hintStyle: TextStyle(
          color: widget.hintTextStyleColor ?? Colors.grey,
          fontSize: 16,
          // fontFamily: 'Nunito',
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: widget.prefixIcon != null
            ? SizedBox(
                width: 15,
                height: 15,
                child: widget.prefixIcon,
              )
            : null,
        // prefixIcon: Padding(
        //   padding:widget.prefixIcon!=null? const EdgeInsets.only(right: 1.0,left: 1):EdgeInsets.all(0),
        //   child: widget.prefixIcon != null ? widget.prefixIcon : null,

        // ),

        suffixIcon: widget.suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: widget.suffixIcon != null ? widget.suffixIcon : Text(''),
              )
            : null,
        prefixText: (widget.prefixText != null) ? widget.prefixText : '',
        prefixStyle: widget.prefixStyle,
        errorText: widget.errorText,
        // errorStyle: TextStyle(fontFamily: pCommonRegularFont),
        contentPadding: const EdgeInsets.all(15.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: widget.focusedBorderRadius ?? BorderRadius.circular(15),
          borderSide: BorderSide(color: widget.focusedBorderColor ?? Color(0XFFF3F3F3), width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: widget.enabledBorderRadius ?? BorderRadius.circular(15),
          borderSide: BorderSide(color: widget.enabledOutlineInputBorderColor ?? Color(0XFFF3F3F3), width: 1.0),
        ),
        border: widget.outlineInputBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: widget.outlineInputBorderColor ?? Color(0XFFF3F3F3), width: 1.0),
            ),
      ),
    );
  }
}
