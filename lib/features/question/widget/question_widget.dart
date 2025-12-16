//We need context for accessing bloc
import 'package:flutter/material.dart';

Widget textDialog(String text) {
  return Center(
    child: AlertDialog(
      title: Text(text),
    ),
  );
}
