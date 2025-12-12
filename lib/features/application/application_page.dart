import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quezzy_app/core/constant/app_dimensions.dart';
import 'package:quezzy_app/core/constant/colors.dart';
import 'package:quezzy_app/features/application/widgets/application_widget.dart';
import 'package:quezzy_app/features/messages/message/message_screen.dart';
import 'package:quezzy_app/features/more/bloc/more_bloc.dart';
import 'package:quezzy_app/features/more/screens/side_menu.dart';
import 'bloc/app_bloc.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
                body: Center(
                  child: ConstrainedBox(
                    constraints: AppDimension().kTabletMaxWidth,
                    child: buildPage(state.index),
                  ),
                ),
                drawer: Drawer(
                  child: SingleChildScrollView(
                    child: BlocBuilder<MoreBloc, MoreState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            //buildHeader(),
                            SizedBox(height: size.height * .01),
                            const SideMenu()
                          ],
                        );
                      },
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const MessageScreen();
                        },
                      ),
                    );
                  },
                  // foregroundColor: customizations[index].$1,
                  // backgroundColor: customizations[index].$2,
                  // shape: customizations[index].$3,
                  child: const Icon(Icons.chat),
                ),
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
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1),
                    ],
                  ),
                  child: BottomNavigationBar(
                    currentIndex: state.index,
                    onTap: (value) {
                      context.read<AppBloc>().add(TriggerAppEvent(value));
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
