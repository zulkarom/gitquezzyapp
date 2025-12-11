import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ta_plus/features/auth/bloc/login/login_bloc.dart';
import 'package:flutter_ta_plus/features/student/controller/student_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/api/user_api.dart';
import '../../../core/constant/constants.dart';
import '../../../core/models/user.dart';
import '../../../global.dart';
import '../../reusable/widgets/flutter_toast.dart';

class LoginController {
  final BuildContext context;

  const LoginController({required this.context});

  Future<void> handleSignIn(String type) async {
    try {
      if (type == "email") {
        final state = context.read<LoginBloc>().state;
        String emailAddress = state.email;
        String password = state.password;
        // print(emailAddress);
        // print(password);
        if (emailAddress.isEmpty) {
          toastInfo(msg: "You need to fill email address");
          return;
        }
        if (password.isEmpty) {
          toastInfo(msg: "You need to fill password");
          return;
        }
        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailAddress, password: password);

          if (credential.user == null) {
            //
            toastInfo(msg: "You don't exist");
            return;
          }
          if (!credential.user!.emailVerified) {
            //
            toastInfo(msg: "You need to verify your email account");
            return;
          }
          var user = credential.user;
          if (user != null) {
            //we got from google
            // print('user.displayName');
            // print(user.displayName);
            String? displayName = user.displayName;
            String? email = user.email;

            String? id = user.uid;
            String? photoUrl = user.photoURL;
            LoginRequestEntity loginRequestEntity = LoginRequestEntity();

            loginRequestEntity.avatar = photoUrl;
            loginRequestEntity.name = displayName;
            loginRequestEntity.email = email;
            loginRequestEntity.open_id = id;
            loginRequestEntity.password = password;
            //type 1 means email login
            loginRequestEntity.type = 1;

            // print("loginRequestEntity2222");
            // print(loginRequestEntity.avatar);
            // print(loginRequestEntity.name);
            // print(loginRequestEntity.email);
            // print(loginRequestEntity.open_id);
            // print(loginRequestEntity.type);

            toastInfo(msg: "Redirecting...");
            asyncPostAllData(loginRequestEntity);
            if (context.mounted) {
              //initialize init method
              await StudentController(context: context).init();
            }

            return;
            //we got verified user from firebase
          } else {
            toastInfo(msg: "Currently you are not a user of this app");
            return;
            //we have error getting user from firebase
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            toastInfo(msg: "User not found for this email.");
            return;
          } else if (e.code == 'wrong-password') {
            toastInfo(msg: "Wrong password provided");
            return;
          } else if (e.code == 'invalid-email') {
            toastInfo(msg: "Invalid email address");
            return;
          } else {}
          //
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Begin interactive sign-in process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      // Obtain auth details from request
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      // Create a new credential for the user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Finally, let's sign in
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if the user is signed in successfully
      var user = userCredential.user;
      if (user != null) {
        //we got from google
        // print('user.displayName');
        // print(user.displayName);
        String? displayName = user.displayName;
        String? email = user.email;

        String? id = user.uid;
        String? photoUrl = user.photoURL;
        LoginRequestEntity loginRequestEntity = LoginRequestEntity();

        loginRequestEntity.avatar = photoUrl;
        loginRequestEntity.name = displayName;
        loginRequestEntity.email = email;
        loginRequestEntity.open_id = id;
        //type 1 means email login
        loginRequestEntity.type = 1;

        toastInfo(msg: "Redirecting...");
        asyncPostAllData(loginRequestEntity);
        if (context.mounted) {
          //initialize init method
          await StudentController(context: context).init();
        }

        return;
        //we got verified user from firebase
      } else {
        toastInfo(msg: "Currently you are not a user of this app");
        return;
        //we have error getting user from firebase
      }
    } catch (e) {
      toastInfo(msg: "Sign-in with Google error: $e");
      // Handle sign-in error here, e.g., display an error message.
    }
  }

  Future<void> asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    EasyLoading.show(
        indicator: const CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    var result = await UserAPI.login(params: loginRequestEntity);

    print("......my result code is ${result.code}.......");
    if (result.code == 200) {
      try {
        Global.storageService.setString(
            AppConstants.STORAGE_USER_PROFILE_KEY, jsonEncode(result.data!));
        // print("result.data!.token!");
        // print(result.data!.email!);
        Global.storageService.setString(
            AppConstants.STORAGE_USER_EMAIL, jsonEncode(result.data!.email!));
        print("......my token is ${result.data!.token}.......");
        //used for authorization
        Global.storageService.setString(
            AppConstants.STORAGE_USER_TOKEN_KEY, result.data!.access_token!);
        //used as foreign key
        Global.storageService
            .setString(AppConstants.STORAGE_USER_TOKEN, result.data!.token!);
        EasyLoading.dismiss();

        if (context.mounted) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/app_parent", (route) => false);
        }
      } catch (e) {
        print("saving local storage error ${e.toString()}");
      }
    } else {
      EasyLoading.dismiss();
      toastInfo(msg: "unknown error");
    }
  }
}
