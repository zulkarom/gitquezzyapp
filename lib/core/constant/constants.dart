import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

const String kAppStoreLink =
    'https://apps.apple.com/my/app/ta-plus/id1481682000xxxx';
const String kPlayStoreLink =
    'https://play.google.com/store/apps/details?id=com.taplus';
const String kDeletedPhotoUrl = 'deletedPhotoUrl';
const String kDeletedFileUrl = 'deletedFileUrl';

const Duration kAnimationDuration = Duration(milliseconds: 200);
const Curve kAnimationCurve = Curves.easeInOut;

const Duration kSplashDuration = Duration(seconds: 2);

const Duration kDialogDismissDuration = Duration(seconds: 1);

const Duration kDebounceDuration = Duration(milliseconds: 1000);

const String kLocalHost = '192.168.0.44';
const bool kIsLocal = true;

const int kTabletSize = 737;
const int kSmallTabletSize = 540;
const int kSmallTabletSize1 = 600;

class AppConstants {
  static const String APPS_NAME = 'Quezzy';
  static const String SERVER_API_URL = 'https://quezzy.com/';
  // static const String SERVER_API_URL = 'http://192.168.0.44:8000/';
  // static const String SERVER_API_URL = 'http://192.168.144.1:8000/';
  static const String SERVER_UPLOADS = "${SERVER_API_URL}uploads/";
  static const String STORAGE_DEVICE_OPEN_FIRST_TIME = 'device_first_open';
  static const String STORAGE_USER_PROFILE_KEY = 'user_profile_key';
  static const String STORAGE_USER_EMAIL = 'user_email';
  static const String STORAGE_USER_TOKEN = 'user_token';
  static const String STORAGE_USER_TOKEN_KEY = 'user_token_key';
  static const String DEFAULT_STUDENT_AVATAR =
      'assets/images/others/png/profile.png';
  static const String STORAGE_STUDENT_ID = 'student_id';
  static const String STORAGE_PACKAGE_ID = 'package_id';

  static const String STORAGE_TOPIC_KEY = 'topic_key';
  static const String STORAGE_STUDENT_PROFILE_KEY = 'student_profile_key';
  static const String STORAGE_STUDENT_PROFILE_MAP = 'student_profile_map';

  //package default image
  static const String DEFAULT_PACKAGE_IMAGE =
      'assets/images/topics/png/topic.png';
}

final kTopBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(20),
  topRight: Radius.circular(20),
);
