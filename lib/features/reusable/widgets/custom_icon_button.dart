import 'package:flutter/material.dart';

import '../../../core/constant/app_dimensions.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key, required this.onTap, required this.child, this.message = ''});

  final void Function()? onTap;
  final Widget child;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(
              AppDimension().kFortyScreenWidth,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 48,
                minHeight: 48,
              ),
              child: Padding(
                padding: AppDimension().kIconButtonPadding,
                child: Center(child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
