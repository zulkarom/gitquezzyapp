import 'package:flutter/material.dart';

import '../../../core/constant/app_dimensions.dart';

SnackBar customSnackBar(
    {required String content, required BuildContext context, Color? color}) {
  return SnackBar(
    content: Text(
      content,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.white,
          ),
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: color ?? Theme.of(context).colorScheme.error,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        AppDimension().kEightScreenPixel,
      ),
    ),
    dismissDirection: DismissDirection.horizontal,
    padding: AppDimension().kCardPadding,
  );
}
