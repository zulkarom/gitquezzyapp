import 'package:flutter/material.dart';

import '../../../core/constant/app_dimensions.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color? color;
  final AlignmentGeometry? alignment;
  final BoxConstraints? constraints;

  const CustomCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.color,
    this.alignment,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      alignment: alignment,
      constraints: constraints,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: AppDimension().kCardBorderRadius,
        ),
        color: color ?? Theme.of(context).colorScheme.surface,
        shadows: [
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
            blurRadius: AppDimension().kFourScreenPixel,
            offset: Offset(
              AppDimension().kTwoScreenWidth,
              AppDimension().kFourScreenHeight,
            ),
          ),
        ],
      ),
      child: child,
    );
  }
}
