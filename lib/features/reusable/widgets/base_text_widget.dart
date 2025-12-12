import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quezzy_app/core/constant/colors.dart';

Widget reusableText(String text,
    {Color color = kPrimaryColor,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.bold}) {
  return Text(
    text,
    style:
        TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize.sp),
  );
}

AppBar buildAppBar(String url) {
  return AppBar(
    title: reusableText(url),
  );
}
