import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotApprovedPage extends StatelessWidget {
  const NotApprovedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime preBackpress = DateTime.now();
    return WillPopScope(
      // double click to exit the app
      onWillPop: () async {
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();
        if (cantExit) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(
                AppLocalizations.of(context)!.back_to_exit,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.black,
            ));
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: Container(
          child: Center(child: Text('Not approved')),
        ),
      ),
    );
  }
}
