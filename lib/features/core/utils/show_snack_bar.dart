import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

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
}) async {
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
        duration: const Duration(seconds: 3),
      ),
    );

  if (await Vibration.hasVibrator() ?? false) {
    // error message
    if (isErrorMessage) {
      if (await Vibration.hasCustomVibrationsSupport() ?? false) {
        Vibration.vibrate(
          pattern: [0, 100, 30, 100, 30, 100],
        );
      } else {
        Vibration.vibrate();
        await Future.delayed(const Duration(milliseconds: 50));
        Vibration.vibrate();
      }
      // success message
    } else {
      if (await Vibration.hasCustomVibrationsSupport() ?? false) {
        Vibration.vibrate(duration: 50);
      } else {
        Vibration.vibrate();
      }
    }
  }
}
