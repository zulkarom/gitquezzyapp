import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quezzy_app/features/reusable/widgets/flutter_toast.dart';
import '../../../core/constant/app_dimensions.dart';
import '../../../core/constant/constants.dart';
import '../../../global.dart';
import '../../../routes/routes.dart';
import '../../reusable/widgets/custom_app_bar.dart';
import '../../reusable/widgets/custom_icon_button.dart';
import '../../reusable/widgets/dotted_box.dart';
import '../bloc/package_bloc.dart';
import '../controller/package_controller.dart';
import '../widgets/package_widget.dart';

class PackageSelectedScreen extends StatefulWidget {
  const PackageSelectedScreen({super.key});

  @override
  State<PackageSelectedScreen> createState() => _PackageSelectedScreenState();
}

class _PackageSelectedScreenState extends State<PackageSelectedScreen> {
  late Map? student;
  int? type = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Retrieve arguments from the modal route
    final arguments = ModalRoute.of(context)?.settings.arguments;

    // Check if arguments are not null and are of the expected type (Map)
    if (arguments != null && arguments is Map) {
      student = arguments;

      // Initialize subscription with student ID if available
      if (student!.containsKey("id")) {
        PackageController(context: context).initSubscribe(student!["id"]);
      }

      // Check if the student type is 2 and set the type variable
      if (student!["type"] == 2) {
        type = student!["type"];
      }
      print('ifff package screen');
    } else {
      // print(
      //     "getstudentId......${Global.storageService.getStudentProfile().id}");
      print('elseee package screen');
      student = {
        'id': Global.storageService.getStudentId(),
      };
      PackageController(context: context)
          .initSubscribe(int.parse(Global.storageService.getStudentId()));
    }
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   student = ModalRoute.of(context)!.settings.arguments as Map;
  //   // print("studentId/////");
  //   // print(studentId);
  //   PackageController(context: context).initSubscribe(student["id"]);
  //   if (student["type"] == 2) {
  //     type = student["type"];
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              title: 'Your Packages',
              leading: [
                BlocBuilder<PackageBloc, PackageState>(
                  builder: (context, state) {
                    return Center(
                      child: CustomIconButton(
                        onTap: () {
                          if (type == 1) {
                            context
                                .read<PackageBloc>()
                                .add(const EmptySubscribeListItem([]));
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              "/app_parent",
                              (route) => false,
                            );
                          } else {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              "/application",
                              (route) => false,
                            );
                          }
                        },
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: AppDimension().kTwentyScreenPixel,
                          color: Theme.of(context)
                              .appBarTheme
                              .actionsIconTheme!
                              .color,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            BlocBuilder<PackageBloc, PackageState>(
              builder: (context, state) {
                if (state.subscribeItem.isEmpty) {
                  PackageController(context: context)
                      .initSubscribe(student!["id"]);
                }
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 25.w),
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(child: SizedBox(height: 15.h)),
                        SliverToBoxAdapter(
                          child: Center(
                            child: Text(
                                "Try for free before you purchase the package!",
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
                                      left: 19.w,
                                      right: 19.w,
                                      bottom: 38.w,
                                    ),
                                    child: DottedBox(
                                      () {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                          "/package_list",
                                          (route) => false,
                                          arguments: {"studentId": student},
                                        );
                                      },
                                      'assets/images/others/svg/plus.svg',
                                    ),
                                  );
                                } else if (index <=
                                    state.subscribeItem.length) {
                                  final packageIndex = index - 1;
                                  return Container(
                                    padding: EdgeInsets.only(
                                      left: 19.w,
                                      right: 19.w,
                                      bottom: 38.w,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        // print("package_id");
                                        // print(state.subscribeItem
                                        //     .elementAt(packageIndex)
                                        //     .package_id);

                                        Global.storageService.setString(
                                            AppConstants.STORAGE_PACKAGE_ID,
                                            jsonEncode(state.subscribeItem
                                                .elementAt(packageIndex)
                                                .package_id));
                                        Global.storageService.setString(
                                            AppConstants.STORAGE_STUDENT_ID,
                                            jsonEncode(student!["id"]));
                                        if (student!["studentItem"] != null) {
                                          Global.storageService.setString(
                                              AppConstants
                                                  .STORAGE_STUDENT_PROFILE_KEY,
                                              jsonEncode(
                                                  student!["studentItem"]));
                                        }

                                        Navigator.of(context).pushNamed(
                                          AppRoutes.APPLICATION,
                                        );
                                      },
                                      child: subscribeGrid(
                                          state.subscribeItem[packageIndex],
                                          ''),
                                    ),
                                  );
                                } else {
                                  // Handle any additional items beyond the studentItem length
                                  return null;
                                }
                              },
                              childCount: state.subscribeItem.length + 1,
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
