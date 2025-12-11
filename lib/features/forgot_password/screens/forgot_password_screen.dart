import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ta_plus/core/constant/app_dimensions.dart';
import 'package:flutter_ta_plus/core/constant/colors.dart';
import 'package:flutter_ta_plus/core/services/auth_login/auth_services.dart';
import 'package:flutter_ta_plus/features/auth/screens/login_screen.dart';
import 'package:flutter_ta_plus/features/forgot_password/controller/forgot_password_controller.dart';
import 'package:flutter_ta_plus/features/reusable/widgets/account_check.dart';
import 'package:flutter_ta_plus/features/reusable/widgets/custom_snack_bar.dart';
import 'package:flutter_ta_plus/utils/show_snackbar.dart';
import '../../../core/responsive/responsive.dart';
import '../../reusable/widgets/background.dart';
import '../../reusable/widgets/custom_input_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Background(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Responsive(
              mobile: MobileSignupScreen(),
              desktop: TabletSignupScreen(),
            ),
          ),
        ),
      ),
    );
  }
}

class _ForgotPassForm extends StatefulWidget {
  const _ForgotPassForm({
    Key? key,
  }) : super(key: key);

  @override
  State<_ForgotPassForm> createState() => __ForgotPassFormState();
}

class __ForgotPassFormState extends State<_ForgotPassForm> {
  late final TextEditingController emailController;

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();
    return Form(
      child: Column(
        children: [
          const Text(
            "Enter your email to send password reset link.",
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppDimension().kSixteenScreenHeight),
          CustomInputField(
            controller: emailController,
            textInputAction: TextInputAction.done,
            inputType: TextInputType.emailAddress,
            hint: 'Your email',
            fieldIcon: Icons.email,
            changeHandler: (value) {
              // context.read<RegisterBloc>().add(EmailEvent(value));
            },
          ),
          SizedBox(height: AppDimension().kSixteenScreenHeight),
          Hero(
            tag: "forgot_btn",
            child: ElevatedButton(
              onPressed: () {
                ForgotPasswordController(context: context)
                    .resetPassword(emailController.text);
                FocusScope.of(context).unfocus();
              },
              child: Text(
                "Send".toUpperCase(),
              ),
            ),
          ),
          SizedBox(height: AppDimension().defaultPadding),
          AccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: [
            Text(
              "Reset Password".toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppDimension().defaultPadding),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: SizedBox(
                    width: 200.w,
                    height: 200.h,
                    child:
                        SvgPicture.asset("assets/images/auth/svg/signup.svg"),
                  ),
                ),
                const Spacer(),
              ],
            ),
            SizedBox(height: AppDimension().defaultPadding),
          ],
        ),
        const Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: _ForgotPassForm(),
            ),
            Spacer(),
          ],
        ),
        // const SocalSignUp()
      ],
    );
  }
}

class TabletSignupScreen extends StatelessWidget {
  const TabletSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                "Reset Password".toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: AppDimension().defaultPadding),
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 8,
                    child: SvgPicture.asset(
                      "assets/images/auth/svg/signup.svg",
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: AppDimension().defaultPadding),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 450,
                child: _ForgotPassForm(),
              ),
              SizedBox(height: AppDimension().defaultPadding / 2),
              // SocalSignUp()
            ],
          ),
        ),
      ],
    );
  }
}
