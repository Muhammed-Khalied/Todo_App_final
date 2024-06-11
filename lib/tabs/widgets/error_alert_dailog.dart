import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorAlertDailog extends StatelessWidget {
  const ErrorAlertDailog({super.key, required this.message});

  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pop(
              context,
            );
          },
          child: const Text(
            'Ok',
            style: TextStyle(fontSize: 15),
          ),
        )
      ],
    );
  }
}
