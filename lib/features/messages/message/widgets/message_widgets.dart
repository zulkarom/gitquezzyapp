import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quezzy_app/core/constant/colors.dart';

import '../../../../core/models/entities.dart';
import '../../../../core/utils/app_date.dart';
import '../../../../routes/routes.dart';
import '../../../reusable/widgets/base_text_widget.dart';
import '../message_controller.dart';

Widget buildChatList(
    BuildContext context, Message item, MessagesController controller) {
  return Container(
      width: 325.w,
      height: 80.h,
      // color: Colors.red,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0.w),
      child: InkWell(
        onTap: () {
          controller.goChat(item);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 50.h,
                  width: 50.h,
                  decoration: BoxDecoration(
                      image: item.avatar!.startsWith("assets/")
                          ? DecorationImage(
                              image: AssetImage("${item.avatar}"),
                              fit: BoxFit.fitHeight,
                            )
                          : DecorationImage(
                              image: NetworkImage("${item.avatar}"),
                              fit: BoxFit.fitHeight,
                            ),
                      borderRadius: BorderRadius.circular(15.h)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 10.w),
                        width: 210.w,
                        child: reusableText("${item.name}",
                            color: kPrimaryColor, fontSize: 13.sp)),
                    Container(
                      width: 210.w,
                      margin: EdgeInsets.only(left: 10.w, top: 10.h),
                      child: Text(
                        "${item.last_msg}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      item.last_time == null
                          ? ""
                          : duTimeLineFormat(
                              (item.last_time as Timestamp).toDate()),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).primaryColor,
                          ),
                    )),
                item.msg_num == 0
                    ? Container()
                    : Container(
                        height: 15.h,
                        alignment: Alignment.center,
                        constraints: BoxConstraints(minWidth: 15.w),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(5.h)),
                        child: Text(
                          "${item.msg_num}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                  //Theme.of(context).primaryColorLight,
                                  ),
                          // TextStyle(
                          //   color: AppColors.primaryElementText,
                          //   fontWeight: FontWeight.normal,
                          //   fontSize: 8.sp,
                          // ),
                        ),
                      )
              ],
            )
          ],
        ),
      ));
}

void showPopupMenu(BuildContext context) {
  showMenu(
    context: context,
    position: const RelativeRect.fromLTRB(
        1, 0, 0, 0), // Adjust the position as needed
    items: <PopupMenuEntry>[
      const PopupMenuItem(
        value: 'searchFriends',
        child: Text('Find Friends'),
      ),
      const PopupMenuItem(
        value: 'requestFriends',
        child: Text('Requesting Friends'),
      ),
      // const PopupMenuItem(
      //   value: 'item2',
      //   child: Text('Item 2'),
      // ),
      // Add more menu items as needed
    ],
    elevation: 8, // Shadow elevation of the menu
  ).then((value) {
    // Handle the selected menu item here
    if (value == 'searchFriends') {
      Navigator.pushNamed(context, AppRoutes.FRIEND);
    }
    if (value == 'requestFriends') {
      Navigator.pushNamed(context, AppRoutes.FRIEND_REQUEST);
    }
    // else if (value == 'item2') {
    //   // Perform the action for Item 2
    // }
  });
}
