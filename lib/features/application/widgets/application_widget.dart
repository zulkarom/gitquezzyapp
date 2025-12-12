import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quezzy_app/core/constant/colors.dart';
import 'package:quezzy_app/features/home/screens/home_screen.dart';
import 'package:quezzy_app/features/performance/screens/performance_screen.dart';
import 'package:quezzy_app/features/profile/screens/profile_screen.dart';
import 'package:quezzy_app/features/settings/screens/setting_screen.dart';

Widget buildPage(int index) {
  List<Widget> widget = [
    const HomeScreen(),
    const PerformanceScreen(),
    const ProfileScreen(),
    const SettingScreen(),
    // BlocProvider<FriendBloc>(
    //     create: (context) => FriendBloc(), child: const FriendScreen()),
  ];

  return widget[index];
}

var bottomTabs = [
  BottomNavigationBarItem(
    label: "Home",
    icon: SizedBox(
      //width: 15.w,
      height: 20.h,
      child: Image.asset(
        "assets/images/others/icons/home.png",
        color: kBottomIcon,
      ),
    ),
    activeIcon: SizedBox(
      //width: 15.w,
      height: 20.h,
      child: Image.asset(
        "assets/images/others/icons/home.png",
        color: kPrimaryColor,
      ),
    ),
  ),
  BottomNavigationBarItem(
    label: "Prestasi",
    icon: SizedBox(
      //width: 15.w,
      height: 20.h,
      child: Image.asset(
        "assets/images/others/icons/star.png",
        color: kBottomIcon,
      ),
    ),
    activeIcon: SizedBox(
      //width: 15.w,
      height: 20.h,
      child: Image.asset(
        "assets/images/others/icons/star.png",
        color: kPrimaryColor,
      ),
    ),
  ),
  BottomNavigationBarItem(
    label: "Profile",
    icon: SizedBox(
      //width: 15.w,
      height: 20.h,
      child: Image.asset(
        "assets/images/others/icons/person2.png",
        color: kBottomIcon,
      ),
    ),
    activeIcon: SizedBox(
      //width: 15.w,
      height: 20.h,
      child: Image.asset(
        "assets/images/others/icons/person2.png",
        color: kPrimaryColor,
      ),
    ),
  ),
  BottomNavigationBarItem(
    label: "Setting",
    icon: SizedBox(
      // width: 15.w,
      height: 20.h,
      child: Image.asset(
        "assets/images/others/icons/settings2.png",
        color: kBottomIcon,
      ),
    ),
    activeIcon: SizedBox(
      //width: 15.w,
      height: 20.h,
      child: Image.asset(
        "assets/images/others/icons/settings2.png",
        color: kPrimaryColor,
      ),
    ),
  ),
  // BottomNavigationBarItem(
  //   label: "Friend",
  //   icon: SizedBox(
  //     //width: 15.w,
  //     height: 20.h,
  //     child: Image.asset(
  //       "assets/images/others/icons/person2.png",
  //       color: kBottomIcon,
  //     ),
  //   ),
  //   activeIcon: SizedBox(
  //     //width: 15.w,
  //     height: 20.h,
  //     child: Image.asset(
  //       "assets/images/others/icons/person2.png",
  //       color: kPrimaryColor,
  //     ),
  //   ),
  // ),
];
