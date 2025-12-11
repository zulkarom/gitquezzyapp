import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ta_plus/core/constant/colors.dart';

import '../../../core/constant/constants.dart';
import '../../../global.dart';
import 'bloc/welcome_bloc.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeBloc(),
      child: const _WelcomeScaffold(),
    );
  }
}

class _WelcomeScaffold extends StatefulWidget {
  const _WelcomeScaffold();

  @override
  State<_WelcomeScaffold> createState() => __WelcomeScaffoldState();
}

class __WelcomeScaffoldState extends State<_WelcomeScaffold> {
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<WelcomeBloc, WelcomeState>(
            builder: (context, state) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  PageView(
                    controller: pageController,
                    onPageChanged: (index) {
                      state.page = index;
                      context.read<WelcomeBloc>().add(WelcomeEvent());
                    },
                    children: [
                      _page(
                          1,
                          context,
                          "Next",
                          "Learning everything",
                          "Learn with pleasure with\nus,where you are!",
                          "assets/images/others/png/welcome.png"),
                      _page(
                          2,
                          context,
                          "Next",
                          "Learning everything 2",
                          "Learn with pleasure with\nus,where you are! second",
                          "assets/images/others/png/ux.png"),
                      _page(
                          3,
                          context,
                          "Get Started",
                          "Learning everything 3",
                          "Learn with pleasure with\nus,where you are! third",
                          "assets/images/others/png/graphics.png"),
                    ],
                  ),
                  Positioned(
                    bottom: 80.h,
                    child: DotsIndicator(
                      position: state.page,
                      dotsCount: 3,
                      mainAxisAlignment: MainAxisAlignment.center,
                      decorator: DotsDecorator(
                        color: kLightAccent,
                        activeColor: kLightPrimary,
                        size: const Size.square(8.0),
                        activeSize: const Size(18.0, 8.0),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _page(int index, BuildContext context, String buttonName, String title,
      String subTitle, String imagePath) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: kblue,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(50))),
              child: Column(
                children: [Expanded(child: Image.asset(imagePath))],
              )),
        ),
        Expanded(
          flex: 2,
          child: Container(
            // color: kblue,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: kPrimaryColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    subTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: kPrimaryColor,
                      wordSpacing: 2.5,
                      height: 1.5,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                  GestureDetector(
                    onTap: () {
                      //within 0-2 index
                      if (index < 3) {
                        //animation
                        pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate,
                        );
                        print(index);
                      } else {
                        //jump to a new page
                        // print(index);
                        Global.storageService.setBool(
                            AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME, true);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/sign_in", (route) => false);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return const MyHomePage();
                        //     },
                        //   ),
                        // );
                      }
                    },
                    child: Container(
                      margin:
                          EdgeInsets.only(top: 100.h, left: 25.w, right: 25.w),
                      width: double.infinity,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: kLightPrimary,
                          borderRadius: BorderRadius.all(Radius.circular(15.w)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ]),
                      child: Center(
                        child: Text(
                          buttonName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Row(
                  //   //button position
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     MaterialButton(
                  //       height: 60,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(15.0)),
                  //       color: kLightPrimary,
                  //       onPressed: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) {
                  //               return const LoginScreen();
                  //             },
                  //           ),
                  //         );
                  //       },
                  //       child: Text(
                  //         buttonName,
                  //         style: const TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 18,
                  //             color: Colors.white),
                  //       ),
                  //     )
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
