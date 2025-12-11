import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ta_plus/core/constant/colors.dart';
import '../../../../core/constant/app_dimensions.dart';
import '../../../../core/models/entities.dart';
import '../../../../core/services/intl/intl_service.dart';

Widget chatFileButtons(String iconPath) {
  return GestureDetector(
    child: Container(
        padding: EdgeInsets.all(10.w),
        height: 40.h,
        width: 40.h,
        decoration: BoxDecoration(
            color: kLightBg,
            borderRadius: BorderRadius.circular(40.w),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(1, 1))
            ]),
        child: Image.asset(
          iconPath,
          color: kPrimaryColor,
        )),
  );
}

Widget chatRightWidget(Msgcontent item, BuildContext context) {
  return Container(
    padding: EdgeInsets.only(top: 5.w, bottom: 0.w, left: 0.w, right: 5.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 250.w, minHeight: 40.w),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 0.w, top: 0.w),
                padding: EdgeInsets.only(
                    top: 8.w, bottom: 4.w, left: 10.w, right: 10.w),
                decoration: BoxDecoration(
                  color: kLightPrimary,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(0.w),
                      topLeft: Radius.circular(10.w),
                      bottomLeft: Radius.circular(10.w),
                      bottomRight: Radius.circular(15.w)),
                ),
                child: IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${item.content}",
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                    // Theme.of(context).primaryColor,
                                    ),
                            // TextStyle(
                            //     fontSize: 14.sp, color: AppColors.primaryElementText),
                          )
                        ],
                      ),
                      SizedBox(width: AppDimension().kSixtyFourScreenWidth),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              IntlService().convertTimeForChat(
                                DateTime.fromMillisecondsSinceEpoch(
                                    item.addtime!.millisecondsSinceEpoch),
                              ),

                              // msgTimeLineFormat(
                              //     (item.addtime as Timestamp).toDate()),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: Colors.white.withOpacity(0.5),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget chatLeftWidget(Msgcontent item, BuildContext context) {
  return Container(
    padding: EdgeInsets.only(top: 5.w, bottom: 0.w, left: 5.w, right: 0.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 250.w, minHeight: 40.w),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 0.w, top: 0.w),
                padding: EdgeInsets.only(
                    top: 8.w, bottom: 4.w, left: 10.w, right: 10.w),
                decoration: BoxDecoration(
                  color: kLightAccent,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.w),
                      topLeft: Radius.circular(0.w),
                      bottomLeft: Radius.circular(10.w),
                      bottomRight: Radius.circular(15.w)),
                ),
                child: IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${item.content}",
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor
                                    // Theme.of(context).primaryColor,
                                    ),
                            // TextStyle(
                            //     fontSize: 14.sp, color: AppColors.primaryElementText),
                          )
                        ],
                      ),
                      SizedBox(width: AppDimension().kSixtyFourScreenWidth),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              IntlService().convertTimeForChat(
                                DateTime.fromMillisecondsSinceEpoch(
                                    item.addtime!.millisecondsSinceEpoch),
                              ),

                              // msgTimeLineFormat(
                              //     (item.addtime as Timestamp).toDate()),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
