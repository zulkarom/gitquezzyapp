

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quezzy_app/core/constant/app_dimensions.dart';
import 'package:quezzy_app/core/constant/colors.dart';
import 'package:quezzy_app/features/more/bloc/more_bloc.dart';
import 'package:quezzy_app/features/more/controllers/more_controller.dart';
import 'package:quezzy_app/features/quiz_room/screens/invitation_list_screen.dart';
import 'package:quezzy_app/features/reusable/widgets/custom_app_bar.dart';
import 'package:quezzy_app/features/reusable/widgets/custom_icon_button.dart';
import 'package:quezzy_app/features/student/screens/password_form.dart';
import 'package:quezzy_app/features/student/widgets/student_widget.dart';
import 'package:quezzy_app/global.dart';
import 'package:quezzy_app/routes/routes.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MoreController(context: context).init();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              title: 'Profiles And More',
              leading: [
                Center(
                  child: CustomIconButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: AppDimension().kTwentyScreenPixel,
                      color:
                          Theme.of(context).appBarTheme.actionsIconTheme!.color,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<MoreBloc, MoreState>(
                builder: (context, state) {
                  // if (state.packageItem.isEmpty) {
                  //   MoreController(context: context).init();
                  // }
                  return Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: size.height *
                            (state.studentItem.length * .04 + 0.03),
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 5.w),
                        child: CustomScrollView(
                          slivers: [
                            // SliverToBoxAdapter(child: SizedBox(height: 15.h)),
                            // SliverToBoxAdapter(
                            //   child: Center(
                            //     child: Text("Who's Playing?",
                            //         style: Theme.of(context)
                            //             .textTheme
                            //             .titleLarge!
                            //             .copyWith(
                            //               fontWeight: FontWeight.bold,
                            //               color: Theme.of(context).primaryColor,
                            //             )),
                            //   ),
                            // ),
                            SliverPadding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 18.h, horizontal: 20.w),
                              sliver: SliverGrid(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 5,
                                        childAspectRatio: 1),
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    final studentIndex = index;
                                    return GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) {
                                            return Dialog(
                                              backgroundColor: kLightAccent,
                                              child: SizedBox(
                                                width:
                                                    300, // Set the desired width
                                                height:
                                                    200, // Set the desired height
                                                child: PasswordForm(
                                                    state.studentItem.elementAt(
                                                        studentIndex),
                                                    2),
                                              ),
                                            );
                                          },
                                        );

                                        // Navigator.of(context).pushNamed(
                                        //   AppRoutes.PACKAGE_SELECTED,
                                        //   arguments: {
                                        //     "id": state.studentItem
                                        //         .elementAt(studentIndex)
                                        //         .id
                                        //   },
                                        // );
                                      },
                                      child: studentGrid(
                                          state.studentItem[studentIndex],
                                          '',
                                          context),
                                    );
                                  },
                                  childCount: state.studentItem.length,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.PACKAGE_SELECTED,
                            arguments: {
                              "id":
                                  Global.storageService.getStudentProfile().id,
                              "type": 2
                            },
                          );
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: kLightAccent,
                          ),
                          padding: EdgeInsets.all(12.w),
                          margin: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 8.w),
                          child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBe,
                              children: [
                                Icon(
                                  Icons.checklist_sharp,
                                  size: AppDimension().kThirtyScreenPixel,
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .actionsIconTheme!
                                      .color,
                                ),
                                SizedBox(width: size.width * .04),
                                Text(
                                  "Change Package",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                  textAlign: TextAlign.left,
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.arrow_right,
                                  size: AppDimension().kThirtyScreenPixel,
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .actionsIconTheme!
                                      .color,
                                ),
                              ]),
                        ),
                      ),
                      SizedBox(height: size.height * .02),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const InvitationListScreen();
                              },
                            ),
                          );
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: kLightAccent,
                          ),
                          padding: EdgeInsets.all(12.w),
                          margin: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 8.w),
                          child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBe,
                              children: [
                                Icon(
                                  Icons.pages,
                                  size: AppDimension().kThirtyScreenPixel,
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .actionsIconTheme!
                                      .color,
                                ),
                                SizedBox(width: size.width * .04),
                                Text(
                                  "Invitation Page",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                  textAlign: TextAlign.left,
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.arrow_right,
                                  size: AppDimension().kThirtyScreenPixel,
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .actionsIconTheme!
                                      .color,
                                ),
                              ]),
                        ),
                      ),
                      SizedBox(height: size.height * .09),
                      GestureDetector(
                        onTap: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (_) {
                          //     return Dialog(
                          //       backgroundColor: kLightAccent,
                          //       child: SizedBox(
                          //         width: 300, // Set the desired width
                          //         height: 200, // Set the desired height
                          //         child: passwordField(context),
                          //       ),
                          //     );
                          //   },
                          // );
                        },
                        child: Text(
                          "Back to Parent Page",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
