import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ta_plus/core/constant/colors.dart';
import 'package:flutter_ta_plus/features/parent_application/bloc/app_parent_bloc.dart';
import 'package:flutter_ta_plus/features/parent_application/widgets/app_parent_widget.dart';

class ApplicationParentScreen extends StatefulWidget {
  const ApplicationParentScreen({super.key});

  @override
  State<ApplicationParentScreen> createState() =>
      _ApplicationParentScreenState();
}

class _ApplicationParentScreenState extends State<ApplicationParentScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<AppParentBloc, AppParentState>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
                body: buildPage(state.index),
                // floatingActionButton: FloatingActionButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) {
                //           return const MessageScreen();
                //         },
                //       ),
                //     );
                //   },
                //   // foregroundColor: customizations[index].$1,
                //   // backgroundColor: customizations[index].$2,
                //   // shape: customizations[index].$3,
                //   child: const Icon(Icons.chat),
                // ),
                bottomNavigationBar: Container(
                  width: size.width,
                  height: size.height * .08,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.h),
                      topRight: Radius.circular(20.h),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1),
                    ],
                  ),
                  child: BottomNavigationBar(
                    currentIndex: state.index,
                    onTap: (value) {
                      context.read<AppParentBloc>().add(TriggerAppEvent(value));
                    },
                    elevation: 0,
                    type: BottomNavigationBarType.fixed,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    // selectedItemColor: kPrimaryColor,
                    // unselectedItemColor: kLightCanvas,
                    items: bottomTabs,
                    selectedLabelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      // Add other properties as needed
                      fontSize: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .fontSize, // Use font size from theme
                    ),
                    unselectedLabelStyle: TextStyle(
                      color: Theme.of(context).canvasColor,
                      // fontWeight: FontWeight.bold,
                      // Add other properties as needed
                      fontSize: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .fontSize, // Use font size from theme
                    ),
                    // selectedIconTheme: IconThemeData(
                    //   color: Theme.of(context).primaryColor,
                    //   // Use font size from theme
                    // ),
                    // unselectedIconTheme: IconThemeData(
                    //   color: Theme.of(context).primaryColor,
                    //   // Use font size from theme
                    // ),
                  ),
                )),
          ),
        );
      },
    );
  }
}
