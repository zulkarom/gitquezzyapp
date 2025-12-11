//We need context for accessing bloc
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ta_plus/core/services/auth_login/auth_services.dart';
import 'package:flutter_ta_plus/features/forgot_password/screens/forgot_password_screen.dart';

import '../../../core/constant/colors.dart';
import '../controllers/login_controller.dart';

Widget buildThirdPartyLogin(BuildContext context) {
  return Container(
      margin: EdgeInsets.only(top: 40.h, bottom: 20.h),
      padding: EdgeInsets.only(left: 25.w, right: 25.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _reusableIcons(
              "google",
              () =>
                  LoginController(context: context).signInWithGoogle(context)),
          _reusableIcons("apple", () => AuthService().signInWithGoogle()),
          _reusableIcons("facebook", () => AuthService().signInWithGoogle())
        ],
      ));
}

Widget _reusableIcons(String iconName, Function()? onTap) {
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: 40.w,
      height: 40.h,
      child: Image.asset(
        "assets/images/others/icons/$iconName.png",
        fit: BoxFit.fill,
      ),
    ),
  );
}

Widget reusableForgetPassword(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const ForgotPasswordScreen();
              },
            ),
          );
        },
        child: const Text(
          "Forget Password? ",
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
    ],
  );
}
