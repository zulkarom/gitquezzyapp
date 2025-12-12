import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ta_plus/core/constant/app_dimensions.dart';
import 'package:flutter_ta_plus/core/constant/colors.dart';


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

Widget showTextDialog(BuildContext context, int type) {
  String text = type == 0 ? "Back To Level " : "Next Level";

  return SizedBox(
    width: MediaQuery.of(context).size.width / 1.5,
    child: Column(
      children: [
        AppDimension().sizedBox,
        Text(
          text,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (type == 0) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return LevelScreen(
                  //           Global.storageService.getTopicItem()!);
                  //     },
                  //   ),
                  // );
                } else {}
              },
              child: Text(
                'Yes',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
