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
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(
          AppDimension().kTenScreenPixel,
        ),
      ),
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(AppDimension().kSixScreenWidth),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: AppDimension().kTwoScreenPixel,
              ),
              borderRadius: BorderRadius.circular(
                AppDimension().kSixteenScreenWidth,
              ),
            ),
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
    );
  }
}
