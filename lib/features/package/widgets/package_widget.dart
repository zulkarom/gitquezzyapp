import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ta_plus/core/constant/colors.dart';
import 'package:flutter_ta_plus/core/constant/constants.dart';
import 'package:flutter_ta_plus/core/models/subscribe.dart';

import '../../../core/models/entities.dart';

// for package grid view ui
Widget packageGrid(PackageItem item, String imageUrl) {
  return _items(item.name, 2);
}

Widget subscribeGrid(SubscribeItem item, String imageUrl) {
  return _items(item.name, item.is_payment);
}

Widget _items(String? name, int? type) {
  return Column(
    children: [
      Expanded(
        flex: 2, // Adjust the flex values as per your requirement
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.w),
              topRight: Radius.circular(15.w),
            ),
            color: kLightAccent,
          ),
          child: Center(
            child: Text(
              name ?? "",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      Expanded(
        flex: 1, // Adjust the flex values as per your requirement
        child: Container(
          padding: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.w),
              bottomRight: Radius.circular(15.w),
            ),
            color: kLightPrimary,
          ),
          child: Center(
            child: Text(
              type == 0
                  ? 'Trial'
                  : type == 1
                      ? 'Paid'
                      : 'Select',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget profileIconAndEditButton() {
  return Container(
    alignment: Alignment.bottomRight,
    width: 125.w,
    height: 125.h,
    padding: EdgeInsets.only(right: 3.w, bottom: 3.w),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        color: kLightAccent,
        image: const DecorationImage(
            image: AssetImage(AppConstants.DEFAULT_STUDENT_AVATAR))),
    child: Image(
      width: 25.w,
      height: 25.h,
      image: const AssetImage("assets/images/others/icons/edit_3.png"),
    ),
  );
}
