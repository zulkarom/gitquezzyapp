import 'package:flutter/material.dart';

const Color kLightPrimary = Color(0xFF6F35A5);
const Color kLightAccent = Color(0xFFF1E6FF);
const Color kLightCanvas = Color(0xFFECEDF4);
const Color kLightTextColor = Color.fromARGB(255, 77, 29, 121);
const Color kLightPlaceholder = Color(0xFFF3F4FB);
const Color kLightPlaceholderText = Color(0xFF152D7A);
const Color kLightBg = Color(0xFFF8FAFC); //background color
const Color kLightError = Color(0xFFEF4444); // error color
const Color kLightField = Color(0xFFF1E6FF); //field color

const Color kDarkPrimary = Color(0xFF6F35A5);
const Color kDarkAccent = Color(0xFF456EF6);
const Color kDarkCanvas = Color(0xFF18202B);
const Color kDarkTextColor = Color(0xFFEBEAF6);
const Color kDarkPlaceholder = Color(0xFF161D26);
const Color kDarkPlaceholderText = Color(0xFF5D70AF);
const Color kDarkBg = Color(0xFF10161D);
const Color kDarkError = Color(0xFFD0524A);

const kBottomIcon = Color.fromARGB(255, 193, 145, 255);

const kblue = Color(0xFF71b8ff);

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

const kAcceptColor = Color(0xFF6F35A5);
const kRejectColor = Color.fromARGB(255, 242, 29, 29);

const Color kOtherColor = Color(0xFFF4F6F7);
const Color kTextLightColor = Color(0xFFA5A5A5);
const Color kErrorBorderColor = Color(0xFFE74C3C);

const kLightShimmerGradient = LinearGradient(
  colors: [
    Colors.transparent,
    kLightBg,
    Colors.transparent,
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
);

const kDarkShimmerGradient = LinearGradient(
  colors: [
    Colors.transparent,
    kDarkBg,
    Colors.transparent,
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
);

const List<Color> kGraphThemeColor = [
  Color(0xFF022c7c),
  Color(0xFF6496b1),
  Color(0xFF55c484),
  Color(0xFFfabf45),
  Color(0xFFf06a37),
  Color(0xFFf04245),
  Color(0xFF732b63),
];

const List<double> kGradientStops = [0.0, 0.5, 1.0];
