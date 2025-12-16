import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quezzy_app/core/bloc/data/cubit/data_cubit.dart';
import 'package:quezzy_app/core/constant/constants.dart';
import '../../../core/constant/app_dimensions.dart';
import '../../../global.dart';
import '../../../routes/routes.dart';
import '../../reusable/widgets/custom_app_bar.dart';
import '../../reusable/widgets/custom_icon_button.dart';
import '../../reusable/widgets/dotted_box.dart';
import '../bloc/student_bloc.dart';
import '../controller/student_controller.dart';
import '../widgets/student_widget.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    StudentController(context: context).init();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final dataCubit = context.read<DataCubit>();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              title: AppConstants.APPS_NAME,
              ending: [
                BlocBuilder<StudentBloc, StudentState>(
                  builder: (context, state) {
                    return Center(
                      child: CustomIconButton(
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "/student_list_edit", (route) => false);
                        },
                        child: Icon(
                          Icons.edit,
                          size: AppDimension().kTwentyScreenPixel,
                          color: Theme.of(context)
                              .appBarTheme
                              .actionsIconTheme!
                              .color,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
            BlocBuilder<StudentBloc, StudentState>(
              builder: (context, state) {
                if (state.studentItem.isEmpty) {
                  StudentController(context: context).init();
                }
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 25.w),
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Center(
                            child: Card(
                              color: Colors.white,
                              elevation: 8,
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              shadowColor: Colors.blue,
                              child: IntrinsicWidth(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: size.width * .002,
                                                right: size.width * .02,
                                                top: 0,
                                                bottom: 0),
                                            child: Icon(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              Icons.texture,
                                              size: 30,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Text(
                                                //   formattedDate,
                                                //   style: TextStyle(
                                                //     //fontSize: 13,
                                                //     color: Theme.of(context).primaryColor,
                                                //     fontWeight: FontWeight.bold,
                                                //   ),
                                                //   textScaleFactor:
                                                //       ScaleSize.textScaleFactor(context),
                                                // ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: size.height * .008),
                                                  child: Text(
                                                    'Welcome text',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    //style: const TextStyle(fontSize: 13),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 15.h)),
                        SliverToBoxAdapter(
                          child: Center(
                            child: Text("Who's Playing?",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    )),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                              vertical: 18.h, horizontal: 20.w),
                          sliver: SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 5,
                                    childAspectRatio: 1),
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                if (index == 0) {
                                  return Container(
                                    padding: EdgeInsets.only(
                                      left: 15.w,
                                      right: 15.w,
                                      bottom: 28.w,
                                    ),
                                    child: DottedBox(
                                      () {
                                        context
                                            .read<StudentBloc>()
                                            .add(const NameEvent(''));
                                        context.read<StudentBloc>().add(
                                            const AvatarEvent(AppConstants
                                                .DEFAULT_STUDENT_AVATAR));
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                "/student_add",
                                                (route) => false);
                                      },
                                      'assets/images/others/svg/plus.svg',
                                    ),
                                  );
                                } else if (index <= state.studentItem.length) {
                                  final studentIndex = index - 1;
                                  // if (state.studentItem
                                  //         .elementAt(studentIndex)
                                  //         .password !=
                                  //     null) {
                                  //   return GestureDetector(
                                  //     onTap: () {
                                  //       showDialog(
                                  //         context: context,
                                  //         builder: (_) {
                                  //           return Dialog(
                                  //             backgroundColor: kLightAccent,
                                  //             child: SizedBox(
                                  //               width:
                                  //                   300, // Set the desired width
                                  //               height:
                                  //                   200, // Set the desired height
                                  //               child: PasswordForm(
                                  //                   state.studentItem.elementAt(
                                  //                       studentIndex),
                                  //                   1),
                                  //             ),
                                  //           );
                                  //         },
                                  //       );

                                  //       // Navigator.of(context).pushNamed(
                                  //       //   AppRoutes.PACKAGE_SELECTED,
                                  //       //   arguments: {
                                  //       //     "id": state.studentItem
                                  //       //         .elementAt(studentIndex)
                                  //       //         .id
                                  //       //   },
                                  //       // );
                                  //     },
                                  //     child: studentGrid(
                                  //         state.studentItem[studentIndex],
                                  //         '',
                                  //         context),
                                  //   );
                                  // } else {
                                  return GestureDetector(
                                    onTap: () {
                                      context.read<StudentBloc>().add(
                                          AvatarEvent(state.studentItem
                                              .elementAt(studentIndex)
                                              .avatar!));
                                      // print(
                                      //     '-----${state.studentItem.elementAt(studentIndex).token}....');
                                      //Store student data in local storage
                                      Global.storageService.setString(
                                          AppConstants
                                              .STORAGE_STUDENT_PROFILE_KEY,
                                          jsonEncode(state.studentItem
                                              .elementAt(studentIndex)));
                                      dataCubit.setStudentId(state.studentItem
                                          .elementAt(studentIndex)
                                          .id!);
                                      // Navigate to package selected screen
                                      print(
                                          "student id......${state.studentItem.elementAt(studentIndex).id}");
                                      Navigator.of(context).pushNamed(
                                        AppRoutes.PACKAGE_SELECTED,
                                        arguments: {
                                          "id": state.studentItem
                                              .elementAt(studentIndex)
                                              .id,
                                        },
                                      );
                                    },
                                    child: studentGrid(
                                        state.studentItem[studentIndex],
                                        '',
                                        context),
                                  );
                                }
                                return null;
                                // } else {
                                //   // Handle any additional items beyond the studentItem length
                                //   return null;
                                // }
                              },
                              childCount: state.studentItem.length + 1,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
