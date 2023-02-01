import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../blocs/authentication/authentication_bloc.dart';

class ResetPasswordTextButton extends StatelessWidget {
  const ResetPasswordTextButton({
    Key? key,
    required Animation<Offset>? slideAnimation,
  })  : _slideAnimation = slideAnimation,
        super(key: key);

  final Animation<Offset>? _slideAnimation;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation!,
      child: TextButton(
        onPressed: () {
          final textEditingController = TextEditingController();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                AppLocalizations.of(context)!.password_reset_dialog,
              ),
              content: TextFormField(
                controller: textEditingController,
                key: const ValueKey('password-reset'),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  floatingLabelStyle: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge!.color,
                  ),
                  labelText: 'E-mail',
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                ),
              ),
              actions: [
                TextButton(
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text(
                    AppLocalizations.of(context)!.password_reset_button,
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ),
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(
                          SendPasswordResetEmailEvent(
                            email: textEditingController.text,
                          ),
                        );
                    Navigator.pop(context);
                  },
                ),
              ],
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          );
        },
        child: Text(
          AppLocalizations.of(context)!.password_reset_text_button,
        ),
      ),
    );
  }
}
