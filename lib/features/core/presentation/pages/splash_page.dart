import 'package:flutter/material.dart';

import '../widgets/logo_widget.dart';
import '../../utils/custom_page_transition.dart';
import '../../utils/size_config.dart';

class SplashPage extends StatelessWidget with CustomPageTransition {
  const SplashPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Expanded(
            child: Center(
              child: Logo(greenLettersSize: 15, whitheLettersSize: 10),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text('LNA Software'),
          ),
        ],
      ),
    );
  }
}
