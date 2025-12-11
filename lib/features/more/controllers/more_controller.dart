import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ta_plus/core/api/package_api.dart';
import 'package:flutter_ta_plus/core/api/student_api.dart';
import 'package:flutter_ta_plus/core/api/user_api.dart';
import 'package:flutter_ta_plus/core/models/entities.dart';
import 'package:flutter_ta_plus/core/models/subscribe.dart';
import 'package:flutter_ta_plus/features/application/bloc/app_bloc.dart';
import 'package:flutter_ta_plus/features/more/bloc/more_bloc.dart';
import '../../../core/constant/constants.dart';
import '../../../global.dart';
import '../../reusable/widgets/flutter_toast.dart';

class MoreController {
  late BuildContext context;

  static final MoreController _singleton = MoreController._external();

  MoreController._external();
  //this is a factory constructor
  //makes sure you have the the original only one instance
  factory MoreController({required BuildContext context}) {
    _singleton.context = context;
    return _singleton;
  }

  void init() {
    initStudent();
    initSubscribe();
  }

  Future<void> initStudent() async {
    // print(Global.storageService.getUserToken());
    if (Global.storageService.getUserToken().isNotEmpty) {
      UserRequestEntity userRequestEntity = UserRequestEntity();
      userRequestEntity.token = Global.storageService.getToken();
      var result =
          await StudentAPI.studentList(userRequestEntity: userRequestEntity);
      if (result.code == 200) {
        if (context.mounted) {
          context.read<MoreBloc>().add(StudentListItem(result.data!));
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

  Future<void> initSubscribe() async {
    // print("Global.storageService.getStudentId().toString()");
    // print(Global.storageService.getStudentId().toString());
    if (Global.storageService.getUserToken().isNotEmpty) {
      SubscribeRequestEntity subscribeRequestEntity = SubscribeRequestEntity();
      subscribeRequestEntity.student_id =
          Global.storageService.getStudentProfile().id;
      subscribeRequestEntity.is_payment = 1;

      var result = await PackageAPI.subscribeList(subscribeRequestEntity);
      if (result.code == 200) {
        if (context.mounted) {
          context.read<MoreBloc>().add(SubscribeListItem(result.data!));
          return;
        }
      } else {
        return;
      }
    } else {
      print("User has already logged out");
    }
    return;
  }

  void removeStudentData() {
    context.read<AppBloc>().add(const TriggerAppEvent(0));
    Global.storageService.remove(AppConstants.STORAGE_STUDENT_PROFILE_KEY);
    Global.storageService.remove(AppConstants.STORAGE_STUDENT_ID);
    Global.storageService.remove(AppConstants.STORAGE_TOPIC_KEY);
  }

  Future<bool> asyncPostParentPassword(String password) async {
    if (Global.storageService.getUserToken().isNotEmpty) {
      final userItem = UserItem();
      final String? email;

      userItem.password = password;
      userItem.token = Global.storageService.getToken();

      email = "\"${Global.storageService.getUserEmail().trim()}\"";
      String cleanEmail = email.replaceAll("\"", "");
      EasyLoading.show(
          indicator: const CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);

      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: cleanEmail, password: password);

      var user = credential.user;
      if (user != null) {
        removeStudentData();
        var result = await UserAPI.checkPassword(params: userItem);
        if (result.code == 200) {
          try {
            if (context.mounted) {
              if (result.data == 'Success') {
                toastInfo(msg: result.msg);

                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/app_parent",
                  (route) => false,
                  // arguments: {"id": studentId},
                );
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
