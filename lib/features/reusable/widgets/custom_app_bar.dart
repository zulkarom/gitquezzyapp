import 'package:flutter/material.dart';

import '../../../core/constant/app_dimensions.dart';

class CustomAppBar extends StatelessWidget {
  final Color? backgroundColor;
  final String title;
  final TextStyle? titleTextStyle;
  final List<Widget>? leading;
  final List<Widget>? ending;

  const CustomAppBar({
    super.key,
    this.backgroundColor,
    required this.title,
    this.titleTextStyle,
    this.leading,
    this.ending,
  });

  @override
  Widget build(BuildContext context) {
    final int extraSpace = (ending == null ? 0 : ending!.length) -
        (leading == null ? 0 : leading!.length);
    final int extraSpaceAfterTitle = (leading == null ? 0 : leading!.length) -
        (ending == null ? 0 : ending!.length);

    return Container(
      height: AppDimension().kFiftySixScreenHeight,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Row(children: [
        if (leading != null)
          ...List.generate(
              leading!.length,
              (index) => SizedBox(
                    width: AppDimension().kFortyEightScreenWidth,
                    child: leading![index],
                  )),
        if (extraSpace > 0)
          ...List.generate(
            extraSpace,
            (index) => SizedBox(
              width: AppDimension().kFortyEightScreenWidth,
            ),
          ),
        Expanded(
          child: Text(
            title,
            style: titleTextStyle ??
                Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
            textAlign: TextAlign.center,
          ),
        ),
        if (extraSpaceAfterTitle > 0)
          ...List.generate(
            extraSpaceAfterTitle,
            (index) => SizedBox(
              width: AppDimension().kFortyEightScreenWidth,
            ),
          ),
        if (ending != null)
          ...List.generate(
            ending!.length,
            (index) => SizedBox(
              width: AppDimension().kFortyEightScreenWidth,
              child: ending![index],
            ),
          ),
      ]),
    );
  }
}
