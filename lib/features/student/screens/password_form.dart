import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/features/student/controller/student_controller.dart';
import '../../../core/constant/app_dimensions.dart';
import '../../../core/models/entities.dart';
import '../../reusable/widgets/custom_input_field.dart';
import '../../reusable/widgets/flutter_toast.dart';
import '../bloc/student_bloc.dart';

class PasswordForm extends StatelessWidget {
  final StudentItem studentItem;
  final int? type;
  const PasswordForm(this.studentItem, this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    return _Content(studentItem, type);
  }
}

class _Content extends StatefulWidget {
  final StudentItem studentItem;
  final int? type;
  const _Content(this.studentItem, this.type);

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  late final TextEditingController passwordController;
  // Object? studentId;
  // Object? name;
  // late Set<Map<String, Object?>> studentData;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // if (widget.type == 2) {
    //   studentData = ModalRoute.of(context)!.settings.arguments
    //       as Set<Map<String, Object?>>;

    //   for (var data in studentData) {
    //     studentId = data["id"];
    //     name = data["name"];
    //     // Process the id and name as required
    //   }
    //   // print(studentId);
    //   // print("studentIdsdfsdfsdfsdfsdfsdfsdsdf");
    // } else {
    //   studentId = [];
    //   name = [];
    // }
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
        return Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppDimension().defaultVerticalPadding,
                        ),
                        child: Text(
                          'Enter your PIN to access this profile.',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: AppDimension().kEightScreenHeight,
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
                          // textInputAction: TextInputAction.done,
                          inputType: TextInputType.visiblePassword,
                          // fieldIcon: Icons.lock,
                          changeHandler: (value) {
                            context.read<StudentBloc>().add(PinEvent(value));
                          },
                        ),
                      )
                    ],
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
                        child: GestureDetector(
                          onTap: () {
                            context
                                .read<StudentBloc>()
                                .add(AvatarEvent(widget.studentItem.avatar!));
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              "/forgot_pin",
                              (route) => false,
                              arguments: {
                                {
                                  "studentId": widget.studentItem.id,
                                  "name": widget.studentItem.name,
                                  "type": widget.type,
                                }
                              },
                            );
                            // Navigator.of(context).pushNamed(
                            //   "/forgot_pin",
                            //   arguments: {
                            //     {
                            //       "studentId": widget.studentItem.id,
                            //       "name": widget.studentItem.name,
                            //       "type": widget.type,
                            //     }
                            //   },
                            // );
                          },
                          child: Text(
                            'Forgot PIN?',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.combine([
                                    TextDecoration.underline,
                                  ]),
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppDimension().defaultVerticalPadding,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: AppDimension().kSixteenScreenWidth,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppDimension().defaultVerticalPadding,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            if (passwordController.text == '') {
                              toastInfo(msg: 'Enter your PIN number');
                            } else {
                              StudentController(context: context)
                                  .asyncPostPinNumber(
                                      widget.studentItem, state.pin);
                            }
                          },
                          child: Text(
                            'Ok',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: AppDimension().kEightScreenWidth,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
