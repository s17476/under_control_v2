import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/presentation/pages/authentication_page.dart';
import 'home_page.dart';
import '../widgets/logo_widget.dart';
import '../../utils/custom_page_transition.dart';
import '../../../authentication/presentation/blocs/authentication/authentication_bloc.dart';
import '../../utils/size_config.dart';

class SplashPage extends StatelessWidget with CustomPageTransition {
  const SplashPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) async {
        await Future.delayed(const Duration(milliseconds: 1500));
        if (state is Authenticated) {
          Navigator.of(context).pushReplacement(
            fadeIn(
              () => const HomePage(),
              const Duration(milliseconds: 3000),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            fadeIn(
              () => const AuthenticationPage(),
              const Duration(milliseconds: 1500),
            ),
          );
        }
      },
      builder: (context, state) {
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
      },
    );
  }
}
