import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ta_plus/features/more/bloc/more_bloc.dart';
import 'package:flutter_ta_plus/features/student/controller/student_controller.dart';
import 'package:flutter_ta_plus/global.dart';
import '../../../core/constant/app_dimensions.dart';
import '../../../core/models/entities.dart';
import '../../reusable/widgets/custom_input_field.dart';
import '../../reusable/widgets/flutter_toast.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return _Content();
  }
}

class _Content extends StatefulWidget {
  const _Content();

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
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoreBloc, MoreState>(
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
                            context.read<MoreBloc>().add(PinEvent(value));
                          },
                        ),
                      )
                    ],
                  ),
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width / 1.5,
                //   child: Column(
                //     children: [
                //       Padding(
                //         padding: EdgeInsets.symmetric(
                //           vertical: AppDimension().defaultVerticalPadding,
                //         ),
                //         child: GestureDetector(
                //           onTap: () {
                //             context
                //                 .read<MoreBloc>()
                //                 .add(AvatarEvent(widget.studentItem.avatar!));
                //             Navigator.of(context).pushNamedAndRemoveUntil(
                //               "/forgot_pin",
                //               (route) => false,
                //               arguments: {
                //                 {
                //                   "studentId": widget.studentItem.id,
                //                   "name": widget.studentItem.name
                //                 }
                //               },
                //             );
                //           },
                //           child: Text(
                //             'Forgot PIN?',
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .titleSmall!
                //                 .copyWith(
                //                   color: Theme.of(context).primaryColor,
                //                   fontWeight: FontWeight.bold,
                //                   decoration: TextDecoration.combine([
                //                     TextDecoration.underline,
                //                   ]),
                //                 ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
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
                              toastInfo(msg: 'Enter parent password!');
                            } else if (passwordController.text ==
                                Global.storageService.getUserProfile().token) {
                              toastInfo(msg: 'Enter parent password!');
                            } else {
                              // StudentController(context: context)
                              //     .asyncPostPinNumber(
                              //         widget.studentItem, state.pin);
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
