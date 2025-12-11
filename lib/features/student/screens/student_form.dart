import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ta_plus/core/constant/constants.dart';
import 'package:flutter_ta_plus/features/student/controller/student_controller.dart';
import 'package:flutter_ta_plus/features/student/widgets/student_widget.dart';

import '../../../core/constant/app_dimensions.dart';
import '../../../utils/show_snackbar.dart';
import '../../reusable/widgets/custom_input_field.dart';
import '../../reusable/widgets/custom_snack_bar.dart';
import '../bloc/student_bloc.dart';

class StudentForm extends StatelessWidget {
  const StudentForm(this.type, {super.key});
  final int type;

  @override
  Widget build(BuildContext context) {
    return _Content(type);
  }
}

class _Content extends StatefulWidget {
  const _Content(this.type);
  final int type;

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  late final TextEditingController nameController;
  late final TextEditingController passwordController;
  Object? studentId;
  Object? name;
  Object? isPassword;
  late Set<Map<String, Object?>> studentData;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.type == 2) {
      studentData = ModalRoute.of(context)!.settings.arguments
          as Set<Map<String, Object?>>;

      for (var data in studentData) {
        studentId = data["id"];
        name = data["name"];
        isPassword = data["is_password"];
        // Process the id and name as required
      }
      nameController.text = context.read<StudentBloc>().state.name;
    } else {
      nameController.text = '';
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentBloc, StudentState>(
      listener: (context, state) {
        if (state is StudentAddFailed) {
          showSnackBar(
              context,
              customSnackBar(
                  content: state.failure.errorMessage, context: context));
        }
      },
      child: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                profileIconAndEditButton(
                    1,
                    context,
                    studentId.toString(),
                    name.toString(),
                    isPassword.toString(),
                    state.avatarUrl == ''
                        ? AppConstants.DEFAULT_STUDENT_AVATAR
                        : state.avatarUrl,
                    widget.type),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppDimension().defaultVerticalPadding,
                        ),
                        child: CustomInputField(
                          controller: nameController,
                          textInputAction: TextInputAction.done,
                          inputType: TextInputType.emailAddress,
                          hint: 'Profile Name',
                          fieldIcon: Icons.person,
                          changeHandler: (value) {
                            context.read<StudentBloc>().add(NameEvent(value));
                          },
                        ),
                      ),
                      widget.type == 1 || isPassword == 2
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: AppDimension().defaultVerticalPadding,
                              ),
                              child: CustomInputField(
                                controller: passwordController,
                                isPassword: true,
                                textInputAction: TextInputAction.done,
                                inputType: TextInputType.visiblePassword,
                                hint: 'Pin Number (optional)',
                                fieldIcon: Icons.lock,
                                changeHandler: (value) {
                                  context
                                      .read<StudentBloc>()
                                      .add(PasswordEvent(value));
                                },
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                SizedBox(height: AppDimension().kSixteenScreenHeight),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Hero(
                    tag: "save_btn",
                    child: ElevatedButton(
                      onPressed: () {
                        if (widget.type == 1) {
                          StudentController(context: context)
                              .asyncPostStudentData(
                            state.name,
                            state.password,
                            state.avatarUrl == ''
                                ? AppConstants.DEFAULT_STUDENT_AVATAR
                                : state.avatarUrl,
                          );
                        } else {
                          StudentController(context: context)
                              .asyncPostUpdateStudentData(
                            int.parse(studentId.toString()),
                            state.name,
                            state.password,
                            state.avatarUrl == ''
                                ? AppConstants.DEFAULT_STUDENT_AVATAR
                                : state.avatarUrl,
                          );
                        }

                        // context.read<StudentBloc>().add(AddStudent(
                        //       name: nameController.text,
                        //       password: passwordController.text,
                        //     ));
                      },
                      child: Text(
                        "Save".toUpperCase(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
