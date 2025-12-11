import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constant/app_dimensions.dart';
import 'shimmer_loading.dart';

class TAPlusLoader extends StatelessWidget {
  final String? description;

  const TAPlusLoader({super.key, 
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimension().kHundredTwentyScreenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: ShimmerLoading(
              isLoading: true,
              child: SvgPicture.asset(
                'assets/images/core/svg/app_icon.svg',
                width: AppDimension().kFortyScreenWidth,
              ),
            ),
          ),
          SizedBox(
            height: AppDimension().kEightScreenHeight,
          ),
          Text(
            description ?? '',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
