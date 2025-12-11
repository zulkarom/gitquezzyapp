import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constant/app_dimensions.dart';
import '../../../core/constant/constants.dart';

class ChangeThemeSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const ChangeThemeSwitch({super.key, 
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
          color: Theme.of(context).colorScheme.surface.withOpacity(0.2),
        ),
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimension().kSixScreenWidth),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'assets/images/settings/svg/sun.svg',
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      width: AppDimension().kTwelveScreenPixel,
                    ),
                    SvgPicture.asset(
                      'assets/images/settings/svg/moon.svg',
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      width: AppDimension().kTwelveScreenPixel,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
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
                  child: AnimatedSwitcher(
                    duration: kAnimationDuration,
                    switchInCurve: kAnimationCurve,
                    reverseDuration: Duration.zero,
                    child: value
                        ? SvgPicture.asset(
                            'assets/images/settings/svg/moon_filled.svg',
                            width: AppDimension().kTwelveScreenHeight,
                          )
                        : SvgPicture.asset(
                            'assets/images/settings/svg/sun_filled.svg',
                            width: AppDimension().kTwelveScreenPixel,
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
