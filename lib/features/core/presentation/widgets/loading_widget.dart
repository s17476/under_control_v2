import 'package:flutter/material.dart';

import 'logo_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}
