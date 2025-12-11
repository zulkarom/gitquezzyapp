import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ta_plus/core/constant/colors.dart';

import '../../../core/constant/app_dimensions.dart';
import '../../reusable/widgets/custom_card.dart';

class InvitationCard extends StatelessWidget {
  // final Location curLocation;
  final String? invitationName;
  final String? invitationDesc;
  final Widget? image;
  final String? btnName;
  final void Function()? buttonHandler;
  final void Function()? rejectHandler;

  const InvitationCard({
    super.key,
    // required this.curLocation,
    required this.invitationName,
    required this.invitationDesc,
    this.image,
    required this.btnName,
    required this.buttonHandler,
    this.rejectHandler,
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
                    invitationName!,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  SizedBox(height: AppDimension().kFourScreenHeight),
                  Text(
                    invitationDesc!,
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
            onTap: buttonHandler,
            child: Container(
              // width: 40.w,
              // height: 40.h,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
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
                child: Center(
                    child: Text(
                  btnName!,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
