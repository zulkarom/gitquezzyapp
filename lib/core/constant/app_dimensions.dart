import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDimension {
  static final AppDimension _appDimension = AppDimension._internal();

  factory AppDimension() {
    return _appDimension;
  }

  AppDimension._internal();

  void instantiate() {}

  EdgeInsets kPagePadding = EdgeInsets.symmetric(
    horizontal: 24.w,
  );

  EdgeInsets kPagePaddingLandscape = EdgeInsets.symmetric(horizontal: 16.w);

  EdgeInsets kCardPadding = EdgeInsets.symmetric(
    horizontal: 16.w,
    vertical: 16.h,
  );

  EdgeInsets kCardPaddingLandscape = EdgeInsets.all(4.w);

  EdgeInsets kInputFieldPadding = EdgeInsets.symmetric(
    horizontal: 16.w,
    vertical: 16.h,
  );

  BorderRadius kCardBorderRadius = BorderRadius.circular(
    16.r,
  );

  BorderRadius kAppIconBorderRadius = BorderRadius.circular(
    8.r,
  );

  BorderRadius kBottomSheetBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(16.r),
    topRight: Radius.circular(16.r),
  );

  EdgeInsets kChipPadding = EdgeInsets.symmetric(
    vertical: 4.h,
    horizontal: 8.w,
  );

  EdgeInsets kGraphPadding = EdgeInsets.fromLTRB(
    8.w,
    0.h,
    8.w,
    8.h,
  );

  EdgeInsets kGraphPaddingLandscape = EdgeInsets.symmetric(
    horizontal: 4.w,
    vertical: 8.h,
  );

  EdgeInsets kIconButtonPadding = EdgeInsets.all(
    8.0.w,
  );

  final BoxConstraints kTabletMaxWidth = const BoxConstraints(maxWidth: 540);
  final BoxConstraints kLottieMaxWidth = const BoxConstraints(maxWidth: 200);
  final BoxConstraints kTimeCardMaxWidth = const BoxConstraints(maxWidth: 250);

  final double kBottomTabHeight = 56.h;

  final double kOneScreenPixel = 1.sp;
  final double kOneFiveSceenPixel = 1.5.sp;
  final double kTwoScreenPixel = 2.sp;
  final double kFourScreenPixel = 4.sp;
  final double kEightScreenPixel = 8.sp;
  final double kTenScreenPixel = 10.sp;
  final double kElevenScreenPixel = 11.sp;
  final double kTwelveScreenPixel = 12.sp;
  final double kForteenScreenPixel = 14.sp;
  final double kTwentyScreenPixel = 20.sp;
  final double kThirtyScreenPixel = 30.sp;
  final double kFortyScreenPixel = 40.sp;
  final double kTwoScreenWidth = 2.w;
  final double kFourScreenWidth = 4.w;
  final double kSixScreenWidth = 6.w;
  final double kEightScreenWidth = 8.w;
  final double kTwelveScreenWidth = 12.w;
  final double kSixteenScreenWidth = 16.w;
  final double kTwentyScreenWidth = 20.w;
  final double kTwentyFourScreenWidth = 24.w;
  final double kTwentySixScreenWidth = 26.w;
  final double kTwentyEightScreenWidth = 28.w;
  final double kThirtyTwoScreenWidth = 32.w;
  final double kFortyScreenWidth = 40.w;
  final double kFortyEightScreenWidth = 48.w;
  final double kFiftySixScreenWidth = 56.w;
  final double kSixtyFourScreenWidth = 64.w;
  final double kSeventyTwoScreenWidth = 72.w;
  final double kEightyScreenWidth = 80.w;
  final double kkNinetyScreenWidth = 90.w;
  final double kNinetySixScreenWidth = 96.w;
  final double kHundredFourScreenWidth = 104.w;
  final double kHundredTenScreenWidth = 110.w;
  final double kHundredTwentyScreenWidth = 120.w;
  final double kHundredEightyScreenWidth = 180.w;
  final double kTwoHundredFiftyScreenWidth = 250.w;
  final double kThreeHundredScreenWidth = 300.w;

  final double kFourScreenHeight = 4.h;
  final double kEightScreenHeight = 8.h;
  final double kTenScreenHeight = 10.h;
  final double kTwelveScreenHeight = 12.h;
  final double kSixteenScreenHeight = 16.h;
  final double kTwentyScreenHeight = 20.h;
  final double kTwentyFourScreenHeight = 24.h;
  final double kTwentyEightScreenHeight = 24.h;
  final double kThirtyTwoScreenHeight = 32.h;
  final double kFortyScreenHeight = 40.w;
  final double kFortyEightScreenHeight = 48.h;
  final double kFiftyScreenHeight = 50.h;
  final double kFiftySixScreenHeight = 56.h;
  final double kSixtyFourScreenHeight = 64.h;
  final double kEightyScreenHeight = 80.h;
  final double kHundredTwentyScreenHeight = 120.h;
  final double kTwoHundredScreenHeight = 200.h;
  final double kThreeHundredTwentyScreenHeight = 320.h;
  final double kSixHundredTwentyScreenHeight = 620.h;
  final double k50ScreenHeight = 0.5.sh;
  final double k80ScreenHeight = 0.8.sh;

  final double k80ScreenWidth = 0.8.sw;
  final double k100ScreenWidth = 1.sw;

  final double kLeftHandSideColumnWidth = 120.w;
  final double kLeftHandSideColumnWidthPermissionEditor = 180.w;
  final double kCellHeight = 56.h;

  final double kLeftTitleWidth = 28.w;
  final double kRightTitleWidth = 32.w;
  final double kBottomTitleHeight = 24.h;

  final double defaultPadding = 16.0;
  final double defaultVerticalPadding = 10.0;

  SizedBox sizedBox = const SizedBox(
    height: 16.0,
  );
}
