import 'package:flutter/material.dart';
import '../features/reusable/widgets/custom_snack_bar.dart';
import 'show_loading_spinner.dart';
import 'show_snackbar.dart';

void showInvalidSessionSnackbar(BuildContext context) {
  showSnackBar(
    context,
    customSnackBar(
      content: 'Invalid session. Redirecting to login screen ...',
      context: context,
    ),
  );

  Future.delayed(const Duration(seconds: 3), () {
    // context.read<AuthBloc>().add(
    //       Logout(
    //         context.read<ToRememberBloc>().state.toRemember,
    //         true,
    //       ),
    //     );

    while (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }

    showLoadingSpinner(context);
  });
}
