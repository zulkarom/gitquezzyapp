import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

import '../core/constant/constants.dart';

void navigateToStore() {
  Platform.isAndroid
      ? launchUrl(
          Uri.parse(kPlayStoreLink),
          mode: LaunchMode.externalApplication,
        )
      : launchUrl(
          Uri.parse(kAppStoreLink),
          mode: LaunchMode.externalApplication,
        );
}
