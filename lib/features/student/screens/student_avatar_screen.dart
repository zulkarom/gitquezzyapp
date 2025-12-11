import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_dimensions.dart';
import '../../../routes/routes.dart';
import '../../reusable/widgets/custom_app_bar.dart';
import '../../reusable/widgets/custom_icon_button.dart';
import '../bloc/student_bloc.dart';
import '../controller/student_controller.dart';
import '../widgets/student_widget.dart';

class StudentAvatarScreen extends StatefulWidget {
  const StudentAvatarScreen({super.key});

  @override
  State<StudentAvatarScreen> createState() => _StudentAvatarScreenState();
}

class _StudentAvatarScreenState extends State<StudentAvatarScreen> {
  Object? studentId;
  Object? name;
  Object? isPassword;
  Object? formType;
  late Set<Map<String, Object?>> studentData;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    StudentController(context: context).initAvatar();

    studentData =
        ModalRoute.of(context)!.settings.arguments as Set<Map<String, Object?>>;

    for (var data in studentData) {
      studentId = data["id"];
      name = data["name"];
      isPassword = data["is_password"];
      formType = data["formType"];
      // Process the id and name as required
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              title: 'Pilih Avatar Anda',
              leading: [
                Center(
                  child: BlocBuilder<StudentBloc, StudentState>(
                    builder: (context, state) {
                      return CustomIconButton(
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            formType == 1 ? "/student_add" : "/student_edit",
                            (route) => false,
                            arguments: {
                              {
                                "id": studentId,
                                "name": formType == 1 ? state.name : name,
                                "is_password": isPassword
                              }
                            },
                          );
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: AppDimension().kTwentyScreenPixel,
                          color: Theme.of(context)
                              .appBarTheme
                              .actionsIconTheme!
                              .color,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            BlocBuilder<StudentBloc, StudentState>(
              builder: (context, state) {
                if (state.avatarItem.isEmpty) {
                  StudentController(context: context).initAvatar();
                }
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 25.w),
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(child: SizedBox(height: 15.h)),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                              vertical: 18.h, horizontal: 20.w),
                          sliver: SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 1),
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    context.read<StudentBloc>().add(
                                          AvatarEvent(
                                            state.avatarItem
                                                .elementAt(index)
                                                .url!,
                                          ),
                                        );
                                    context.read<StudentBloc>().add(
                                          NameEvent(state.name),
                                        );
                                    Navigator.popAndPushNamed(
                                      context,
                                      formType == 1
                                          ? AppRoutes.STUDENT_ADD
                                          : AppRoutes.STUDENT_EDIT,
                                      arguments: {
                                        {
                                          "id": studentId,
                                          "name": state.name,
                                          "is_password": isPassword
                                        }
                                      },
                                    );
                                  },
                                  child: avatarGrid(state.avatarItem[index]),
                                );
                              },
                              childCount: state.avatarItem.length,
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
