import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/features/parent_application/bloc/app_parent_bloc.dart';
import 'package:quezzy_app/features/reusable/widgets/flutter_toast.dart';

class AppParentController {
  final BuildContext context;
  const AppParentController({required this.context});

  Future<void> handlePasswordSubmit() async {
    final state = context.read<AppParentBloc>().state;
    String password = state.password;
    String rePassword = state.rePassword;

    if (password.isEmpty) {
      toastInfo(msg: "Password cannot be empty");
      return;
    }

    if (rePassword.isEmpty) {
      toastInfo(msg: "Re-enter password cannot be empty");
      return;
    }
  }
}
