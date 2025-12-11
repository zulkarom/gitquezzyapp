import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constant/app_dimensions.dart';

class DottedBox extends StatelessWidget {
  const DottedBox(this.onTap, this.svgPath, [this.size]);

  final void Function() onTap;
  final String svgPath;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      dashPattern: const [10, 6],
      color: Theme.of(context).primaryColor,
      strokeWidth: AppDimension().kTwoScreenPixel,
      radius: Radius.circular(AppDimension().kSixteenScreenWidth),
      padding: EdgeInsets.all(AppDimension().kSixScreenWidth),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppDimension().kTenScreenPixel,
          ),
        ),
        child: Material(
          color: Theme.of(context).colorScheme.background,
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              height: size,
              width: size,
              child: Center(
                child: SvgPicture.asset(
                  svgPath,
                  width: AppDimension().kThirtyTwoScreenWidth,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
