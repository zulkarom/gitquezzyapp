import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/core/api/student_api.dart';
import 'package:quezzy_app/core/bloc/avatar/avatar_bloc.dart';
import '../../../global.dart';

class CommonController {
  late BuildContext context;

  static final CommonController _singleton = CommonController._external();

  CommonController._external();
  //this is a factory constructor
  //makes sure you have the the original only one instance
  factory CommonController({required BuildContext context}) {
    _singleton.context = context;
    return _singleton;
  }

  Future<void> initAvatar() async {
    if (Global.storageService.getUserToken().isNotEmpty) {
      var result = await StudentAPI.avatarList();

      if (result.code == 200) {
        if (context.mounted) {
          context.read<AvatarBloc>().add(AvatarListEvent(result.data!));
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
}
