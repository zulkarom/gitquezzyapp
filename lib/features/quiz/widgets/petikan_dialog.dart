import 'package:flutter/material.dart';

class PetikanDialog extends StatelessWidget {
  final String content;

  const PetikanDialog({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Petikan"),
      content: SingleChildScrollView(
        child: Text(
          content,
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
