import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  bool showExitButton = false,
}) async {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: SizedBox(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
          ),
        ),
        action: showExitButton
            ? SnackBarAction(
                label: AppLocalizations.of(context)!.exit,
                onPressed: () => Navigator.pop(context),
                textColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
                disabledTextColor: Colors.grey,
              )
            : null,
        backgroundColor: isErrorMessage
            ? Theme.of(context).colorScheme.error
            : const Color.fromARGB(255, 28, 154, 97),
        duration: Duration(seconds: isErrorMessage ? 3 : 1),
      ),
    );

  if (!kIsWeb && (await Vibration.hasVibrator() ?? false)) {
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
