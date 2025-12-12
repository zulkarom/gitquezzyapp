import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quezzy_app/core/constant/colors.dart';

import '../../../core/constant/app_dimensions.dart';
import '../../reusable/widgets/custom_card.dart';

class ActionFriendCard extends StatelessWidget {
  // final Location curLocation;
  final String? friendName;
  final String? friendDesc;
  final Widget? image;
  final void Function()? acceptHandler;
  final void Function()? rejectHandler;

  const ActionFriendCard({
    super.key,
    // required this.curLocation,
    required this.friendName,
    required this.friendDesc,
    required this.image,
    required this.acceptHandler,
    required this.rejectHandler,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: kLightField,
      width: double.infinity,
      padding: AppDimension().kCardPadding,
      child: Row(
        children: [
          Center(
            child: image,
          ),
          SizedBox(width: AppDimension().kEightScreenWidth),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: AppDimension().kEightScreenWidth,
                top: AppDimension().kEightScreenHeight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    friendName!,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  SizedBox(height: AppDimension().kFourScreenHeight),
                  Text(
                    friendDesc!,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppDimension().kEightScreenHeight),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: rejectHandler,
            child: Container(
              // width: 40.w,
              // height: 40.h,
              decoration: BoxDecoration(
                  color: kLightAccent,
                  borderRadius: BorderRadius.circular(5.w),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(1, 1))
                  ]),
              child: Padding(
                padding: EdgeInsets.all(AppDimension().defaultPadding / 2),
                child: const Center(
                    child: Icon(
                  Icons.close,
                  color: kRejectColor,
                )),
              ),
            ),
          ),
          SizedBox(width: AppDimension().kEightScreenWidth),
          GestureDetector(
            onTap: acceptHandler,
            child: Container(
              // width: 40.w,
              // height: 40.h,
              decoration: BoxDecoration(
                  color: kLightAccent,
                  borderRadius: BorderRadius.circular(5.w),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(1, 1))
                  ]),
              child: Padding(
                padding: EdgeInsets.all(AppDimension().defaultPadding / 2),
                child: const Center(
                    child: Icon(
                  Icons.check,
                  color: kAcceptColor,
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
