//We need context for accessing bloc
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textDialog(String text) {
  return Center(
    child: AlertDialog(
      title: Text(text),
    ),
  );
}
