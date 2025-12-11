import 'package:flutter/material.dart';
import 'package:flutter_ta_plus/core/constant/app_dimensions.dart';
import 'package:flutter_ta_plus/features/reusable/widgets/custom_input_field.dart';
import 'package:flutter_ta_plus/features/reusable/widgets/flutter_toast.dart';

class ParentPasswordField extends StatefulWidget {
  const ParentPasswordField({super.key, this.passwordHandler, this.msg});
  final void Function(String)? passwordHandler;
  final String? msg;

  @override
  State<ParentPasswordField> createState() => _ParentPasswordFieldState();
}

class _ParentPasswordFieldState extends State<ParentPasswordField> {
  late final TextEditingController passwordController;

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
                    child: Center(
                      child: Text(
                        widget.msg!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
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
                      // changeHandler: (value) {
                      //   context
                      //       .read<StudentBloc>()
                      //       .add(MainPasswordConfirmEvent(value));
                      // },
                    ),
                  )
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
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
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
                          toastInfo(
                              msg: 'Please enter your parent account password');
                        } else {
                          widget.passwordHandler!(passwordController.text);
                        }
                      },
                      child: Text(
                        'Ok',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
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
    ;
  }
}
