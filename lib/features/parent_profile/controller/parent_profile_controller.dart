import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ta_plus/core/api/student_api.dart';
import 'package:flutter_ta_plus/core/api/user_api.dart';
import 'package:flutter_ta_plus/core/models/user.dart';
import 'package:flutter_ta_plus/features/parent_profile/bloc/parent_profile_bloc.dart';
import 'package:flutter_ta_plus/features/reusable/widgets/flutter_toast.dart';
import '../../../global.dart';

class ParentProfileController {
  late BuildContext context;
  ParentProfileController({required this.context});
  var auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  Future<void> initAvatar() async {
    if (Global.storageService.getUserToken().isNotEmpty) {
      var result = await StudentAPI.avatarList();

      if (result.code == 200) {
        if (context.mounted) {
          context.read<ParentProfileBloc>().add(AvatarListEvent(result.data!));
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

  Future<void> changePassword() async {
    final state = context.read<ParentProfileBloc>().state;
    String oldPassword = state.oldPassword ?? '';
    String newPassword = state.newPassword ?? '';
    String reNewPassword = state.newRePassword ?? '';

    final userItem = UserItem();

    userItem.password = oldPassword;
    userItem.newPassword = newPassword;
    userItem.token = Global.storageService.getUserProfile().token;

    if (oldPassword.isEmpty) {
      toastInfo(msg: "Sila masukkan kata laluan lama");
      return;
    }

    if (newPassword.isEmpty) {
      toastInfo(msg: "Sila masukkan kata laluan baru");
      return;
    }

    if (reNewPassword.isEmpty) {
      toastInfo(msg: "Sila ulang kata laluan baru");
      return;
    }

    if (newPassword.toString() != reNewPassword.toString()) {
      toastInfo(msg: "Password not same");
      return;
    }
    EasyLoading.show(
        indicator: const CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: false);
    var result = await UserAPI.checkPassword(params: userItem);

    if (result.code == 200) {
      try {
        if (context.mounted) {
          if (result.data == 'Success') {
            try {
              final credential = EmailAuthProvider.credential(
                email: Global.storageService.getUserProfile().email!,
                password: state.oldPassword!,
              );

              // Re-authenticate the current user to check if the credential is valid
              await currentUser!
                  .reauthenticateWithCredential(credential)
                  .then((value) async {
                // If successful, the old password is correct
                //toastInfo(msg: "Old password is valid.");
                await currentUser!.updatePassword(newPassword);

                // Update MySQL database
                var result = await UserAPI.updatePassword(params: userItem);
                if (result.data == 'Success') {
                  try {
                    // Perform any necessary operations after a successful update
                    toastInfo(msg: result.msg);

                    // If the context is still valid, close the modal and dismiss any loading indicators
                    if (context.mounted) {
                      Navigator.pop(
                          context); // Navigate back or close the modal
                      EasyLoading.dismiss(); // Dismiss loading spinner
                    }

                    return; // Return true to indicate success
                  } catch (e) {
                    print("Error saving local storage: ${e.toString()}");
                  }
                } else {
                  // Handle failure of MySQL update
                  EasyLoading.dismiss();
                  toastInfo(msg: "Error updating password in database.");
                }

                // Proceed with updating the password or other actions
              }).catchError((error) {
                // If there is an error, handle it (e.g., incorrect old password)
                toastInfo(msg: "Old password is incorrect.");
              });
            } on FirebaseAuthException catch (e) {
              // Handle specific Firebase authentication errors
              if (e.code == 'user-mismatch') {
                toastInfo(
                    msg: "The credentials do not match the current user.");
              } else {
                toastInfo(msg: "Authentication error: ${e.message}");
              }
            }
          } else {
            // Handle MySQL password validation failure
            toastInfo(msg: result.msg);
          }
          EasyLoading
              .dismiss(); // Ensure loading is dismissed if any error happens
        }
        return;
      } catch (e) {
        // Handle any unexpected errors
        EasyLoading.dismiss();
        toastInfo(msg: e.toString());
      }
    } else {
      // Handle the case where the initial result from the API was not successful
      EasyLoading.dismiss();
      toastInfo(msg: "Unknown error occurred.");
    }
  }

  // Future<bool> asyncPostUpdateStudentData(int studentId, String name,
  //     String schoolName, String? password, String avatarUrl) async {
  //   if (Global.storageService.getUserToken().isNotEmpty) {
  //     final studentItem = StudentItem();
  //     studentItem.id = studentId;
  //     studentItem.name = name;
  //     studentItem.schoolName = schoolName;
  //     studentItem.token = Global.storageService.getStudentProfile().token;
  //     if (password!.isNotEmpty) {
  //       studentItem.password = password;
  //     }
  //     studentItem.avatar = avatarUrl;

  //     studentItem.userToken = Global.storageService.getToken();
  //     EasyLoading.show(
  //         indicator: const CircularProgressIndicator(),
  //         maskType: EasyLoadingMaskType.clear,
  //         dismissOnTap: true);
  //     var result = await StudentAPI.studentUpdate(params: studentItem);
  //     if (result.code == 200) {
  //       try {
  //         if (context.mounted) {
  //           context
  //               .read<ProfileBloc>()
  //               .add(TriggerInitialStudentItemEvent(studentItem));
  //           Global.storageService.setString(
  //               AppConstants.STORAGE_STUDENT_PROFILE_KEY,
  //               jsonEncode(studentItem));
  //           // Global.storageService.setString(
  //           //     AppConstants.STORAGE_STUDENT_PROFILE_KEY,
  //           //     jsonEncode(studentItem));
  //           toastInfo(msg: "Kemaskini Berjaya");
  //           // Navigator.of(context)
  //           //     .pushNamedAndRemoveUntil("/app_parent", (route) => false);
  //           EasyLoading.dismiss();
  //         }

  //         return true; // Return true to indicate successful creation
  //       } catch (e) {
  //         print("saving local storage error ${e.toString()}");
  //       }
  //     } else {
  //       EasyLoading.dismiss();
  //       toastInfo(msg: "unknown error");
  //     }
  //   }

  //   return false; // Return false to indicate failed creation
  // }
}
