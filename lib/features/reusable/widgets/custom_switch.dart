import 'package:flutter/material.dart';

import '../../../core/constant/app_dimensions.dart';
import '../../../core/constant/constants.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({super.key, 
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        value == false ? onChanged(true) : onChanged(false);
      },
      child: AnimatedContainer(
        duration: kAnimationDuration,
        curve: kAnimationCurve,
        width: AppDimension().kFortyEightScreenWidth,
        height: AppDimension().kTwentyEightScreenHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppDimension().kTwentyFourScreenWidth,
          ),
          color: value ? Theme.of(context).colorScheme.surface.withOpacity(0.7) : Theme.of(context).colorScheme.surface.withOpacity(0.2),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimension().kFourScreenWidth,
          ),
          child: AnimatedAlign(
            duration: kAnimationDuration,
            curve: kAnimationCurve,
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: AppDimension().kTwentyScreenWidth,
              height: AppDimension().kTwentyScreenWidth,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
