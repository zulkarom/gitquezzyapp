import 'package:flutter/material.dart';

import '../features/reusable/widgets/page_loading_spinner.dart';

Future<dynamic> showLoadingSpinner(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: PageLoadingSpinner(),
        ),
      );
    },
  );
}
