import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ta_plus/core/constant/app_dimensions.dart';
import 'package:flutter_ta_plus/features/auth/screens/login_screen.dart';
import 'package:flutter_ta_plus/features/parent_application/bloc/app_parent_bloc.dart';
import 'package:flutter_ta_plus/features/parent_application/controller/app_parent_controller.dart';
import 'package:flutter_ta_plus/features/reusable/widgets/account_check.dart';
import '../../reusable/widgets/background.dart';
import '../../reusable/widgets/custom_input_field.dart';

class ApplicationParentPassword extends StatelessWidget {
  const ApplicationParentPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: _SignUpForm(),
        ),
      ),
    );
  }
}

class _SignUpForm extends StatefulWidget {
  const _SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<_SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  late final TextEditingController passwordController;
  late final TextEditingController repasswordController;

  @override
  void initState() {
    passwordController = TextEditingController();
    repasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: BlocBuilder<AppParentBloc, AppParentState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppDimension().defaultPadding,
                    horizontal: AppDimension().defaultPadding / 2),
                child: const Text(
                  "Sila isi kata laluan anda ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppDimension().defaultPadding,
                    horizontal: AppDimension().defaultPadding / 2),
                child: CustomInputField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  inputType: TextInputType.visiblePassword,
                  isPassword: true,
                  hint: 'Your Password',
                  fieldIcon: Icons.lock,
                  changeHandler: (value) {
                    context.read<AppParentBloc>().add(PasswordEvent(value));
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppDimension().defaultPadding / 4,
                    horizontal: AppDimension().defaultPadding / 2),
                child: CustomInputField(
                  controller: repasswordController,
                  textInputAction: TextInputAction.done,
                  inputType: TextInputType.visiblePassword,
                  isPassword: true,
                  hint: 'Re-enter Password',
                  fieldIcon: Icons.lock,
                  changeHandler: (value) {
                    context.read<AppParentBloc>().add(RePasswordEvent(value));
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppDimension().defaultPadding / 1,
                    horizontal: AppDimension().defaultPadding / 2),
                child: ElevatedButton(
                  onPressed: () {
                    AppParentController(context: context)
                        .handlePasswordSubmit();
                  },
                  child: Text("Submit".toUpperCase()),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
