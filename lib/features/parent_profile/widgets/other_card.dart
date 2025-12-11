import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ta_plus/core/constant/colors.dart';
import 'package:flutter_ta_plus/features/reusable/widgets/custom_icon_button.dart';

import '../../../core/constant/app_dimensions.dart';
import '../../reusable/widgets/custom_card.dart';

class OtherCard extends StatelessWidget {
  // final Location curLocation;
  final String otherName;
  final String svgIconPath;
  final void Function()? onTap;

  const OtherCard({
    super.key,
    required this.otherName,
    required this.svgIconPath,
    this.onTap()?,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: kLightField,
      width: double.infinity,
      padding: AppDimension().kCardPadding,
      child: Row(
        children: [
          Container(
            width: AppDimension().kFortyEightScreenWidth,
            height: AppDimension().kFortyScreenHeight,
            decoration: ShapeDecoration(
              color: Theme.of(context).canvasColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppDimension().kSixScreenWidth,
                ),
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                svgIconPath,
                width: AppDimension().kTwentyScreenPixel,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),

          SizedBox(width: AppDimension().kSixteenScreenWidth),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: AppDimension().kSixteenScreenWidth,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    otherName,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: AppDimension().kSixteenScreenWidth),
          CustomIconButton(
            onTap: () {
              onTap!();
            },
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              size: AppDimension().kTwentyScreenPixel,
              color: Theme.of(context).appBarTheme.actionsIconTheme!.color,
            ),
          ),
          // Expanded(
          //   child: ElevatedButton(
          //     onPressed: () {
          //       onTap;
          //     }, // Replace 'Button Label' with the actual label for the button
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor:
          //           Theme.of(context).primaryColor, // Set the button color
          //     ),
          //     child: const Text('Add Now'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
