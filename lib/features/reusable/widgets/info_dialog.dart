import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  final String title;

  const InfoDialog({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: Text(title),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text(
              'OK',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
