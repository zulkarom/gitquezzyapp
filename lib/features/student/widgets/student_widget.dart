import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ta_plus/core/constant/app_dimensions.dart';
import 'package:flutter_ta_plus/core/constant/colors.dart';
import 'package:flutter_ta_plus/core/models/entities.dart';

// for student grid view ui
Widget studentGrid(StudentItem item, String imageUrl, BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Column(
    children: [
      Expanded(
        child: Container(
          width: size.width * .3,
          height: size.height * .3,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.w),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
            color: kLightAccent,
            image: DecorationImage(
              image: AssetImage(item.avatar!),
              fit: BoxFit.cover,
            ),
          ),
          child: imageUrl.isNotEmpty
              ? Container(
                  width: 12.w,
                  height: 12.h,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.w),
                    // color: kLightAccent,
                    image: DecorationImage(
                      image: AssetImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      ),
      SizedBox(height: AppDimension().kFourScreenHeight),
      Text(
        item.name!.length > 12
            ? '${item.name!.substring(0, 9)}...'
            : item.name.toString(),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: AppDimension().kFourScreenHeight),
      // SizedBox(
      //   //width: 15.w,
      //   height: 13.h,
      //   child: item.password != null
      //       ? Image.asset(
      //           "assets/images/others/icons/lock.png",
      //           color: kPrimaryColor,
      //         )
      //       : const SizedBox.shrink(),
      // ),
    ],
  );
}

Widget avatarGrid(AvatarItem item) {
  return Column(
    children: [
      Expanded(
        child: Container(
          width: 125.w,
          height: 125.h,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.w),
            color: kLightAccent,
            image: DecorationImage(
              image: AssetImage(item.url!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget profileIconAndEditButton(
    int type,
    BuildContext context,
    String? studentId,
    String? name,
    String isPassword,
    String? avatarUrl,
    int? formType) {
  return GestureDetector(
    onTap: () {
      if (type == 1) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          "/student_avatar",
          (route) => false,
          arguments: {
            {
              "id": studentId,
              "name": name,
              "is_password": isPassword,
              'type': type, // type for forget pin or student form
              'formType':
                  formType, // type of return screen whether new or update student
            }
          },
        );
      }
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
          image: AssetImage(avatarUrl!),
        ),
      ),
      child: type == 1
          ? Image(
              width: 25.w,
              height: 25.h,
              image: const AssetImage("assets/images/others/icons/edit_3.png"),
            )
          : const SizedBox.shrink(),
    ),
  );
}
