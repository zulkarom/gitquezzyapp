import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quezzy_app/features/reusable/widgets/custom_snack_bar.dart';
import 'package:quezzy_app/features/reusable/widgets/flutter_toast.dart';
import 'package:quezzy_app/utils/show_snackbar.dart';

class ForgotPasswordController {
  final BuildContext context;

  const ForgotPasswordController({required this.context});

  Future<void> resetPassword(String email) async {
    try {
      if (email.isEmpty) {
        toastInfo(msg: "Please fill up your email");
        return;
      }
      FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      showSnackBar(
          context,
          customSnackBar(
              content:
                  'An email for password reset have been sent to your email.',
              color: Colors.green,
              context: context));

      return;
    } on FirebaseAuthException catch (e) {
      if (e.code.toString() == 'invalid-email') {
        showSnackBar(
            context,
            customSnackBar(
                content: 'Invalid email address.', context: context));
      }

      if (e.code.toString() == 'missing-email') {
        showSnackBar(context,
            customSnackBar(content: 'Missing email', context: context));
      }

      if (e.code.toString() == 'user-not-found') {
        showSnackBar(
            context,
            customSnackBar(
                content: 'Email not found. Please register your account.',
                context: context));
      }
    } catch (e) {
      return;
    }
  }
}
