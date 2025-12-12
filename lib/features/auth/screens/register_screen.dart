import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quezzy_app/core/constant/app_dimensions.dart';
import 'package:quezzy_app/features/auth/screens/login_screen.dart';
import 'package:quezzy_app/features/reusable/widgets/account_check.dart';
import '../../../core/responsive/responsive.dart';
import '../../reusable/widgets/background.dart';
import '../../reusable/widgets/custom_input_field.dart';
import '../bloc/register/register_bloc.dart';
import '../controllers/register_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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

class _SignUpForm extends StatefulWidget {
  const _SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<_SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController repasswordController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    repasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppDimension().defaultPadding),
                child: CustomInputField(
                  controller: nameController,
                  textInputAction: TextInputAction.done,
                  inputType: TextInputType.text,
                  hint: 'Your name',
                  fieldIcon: Icons.person,
                  changeHandler: (value) {
                    context.read<RegisterBloc>().add(NameEvent(value));
                  },
                ),
              ),
              CustomInputField(
                controller: emailController,
                textInputAction: TextInputAction.done,
                inputType: TextInputType.emailAddress,
                hint: 'Your email',
                fieldIcon: Icons.person,
                changeHandler: (value) {
                  context.read<RegisterBloc>().add(EmailEvent(value));
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppDimension().defaultPadding),
                child: CustomInputField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  inputType: TextInputType.visiblePassword,
                  isPassword: true,
                  hint: 'Your Password',
                  fieldIcon: Icons.lock,
                  changeHandler: (value) {
                    context.read<RegisterBloc>().add(PasswordEvent(value));
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: AppDimension().defaultPadding),
                child: CustomInputField(
                  controller: repasswordController,
                  textInputAction: TextInputAction.done,
                  inputType: TextInputType.visiblePassword,
                  isPassword: true,
                  hint: 'Re-enter Password',
                  fieldIcon: Icons.lock,
                  changeHandler: (value) {
                    context.read<RegisterBloc>().add(RePasswordEvent(value));
                  },
                ),
              ),
              SizedBox(height: AppDimension().defaultPadding / 2),
              ElevatedButton(
                onPressed: () {
                  RegisterController(context: context).handleEmailRegister();
                },
                child: Text("Sign Up".toUpperCase()),
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
          );
        },
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
              "Sign Up".toUpperCase(),
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
              child: _SignUpForm(),
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
                "Sign Up".toUpperCase(),
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
                child: _SignUpForm(),
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
