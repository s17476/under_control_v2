import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/responsive_size.dart';
import '../blocs/authentication/authentication_bloc.dart';

class EmailConfirmationPage extends StatefulWidget {
  const EmailConfirmationPage({Key? key}) : super(key: key);

  @override
  State<EmailConfirmationPage> createState() => _EmailConfirmationPageState();
}

class _EmailConfirmationPageState extends State<EmailConfirmationPage>
    with ResponsiveSize {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarBrightness: Brightness.dark,
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.email_confirmation_message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
              ),
              child: ElevatedButton(
                onPressed: () {
                  context.read<AuthenticationBloc>().add(SignoutEvent());
                },
                child: Text(
                  AppLocalizations.of(context)!.email_confirmation_signin_again,
                  style: TextStyle(
                    fontSize:
                        responsiveSizePct(small: 5.5, medium: 3, large: 1),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextButton(
              onPressed: () {
                context
                    .read<AuthenticationBloc>()
                    .add(ResendVerificationEmailEvent());
              },
              child: Text(
                AppLocalizations.of(context)!.email_confirmation_resend_button,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
