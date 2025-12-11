import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constant/app_dimensions.dart';

class OptionCard extends StatelessWidget {
  final String svgIconPath;
  final Widget? title;
  final String? optionName;
  final Widget action;

  const OptionCard({super.key, 
    required this.svgIconPath,
    this.title,
    this.optionName,
    required this.action,
  }) : assert(title == null && optionName != null ||
            title != null ||
            optionName == null);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AppDimension().kFortyEightScreenWidth,
          height: AppDimension().kFortyEightScreenWidth,
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
        SizedBox(
          width: AppDimension().kEightScreenWidth,
        ),
        if (optionName != null)
          Expanded(
            child: Text(
              optionName!,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        if (title != null) Expanded(child: title!),
        SizedBox(
          width: AppDimension().kEightScreenWidth,
        ),
        action,
      ],
    );
  }
}
