import 'package:flutter/material.dart';

import '../widgets/logo_widget.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          FittedBox(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Logo(greenLettersSize: 15, whitheLettersSize: 10),
            ),
          ),
          CircularProgressIndicator(),
        ],
      ),
    ));
  }
}
