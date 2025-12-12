import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/features/reusable/widgets/flutter_toast.dart';
import 'package:quezzy_app/features/reusable/widgets/parent_password_field.dart';
import 'package:quezzy_app/features/student/controller/student_controller.dart';
import 'package:quezzy_app/features/student/screens/forget_pin_confirmation.dart';
import 'package:quezzy_app/features/student/widgets/student_widget.dart';
import '../../../core/constant/app_dimensions.dart';
import '../../../core/constant/colors.dart';
import '../../reusable/widgets/custom_input_field.dart';
import '../bloc/student_bloc.dart';

class ForgetPinForm extends StatelessWidget {
  const ForgetPinForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const _Content();
  }
}

class _Content extends StatefulWidget {
  const _Content();

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  late final TextEditingController passwordController;
  Object? studentId;
  Object? name;
  Object? type;
  late Set<Map<String, Object?>> studentData;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    studentData =
        ModalRoute.of(context)!.settings.arguments as Set<Map<String, Object?>>;

    for (var data in studentData) {
      studentId = data["studentId"];
      name = data["name"];
      type = data["type"];
      // Process the id and name as required
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              profileIconAndEditButton(2, context, studentId.toString(),
                  name.toString(), '', state.avatarUrl, 3),
              SizedBox(height: AppDimension().kFourScreenHeight),
              Text(
                name.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppDimension().defaultVerticalPadding,
                      ),
                      child: CustomInputField(
                        controller: passwordController,
                        isPassword: true,
                        textInputAction: TextInputAction.done,
                        inputType: TextInputType.number,
                        hint: 'Enter you new PIN',
                        fieldIcon: Icons.lock,
                        changeHandler: (value) {
                          context.read<StudentBloc>().add(PasswordEvent(value));
                        },
                      ),
                    )
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
                      if (passwordController.text == '') {
                        toastInfo(msg: 'New PIN cannot be empty');
                      } else {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return Dialog(
                              backgroundColor: kLightAccent,
                              child: SizedBox(
                                width: 300, // Set the desired width
                                height: 200, // Set the desired height
                                child: ParentPasswordField(
                                  msg:
                                      'Enter your parent account password to reset this PIN profile.',
                                  passwordHandler: (String password) {
                                    StudentController(context: context)
                                        .asyncPostResetPinNumber(
                                            int.parse(studentId.toString()),
                                            state.password,
                                            password,
                                            1);
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      }
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
    );
  }
}
