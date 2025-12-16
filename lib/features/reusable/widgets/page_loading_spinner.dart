import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constant/app_dimensions.dart';
import 'shimmer_loading.dart';

class PageLoadingSpinner extends StatelessWidget {
  const PageLoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimension().kSeventyTwoScreenWidth,
      height: AppDimension().kSeventyTwoScreenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppDimension().kEightScreenPixel,
        ),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Center(
        child: ShimmerLoading(
          isLoading: true,
          child: SvgPicture.asset(
            'assets/images/core/svg/app_icon.svg',
            width: AppDimension().kFortyScreenWidth,
          ),
        ),
      ),
    );
  }
}
