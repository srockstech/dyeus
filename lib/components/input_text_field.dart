import 'package:dyeus/constants.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  InputTextField({
    @required this.screenHeight,
    @required this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.hintText,
    this.hintTextColor = kBlack,
    this.textColor = kBlack,
    this.enabledBorderColor = kBlack,
    this.focusedBorderColor = kBlack,
    this.cursorColor,
    this.fillColor = Colors.white,
    this.focusColor = Colors.white,
    this.fontSize,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType,
    this.controller,
  });

  final Function onChanged;
  final double screenHeight;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final String label;
  final String hintText;
  final Color hintTextColor;
  final Color textColor;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color cursorColor;
  final Color fillColor;
  final Color focusColor;
  final double fontSize;
  final bool obscureText;
  final int maxLines;
  final int minLines;
  final TextInputType keyboardType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: maxLines,
        minLines: minLines,
        onChanged: onChanged,
        cursorColor: cursorColor,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          labelStyle: TextStyle(color: kBlack, fontWeight: FontWeight.bold),
          contentPadding: EdgeInsets.all(screenHeight * 0.015),
          filled: true,
          fillColor: fillColor,
          focusColor: focusColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kBorderColor),
            borderRadius:
                BorderRadius.all(Radius.circular(screenWidth * 0.025)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kBorderColor),
            borderRadius:
                BorderRadius.all(Radius.circular(screenWidth * 0.025)),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: hintTextColor),
        ),
        style: TextStyle(color: textColor, fontSize: fontSize),
      ),
    );
  }
}
