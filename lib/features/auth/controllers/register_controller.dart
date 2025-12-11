import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../reusable/widgets/flutter_toast.dart';
import '../bloc/register/register_bloc.dart';

class RegisterController {
  final BuildContext context;
  const RegisterController({required this.context});

  Future<void> handleEmailRegister() async {
    final state = context.read<RegisterBloc>().state;
    String name = state.name;
    String email = state.email;
    String password = state.password;
    String rePassword = state.rePassword;

    if (name.isEmpty) {
      toastInfo(msg: "Name cannot be empty");
      return;
    }

    if (email.isEmpty) {
      toastInfo(msg: "Email cannot be empty");
      return;
    }

    if (password.isEmpty) {
      toastInfo(msg: "Password cannot be empty");
      return;
    }

    if (rePassword.isEmpty) {
      toastInfo(msg: "Re-enter password cannot be empty");
      return;
    }

    try {
      final crendential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (crendential.user != null) {
        await crendential.user?.sendEmailVerification();
        await crendential.user?.updateDisplayName(name);
        String photoUrl = "uploads/default.png";
        await crendential.user?.updatePhotoURL(photoUrl);
        toastInfo(
            msg:
                "An email has been sent to your registered email. To activate it, please check your email box and click on the link");
        Navigator.of(context).pop(); //to go to earlier page
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        toastInfo(msg: "The password provider is too weak");
      } else if (e.code == 'email-already-in-use') {
        toastInfo(msg: "The email is already in use");
      } else if (e.code == 'invalid-email') {
        toastInfo(msg: "Your email id is invalid");
      }
    }
  }
}
