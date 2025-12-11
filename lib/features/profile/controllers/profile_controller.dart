import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ta_plus/core/api/student_api.dart';
import 'package:flutter_ta_plus/core/constant/constants.dart';
import 'package:flutter_ta_plus/core/models/entities.dart';
import 'package:flutter_ta_plus/features/profile/bloc/profile_bloc.dart';
import '../../../global.dart';
import '../../reusable/widgets/flutter_toast.dart';

class ProfileController {
  late BuildContext context;
  ProfileController({required this.context});

  Future<void> initAvatar() async {
    if (Global.storageService.getUserToken().isNotEmpty) {
      var result = await StudentAPI.avatarList();

      if (result.code == 200) {
        if (context.mounted) {
          context.read<ProfileBloc>().add(AvatarListEvent(result.data!));
          return;
        }
      } else {
        return;
      }
    } else {
      return;
      // print("Avatar not found");
    }
    return;
  }

  Future<bool> asyncPostUpdateStudentData(int studentId, String name,
      String schoolName, String? password, String avatarUrl) async {
    if (Global.storageService.getUserToken().isNotEmpty) {
      final studentItem = StudentItem();
      studentItem.id = studentId;
      studentItem.name = name;
      studentItem.schoolName = schoolName;
      studentItem.token = Global.storageService.getStudentProfile().token;
      if (password!.isNotEmpty) {
        studentItem.password = password;
      }
      studentItem.avatar = avatarUrl;

      studentItem.userToken = Global.storageService.getToken();
      EasyLoading.show(
          indicator: const CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);
      var result = await StudentAPI.studentUpdate(params: studentItem);
      if (result.code == 200) {
        try {
          if (context.mounted) {
            context
                .read<ProfileBloc>()
                .add(TriggerInitialStudentItemEvent(studentItem));
            Global.storageService.setString(
                AppConstants.STORAGE_STUDENT_PROFILE_KEY,
                jsonEncode(studentItem));
            // Global.storageService.setString(
            //     AppConstants.STORAGE_STUDENT_PROFILE_KEY,
            //     jsonEncode(studentItem));
            toastInfo(msg: "Kemaskini Berjaya");
            // Navigator.of(context)
            //     .pushNamedAndRemoveUntil("/app_parent", (route) => false);
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
}
