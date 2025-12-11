import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, SnackBar snackBar) {
  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
