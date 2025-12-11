import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../core/api/student_api.dart';
import '../core/models/student.dart';
import '../features/reusable/widgets/flutter_toast.dart';
import '../global.dart';

class AuthRepository {
  Future asyncPostStudentData(String name, String password) async {
    if (Global.storageService.getUserToken().isNotEmpty) {
      final studentItem = StudentItem();
      studentItem.name = name;
      studentItem.password = password;
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

          return true; // Return true to indicate successful student creation
        } catch (e) {
          print("saving local storage error ${e.toString()}");
        }
      } else {
        EasyLoading.dismiss();
        toastInfo(msg: "unknown error");
      }
    }
  }
}
