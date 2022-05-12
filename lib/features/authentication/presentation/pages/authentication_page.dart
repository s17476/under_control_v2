import 'package:flutter/material.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  static const routeName = '/authentication';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('Auth'),
    ));
  }
}
