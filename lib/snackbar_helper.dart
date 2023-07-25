import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message,
    {bool isError = false}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: isError ? Colors.red : Colors.green,
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: 'Kapat',
      disabledTextColor: Colors.white,
      textColor: Colors.yellow,
      onPressed: () {
        // Do whatever you want
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
