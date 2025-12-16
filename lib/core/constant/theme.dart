import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../features/reusable/widgets/custom_slider.dart';
import 'app_dimensions.dart';
import 'colors.dart';

enum AppTheme {
  dark,
  light,
}

final Map<AppTheme, ThemeData> kAppThemeData = {
  AppTheme.dark: ThemeData.dark().copyWith(
    primaryColor: kDarkPrimary,
    scaffoldBackgroundColor: kDarkBg,
    canvasColor: kDarkCanvas,
    textTheme: GoogleFonts.ubuntuTextTheme(
      const TextTheme().copyWith(
        displayLarge: TextStyle(
          fontSize: 64.sp,
          color: kDarkTextColor,
        ),
        displayMedium: TextStyle(
          fontSize: 32.sp,
          color: kDarkTextColor,
        ),
        displaySmall: TextStyle(
          fontSize: 24.sp,
          color: kDarkTextColor,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontSize: 24.sp,
          color: kDarkTextColor,
        ),
        headlineSmall: TextStyle(
          fontSize: 20.sp,
          color: kDarkTextColor,
        ),
        titleLarge: TextStyle(
          fontSize: 16.sp,
          color: kDarkTextColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 12.sp,
          color: kDarkTextColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.sp,
          color: kDarkTextColor,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        minimumSize: WidgetStateProperty.all(
          Size(double.infinity, 56.h),
        ),
        shape: WidgetStateProperty.all(
          const StadiumBorder(),
        ),
        foregroundColor: WidgetStateProperty.all(
          kDarkTextColor,
        ),
        backgroundColor: WidgetStateProperty.all(
          kDarkPrimary,
        ),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 16.sp,
            color: kDarkTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(kDarkPrimary),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 16.sp,
            color: kDarkPrimary,
          ),
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kDarkBg,
      selectedItemColor: kDarkPrimary,
      selectedIconTheme: IconThemeData(
        color: kDarkPrimary,
        size: 24.sp,
      ),
      unselectedItemColor: kDarkPlaceholderText,
      unselectedIconTheme: IconThemeData(
        color: kDarkPlaceholderText,
        size: 24.sp,
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      toolbarHeight: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: const IconThemeData(
        color: kDarkTextColor,
      ),
      titleTextStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: kDarkTextColor,
      ),
      actionsIconTheme: const IconThemeData(
        color: kDarkTextColor,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData().copyWith(
      foregroundColor: kDarkTextColor,
      sizeConstraints: BoxConstraints.tightFor(
        width: 48.w,
        height: 48.w,
      ),
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: kDarkBg,
      shape: RoundedRectangleBorder(
        borderRadius: AppDimension().kCardBorderRadius,
      ),
    ),
    sliderTheme: SliderThemeData(
      inactiveTrackColor: kDarkCanvas,
      trackHeight: 2.h,
      showValueIndicator: ShowValueIndicator.onlyForContinuous,
      valueIndicatorColor: kDarkCanvas,
      rangeValueIndicatorShape:
          const MyRectangularRangeSliderValueIndicatorShape(),
      valueIndicatorTextStyle: TextStyle(
        fontSize: 14.sp,
        color: kDarkTextColor,
      ),
      thumbShape: const ThumbShape(),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: kDarkPlaceholder,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: kDarkCanvas,
      shape: RoundedRectangleBorder(
        borderRadius: AppDimension().kCardBorderRadius,
      ),
    ),
    colorScheme: const ColorScheme.dark()
        .copyWith(
          surface: kDarkPlaceholderText,
          primary: kDarkPrimary,
          secondary: kDarkAccent,
        )
        .copyWith(surface: kDarkPlaceholder)
        .copyWith(error: kDarkError),
  ),
  AppTheme.light: ThemeData.light().copyWith(
    primaryColor: kLightPrimary,
    scaffoldBackgroundColor: kLightBg,
    canvasColor: kLightCanvas,
    splashColor: kLightPrimary.withOpacity(0.1),
    textTheme: GoogleFonts.ubuntuTextTheme(
      const TextTheme().copyWith(
        displayLarge: TextStyle(
          fontSize: 64.sp,
          color: kLightTextColor,
        ),
        displayMedium: TextStyle(
          fontSize: 32.sp,
          color: kLightTextColor,
        ),
        displaySmall: TextStyle(
          fontSize: 24.sp,
          color: kLightTextColor,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontSize: 24.sp,
          color: kLightTextColor,
        ),
        headlineSmall: TextStyle(
          fontSize: 20.sp,
          color: kLightTextColor,
        ),
        titleLarge: TextStyle(
          fontSize: 16.sp,
          color: kLightTextColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 12.sp,
          color: kLightTextColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.sp,
          color: kLightTextColor,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(5),
        minimumSize: WidgetStateProperty.all(
          Size(double.infinity, 56.h),
        ),
        shape: WidgetStateProperty.all(
          const StadiumBorder(),
        ),
        foregroundColor: WidgetStateProperty.all(
          kLightBg,
        ),
        backgroundColor: WidgetStateProperty.all(
          kLightPrimary,
        ),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 16.sp,
            color: kLightBg,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    //New Added
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: kPrimaryLightColor,
      iconColor: kPrimaryColor,
      prefixIconColor: kPrimaryColor,
      contentPadding: EdgeInsets.symmetric(
          horizontal: AppDimension().defaultPadding,
          vertical: AppDimension().defaultPadding),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide.none,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(kLightPrimary),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 14.sp,
            color: kLightPrimary,
          ),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
      backgroundColor: Colors.transparent,
      toolbarHeight: 0,
      titleTextStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: kDarkTextColor,
      ),
      iconTheme: const IconThemeData(
        color: kDarkTextColor,
      ),
      actionsIconTheme: const IconThemeData(
        color: kLightTextColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kLightBg,
      selectedItemColor: kLightPrimary,
      selectedIconTheme: IconThemeData(
        color: kLightPrimary,
        size: 24.sp,
      ),
      unselectedItemColor: kLightPrimary,
      unselectedIconTheme: IconThemeData(
        color: kLightPrimary,
        size: 24.sp,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData().copyWith(
      foregroundColor: kDarkTextColor,
      sizeConstraints: BoxConstraints.tightFor(
        width: 48.w,
        height: 48.w,
      ),
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: kLightBg,
      shape: RoundedRectangleBorder(
        borderRadius: AppDimension().kCardBorderRadius,
      ),
    ),
    sliderTheme: SliderThemeData(
      overlayShape: RoundSliderOverlayShape(
        overlayRadius: 12.sp,
      ),
      minThumbSeparation: 0,
      inactiveTrackColor: kLightCanvas,
      trackHeight: 2.h,
      showValueIndicator: ShowValueIndicator.onlyForContinuous,
      valueIndicatorColor: kLightCanvas,
      valueIndicatorShape: const MyRectangularSliderValueIndicatorShape(),
      rangeValueIndicatorShape:
          const MyRectangularRangeSliderValueIndicatorShape(),
      valueIndicatorTextStyle: TextStyle(
        fontSize: 14.sp,
        color: kLightTextColor,
      ),
      rangeThumbShape: RoundRangeSliderThumbShape(
        enabledThumbRadius: 8.sp,
      ),
      thumbShape: RoundSliderThumbShape(
        enabledThumbRadius: 8.sp,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: kLightPlaceholder,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: kLightCanvas,
      shape: RoundedRectangleBorder(
        borderRadius: AppDimension().kCardBorderRadius,
      ),
    ),
    colorScheme: const ColorScheme.light()
        .copyWith(
          surface: kLightPlaceholderText,
          primary: kLightPrimary,
          secondary: kLightAccent,
        )
        .copyWith(surface: kLightPlaceholder)
        .copyWith(error: kLightError),
  ),
};
