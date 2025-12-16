import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quezzy_app/core/api/student_api.dart';
import 'package:quezzy_app/core/models/entities.dart';
import 'package:quezzy_app/features/student/bloc/student_bloc.dart';
import '../../../core/constant/constants.dart';
import '../../../global.dart';
import '../../reusable/widgets/flutter_toast.dart';

class StudentController {
  late BuildContext context;

  static final StudentController _singleton = StudentController._external();

  StudentController._external();
  //this is a factory constructor
  //makes sure you have the the original only one instance
  factory StudentController({required BuildContext context}) {
    _singleton.context = context;
    return _singleton;
  }

  Future<void> init() async {
    print(Global.storageService.getUserToken());
    if (Global.storageService.getUserToken().isNotEmpty) {
      UserRequestEntity userRequestEntity = UserRequestEntity();
      userRequestEntity.token = Global.storageService.getToken();
      // print('userRequestEntityyyy');
      // print(userRequestEntity.token);
      var result =
          await StudentAPI.studentList(userRequestEntity: userRequestEntity);
      if (result.code == 200) {
        if (context.mounted) {
          context.read<StudentBloc>().add(StudentListItem(result.data!));
          return;
        }
      } else {
        // print(result.code);
        return;
      }
    } else {
      print("User has already logged out1231231232");
    }
    return;
  }

  Future<void> initAvatar() async {
    print("result avatar code");
    print(Global.storageService.getUserToken());
    if (Global.storageService.getUserToken().isNotEmpty) {
      var result = await StudentAPI.avatarList();

      print(result.code);
      if (result.code == 200) {
        if (context.mounted) {
          print("state.avatarItem.length");
          print(result.data!.length);
          context.read<StudentBloc>().add(AvatarListItem(result.data!));
          return;
        }
      } else {
        // print(result.code);
        return;
      }
    } else {
      print("Avatar not found");
    }
    return;
  }

  Future<bool> asyncPostStudentData(
      String name, String password, String avatarUrl) async {
    if (Global.storageService.getUserToken().isNotEmpty) {
      final studentItem = StudentItem();
      studentItem.name = name;
      studentItem.password = password;
      studentItem.avatar = avatarUrl;
      studentItem.userToken = Global.storageService.getToken();
      EasyLoading.show(
          indicator: const CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);
      var result = await StudentAPI.studentCreate(params: studentItem);
      if (result.code == 200) {
        try {
          // Perform any necessary operations for a successful creation
          // ...

          if (context.mounted) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/app_parent", (route) => false);
            EasyLoading.dismiss();
          }

          return true; // Return true to indicate successful student creation
        } catch (e) {
          print("saving local storage error ${e.toString()}");
        }
      } else {
        EasyLoading.dismiss();
        toastInfo(msg: "unknown error");
      }
    }

    return false; // Return false to indicate failed student creation
  }

  Future<bool> asyncPostUpdateStudentData(
      int studentId, String name, String password, String avatarUrl) async {
    if (Global.storageService.getUserToken().isNotEmpty) {
      final studentItem = StudentItem();
      studentItem.id = studentId;
      studentItem.name = name;
      studentItem.password = password;
      studentItem.avatar = avatarUrl;

      studentItem.userToken = Global.storageService.getToken();
      EasyLoading.show(
          indicator: const CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);
      var result = await StudentAPI.studentUpdate(params: studentItem);
      if (result.code == 200) {
        try {
          // Perform any necessary operations for a successful creation
          // ...

          if (context.mounted) {
            toastInfo(msg: "Update Success");
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/app_parent", (route) => false);
            EasyLoading.dismiss();
          }

          return true; // Return true to indicate successful creation
        } catch (e) {
          print("saving local storage error ${e.toString()}");
        }
      } else {
        EasyLoading.dismiss();
        toastInfo(msg: "unknown error");
      }
    }

    return false; // Return false to indicate failed creation
  }

  Future<bool> asyncPostPinNumber(StudentItem stdItem, String pin) async {
    if (Global.storageService.getUserToken().isNotEmpty) {
      //Set student profile
      Global.storageService.setString(
          AppConstants.STORAGE_STUDENT_PROFILE_KEY, jsonEncode(stdItem));

      final studentItem = StudentItem();
      studentItem.id = stdItem.id;
      studentItem.password = pin;

      studentItem.userToken = Global.storageService.getToken();
      EasyLoading.show(
          indicator: const CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);
      var result = await StudentAPI.studentPin(params: studentItem);
      if (result.code == 200) {
        try {
          if (context.mounted) {
            // toastInfo(msg: "Log in Success");
            Navigator.of(context).pushNamedAndRemoveUntil(
              "/package_selected",
              (route) => false,
              arguments: {"id": stdItem.id},
            );
            EasyLoading.dismiss();
          }

          return true; // Return true to indicate successful creation
        } catch (e) {
          print("saving local storage error ${e.toString()}");
        }
      } else if (result.code == 400) {
        EasyLoading.dismiss();
        toastInfo(msg: "Incorrect PIN");
      } else {
        EasyLoading.dismiss();
        toastInfo(msg: "unknown error");
      }
    }

    return false; // Return false to indicate failed creation
  }

  Future<bool> asyncPostResetPinNumber(
      int studentId, String pin, String mainPassword, int type) async {
    if (Global.storageService.getUserToken().isNotEmpty) {
      final studentItem = StudentItem();
      final String? email;

      studentItem.id = studentId;
      studentItem.password = pin;
      studentItem.mainPassword = mainPassword;
      studentItem.userToken = Global.storageService.getToken();

      studentItem.userToken = Global.storageService.getToken();
      email = "\"${Global.storageService.getUserEmail().trim()}\"";
      String cleanEmail = email.replaceAll("\"", "");
      // print("email.trim()");
      // print(email.trim());
      EasyLoading.show(
          indicator: const CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: cleanEmail, password: mainPassword);

      var user = credential.user;
      if (user != null) {
        var result = await StudentAPI.resetPin(params: studentItem);
        if (result.code == 200) {
          try {
            if (context.mounted) {
              if (result.data == 'Success') {
                toastInfo(msg: result.msg);
                if (type == 1) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    "/app_parent",
                    (route) => false,
                    arguments: {"id": studentId},
                  );
                } else {
                  Navigator.pop(context);
                }
              } else {
                toastInfo(msg: result.msg);
              }
              EasyLoading.dismiss();
            }
            return true; // Return true to indicate successful creation
          } catch (e) {
            print("saving local storage error ${e.toString()}");
          }
        } else {
          EasyLoading.dismiss();
          toastInfo(msg: "unknown error");
        }
      }
    }

    return false; // Return false to indicate failed creation
  }
}
