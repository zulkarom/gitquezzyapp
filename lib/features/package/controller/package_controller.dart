import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quezzy_app/core/api/package_api.dart';
import 'package:quezzy_app/core/models/subscribe.dart';
import '../../../global.dart';
import '../../reusable/widgets/flutter_toast.dart';
import '../bloc/package_bloc.dart';

class PackageController {
  late BuildContext context;

  static final PackageController _singleton = PackageController._external();

  PackageController._external();
  //this is a factory constructor
  //makes sure you have the the original only one instance
  factory PackageController({required BuildContext context}) {
    _singleton.context = context;
    return _singleton;
  }

  Future<void> init() async {
    // final studentId = ModalRoute.of(context)!.settings.arguments as Map;
    // print("args");
    // print(studentId);
    if (Global.storageService.getUserToken().isNotEmpty) {
      var result = await PackageAPI.packageList();
      if (result.code == 200) {
        if (context.mounted) {
          context.read<PackageBloc>().add(PackageListItem(result.data!));
          return;
        }
      } else {
        print(result.code);
        return;
      }
    } else {
      print("User has already logged out");
    }
    return;
  }

  Future<void> initSubscribe(int? studentId) async {
    // final studentId = ModalRoute.of(context)!.settings.arguments as Map;
    // print("args");
    // print(studentId);
    if (Global.storageService.getUserToken().isNotEmpty) {
      SubscribeRequestEntity subscribeRequestEntity = SubscribeRequestEntity();
      subscribeRequestEntity.student_id = studentId!;
      subscribeRequestEntity.is_payment = 0;

      var result = await PackageAPI.subscribeList(subscribeRequestEntity);
      if (result.code == 200) {
        if (context.mounted) {
          context.read<PackageBloc>().add(SubscribeListItem(result.data!));
          return;
        }
      } else {
        return;
      }
    } else {
      print("error subscribes init");
    }
    return;
  }

  Future<bool> asyncPostSubscribeData(int? studentId, int? packageId) async {
    if (Global.storageService.getUserToken().isNotEmpty) {
      final subscribeItem = SubscribeItem();
      subscribeItem.student_id = studentId;
      subscribeItem.package_id = packageId;

      // print("packageId");
      // print(packageId);

      EasyLoading.show(
          indicator: const CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);
      var result = await PackageAPI.addPackage(params: subscribeItem);
      // print(result.code);
      if (result.code == 200) {
        try {
          // Perform any necessary operations for a successful creation
          // ...
          // print("studentId.toString()");
          // print(studentId.toString());
          if (context.mounted) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                "/package_selected", (route) => false,
                arguments: {"id": studentId});
            EasyLoading.dismiss();
          }

          return true; // Return true to indicate successful student creation
        } catch (e) {
          print("saving local storage error ${e.toString()}");
        }
      } else if (result.code == 409) {
        EasyLoading.dismiss();
        toastInfo(msg: "You already subscribed this package");
      } else {
        EasyLoading.dismiss();
        toastInfo(msg: "unknown error");
      }
    }

    return false; // Return false to indicate failed student creation
  }
}
