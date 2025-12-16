
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quezzy_app/core/constant/colors.dart';
import 'package:quezzy_app/features/parent_performance/screens/parent_performance_screen.dart';
import 'package:quezzy_app/features/parent_profile/screens/parent_profile_screen.dart';
import 'package:quezzy_app/features/settings/screens/setting_screen.dart';
import 'package:quezzy_app/features/student/bloc/student_bloc.dart';
import 'package:quezzy_app/features/student/screens/student_list_screen.dart';

Widget buildPage(int index) {
  List<Widget> widget = [
    BlocProvider<StudentBloc>(
        create: (context) => StudentBloc(), child: const StudentListScreen()),
    const ParentPerformanceScreen(),
    const ParentProfileScreen(),
    // BlocProvider<ParentProfileBloc>(
    //     create: (context) => ParentProfileBloc(),
    //     child: const ParentProfileScreen()),
    const SettingScreen(),
    // const ProfileScreen(),
    // const SettingScreen(),
    // BlocProvider<FriendBloc>(
    //     create: (context) => FriendBloc(), child: const FriendScreen()),
  ];

  return widget[index];
}

var bottomTabs = [
  BottomNavigationBarItem(
    label: "Pelajar",
    icon: SizedBox(
      //width: 15.w,
      height: 20.h,
      child: Image.asset(
        "assets/images/others/icons/person.png",
        color: kBottomIcon,
      ),
    ),
    activeIcon: SizedBox(
      //width: 15.w,
      height: 20.h,
      child: Image.asset(
        "assets/images/others/icons/person.png",
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
    label: "Profil",
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
    label: "Tetapan",
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
