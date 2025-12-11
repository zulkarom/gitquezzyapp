import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ta_plus/core/constant/colors.dart';
import 'package:flutter_ta_plus/core/models/entities.dart';
import 'package:flutter_ta_plus/features/reusable/screens/avatar_screen.dart';

Widget profileIconAndEditButton(
  BuildContext context,
  String? avatarUrl,
  List<AvatarItem>? avatarItem,
) {
  var size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: kLightAccent,
            child: SizedBox(
              width: size.width * .99, // Set the desired width
              height: size.height * .65, // Set the desired height
              child: AvatarScreen(
                avatarItem: avatarItem!,
              ),
            ),
          );
        },
      );
    },
    child: Container(
        alignment: Alignment.bottomRight,
        width: 125.w,
        height: 125.h,
        padding: EdgeInsets.only(right: 3.w, bottom: 3.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.w),
          color: kLightAccent,
          image: DecorationImage(
            image: AssetImage(avatarUrl ?? ''),
          ),
        ),
        child: Image(
          width: 25.w,
          height: 25.h,
          image: const AssetImage("assets/images/others/icons/edit_3.png"),
        )),
  );
}

Widget profileIcon(
  BuildContext context,
  String? avatarUrl,
) {
  return Container(
    alignment: Alignment.bottomRight,
    width: 125.w,
    height: 125.h,
    padding: EdgeInsets.only(right: 3.w, bottom: 3.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.w),
      color: kLightAccent,
      image: DecorationImage(
        image: AssetImage(avatarUrl ?? ''),
      ),
    ),
  );
}
