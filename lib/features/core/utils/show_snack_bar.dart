import 'package:flutter/material.dart';

/// shows SnackBar
///
/// 'message' argument is SnackBar's content
/// 'isErrorMessage' argument defines background color
/// true - primary color
/// false - error color
void showSnackBar({
  required BuildContext context,
  required String message,
  bool isErrorMessage = false,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: isErrorMessage
            ? Theme.of(context).errorColor
            : const Color.fromARGB(255, 28, 154, 97),
      ),
    );
}
