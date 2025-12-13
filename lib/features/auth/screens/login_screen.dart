import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/core/constant/app_dimensions.dart';
import 'package:quezzy_app/core/responsive/responsive.dart';
import 'package:quezzy_app/features/reusable/widgets/custom_input_field.dart';
import '../../reusable/widgets/account_check.dart';
import '../../reusable/widgets/background.dart';
import '../bloc/login/login_bloc.dart';
import '../controllers/login_controller.dart';
import '../widgets/auth_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: Background(
            alignment: Alignment.center,
            child: SingleChildScrollView(
                child: Responsive(
              mobile: MobileLoginScreen(),
              desktop: TabletLoginScreen(),
            ))),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  bool _submitting = false;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    // Prefill default credentials for development/testing
    usernameController.text = 'quezzylearning@gmail.com';
    passwordController.text = '1q2w3e';
    // Push prefilled values into LoginBloc after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<LoginBloc>().add(const EmailEvent('quezzylearning@gmail.com'));
        context.read<LoginBloc>().add(const PasswordEvent('1q2w3e'));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomInputField(
              controller: usernameController,
              textInputAction: TextInputAction.done,
              inputType: TextInputType.emailAddress,
              hint: 'Your email',
              fieldIcon: Icons.person,
              changeHandler: (value) {
                context.read<LoginBloc>().add(EmailEvent(value));
              },
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: AppDimension().defaultPadding),
              child: CustomInputField(
                controller: passwordController,
                textInputAction: TextInputAction.done,
                inputType: TextInputType.visiblePassword,
                isPassword: true,
                hint: 'Your Password',
                fieldIcon: Icons.lock,
                changeHandler: (value) {
                  context.read<LoginBloc>().add(PasswordEvent(value));
                },
              ),
            ),
            SizedBox(height: AppDimension().kSixteenScreenHeight),
            Hero(
              tag: "login_btn",
              child: ElevatedButton(
                onPressed: _submitting
                    ? null
                    : () async {
                        setState(() {
                          _submitting = true;
                        });
                        try {
                          await LoginController(context: context)
                              .handleSignIn("email");
                        } finally {
                          if (mounted) {
                            setState(() {
                              _submitting = false;
                            });
                          }
                        }
                      },
                child: Text(
                  (_submitting ? "Logging in..." : "Login").toUpperCase(),
                ),
              ),
            ),
            SizedBox(height: AppDimension().kSixteenScreenHeight),
            reusableForgetPassword(context),
            AccountCheck(
              press: () {
                Navigator.of(context).pushNamed("/register");
              },
            ),
          ],
        );
      },
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: [
            const Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppDimension().defaultPadding * 2),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: buildThirdPartyLogin(context),
                ),
                const Spacer(),
              ],
            ),
            // SizedBox(height: AppDimension().defaultPadding * 2),
            // Row(
            //   children: [
            //     const Spacer(),
            //     Expanded(
            //       flex: 8,
            //       child: SvgPicture.asset("assets/images/auth/svg/login.svg"),
            //     ),
            //     const Spacer(),
            //   ],
            // ),
            SizedBox(height: AppDimension().kSixteenScreenHeight * 2),
          ],
        ),
        const Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: _LoginForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}

class TabletLoginScreen extends StatelessWidget {
  const TabletLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppDimension().kSixteenScreenHeight * 2),
            buildThirdPartyLogin(context),
            SizedBox(height: AppDimension().kSixteenScreenHeight * 2),
            const _LoginForm(),
          ],
        ),
      ),
    );
  }
}
