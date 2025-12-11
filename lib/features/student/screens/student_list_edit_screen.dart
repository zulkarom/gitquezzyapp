import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ta_plus/core/constant/constants.dart';

import '../../../core/constant/app_dimensions.dart';
import '../../../routes/routes.dart';
import '../../reusable/widgets/custom_app_bar.dart';
import '../../reusable/widgets/custom_icon_button.dart';
import '../../reusable/widgets/dotted_box.dart';
import '../bloc/student_bloc.dart';
import '../controller/student_controller.dart';
import '../widgets/student_widget.dart';

class StudentListEditScreen extends StatefulWidget {
  const StudentListEditScreen({super.key});

  @override
  State<StudentListEditScreen> createState() => _StudentListEditScreenState();
}

class _StudentListEditScreenState extends State<StudentListEditScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    StudentController(context: context).init();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              title: AppConstants.APPS_NAME,
              leading: [
                Center(
                  child: CustomIconButton(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          "/app_parent", (route) => false);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: AppDimension().kTwentyScreenPixel,
                      color:
                          Theme.of(context).appBarTheme.actionsIconTheme!.color,
                    ),
                  ),
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
                        SliverToBoxAdapter(child: SizedBox(height: 15.h)),
                        SliverToBoxAdapter(
                          child: Center(
                            child: Text("Edit Student",
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
                                return Opacity(
                                  opacity: 0.8,
                                  child: GestureDetector(
                                    onTap: () {
                                      context.read<StudentBloc>().add(
                                          AvatarEvent(state.studentItem
                                              .elementAt(index)
                                              .avatar!));
                                      context.read<StudentBloc>().add(NameEvent(
                                            state.studentItem
                                                .elementAt(index)
                                                .name!,
                                          ));
                                      Navigator.of(context).pushNamed(
                                        AppRoutes.STUDENT_EDIT,
                                        arguments: {
                                          {
                                            "id": state.studentItem
                                                .elementAt(index)
                                                .id,
                                            "name": state.studentItem
                                                .elementAt(index)
                                                .name,
                                            "is_password": state.studentItem
                                                        .elementAt(index)
                                                        .password !=
                                                    null
                                                ? 1
                                                : 2
                                          }
                                        },
                                      );
                                    },
                                    child: studentGrid(
                                        state.studentItem[index],
                                        "assets/images/others/icons/edit.png",
                                        context),
                                  ),
                                );
                              },
                              childCount: state.studentItem.length,
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
