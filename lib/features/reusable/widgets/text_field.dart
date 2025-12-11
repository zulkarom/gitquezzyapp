import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ta_plus/core/constant/colors.dart';

Widget appTextField(
    String hintText, String textType, void Function(String value)? func,
    {int? maxLines = 1, TextEditingController? controller}) {
  return TextField(
    controller: controller,
    onChanged: (value) => func!(value),
    keyboardType: TextInputType.multiline,
    maxLines: maxLines,
    decoration: InputDecoration(
      hintText: hintText,
      filled: true, // Fill the background with a color
      fillColor: Colors.white, // Set the background color
      // border: const OutlineInputBorder(
      //     borderSide: BorderSide(color: Colors.transparent)),
      // enabledBorder: const OutlineInputBorder(
      //     borderSide: BorderSide(color: Colors.transparent)),
      // disabledBorder: const OutlineInputBorder(
      //     borderSide: BorderSide(color: Colors.transparent)),
      // focusedBorder: const OutlineInputBorder(
      //     borderSide: BorderSide(color: Colors.transparent)),
      hintStyle: const TextStyle(color: kLightAccent),
    ),
    style: TextStyle(
        color: kLightTextColor,
        fontFamily: "Avenir",
        fontWeight: FontWeight.normal,
        fontSize: 14.sp),
    autocorrect: false,
    obscureText: textType == "password" ? true : false,
  );
}
