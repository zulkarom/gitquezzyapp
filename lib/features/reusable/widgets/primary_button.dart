import 'package:flutter/material.dart';

import '../../../core/constant/app_dimensions.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.handler,
    required this.name,
    this.icon,
    this.leading = true,
  });

  ///
  final Function() handler;

  /// icon position
  final bool leading;
  ////
  final String name;

  ///
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: handler,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null && leading)
            Icon(
              icon,
              size: AppDimension().kTwentyScreenPixel,
            ),
          if (icon != null && leading)
            SizedBox(
              width: AppDimension().kEightScreenWidth,
            ),
          Flexible(
            child: Text(
              name,
              textAlign: TextAlign.center,
            ),
          ),
          if (icon != null && !leading)
            SizedBox(
              width: AppDimension().kEightScreenWidth,
            ),
          if (icon != null && !leading)
            Icon(
              icon,
              size: AppDimension().kTwentyScreenPixel,
            ),
        ],
      ),
    );
  }
}
