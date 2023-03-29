import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/utils/show_snack_bar.dart';

import '../../assets/presentation/widgets/asset_status_dropdown_button.dart';
import '../../assets/utils/asset_status.dart';
import '../../authentication/presentation/blocs/authentication/authentication_bloc.dart';
import '../../core/presentation/widgets/glass_layer.dart';

Future<dynamic> showDeleteAccountDialog({
  required BuildContext context,
}) {
  final formKey = GlobalKey<FormState>();
  String answer = '';
  return showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (context) => StatefulBuilder(builder: (context, setInnerState) {
      return Material(
        color: Colors.transparent,
        child: GlassLayer(
          onDismiss: () => Navigator.pop(context),
          child: AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              AppLocalizations.of(context)!.user_details_delete,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.user_details_delete_info,
                ),
                const SizedBox(
                  height: 4,
                ),
                Form(
                  key: formKey,
                  child: TextFormField(
                    onChanged: (value) {
                      answer = value;
                    },
                    validator: (value) {
                      final result = RegExp(
                        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$',
                      ).hasMatch(value!.trim());
                      if (result) {
                        return null;
                      } else {
                        return AppLocalizations.of(context)!
                            .password_validation;
                      }
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      errorMaxLines: 5,
                      hintText: AppLocalizations.of(context)!.password,
                    ),
                    obscureText: true,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!
                      .user_profile_add_user_personal_data_back,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge!.color,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.confirm,
                  style: const TextStyle(
                    color: Colors.amber,
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context
                        .read<AuthenticationBloc>()
                        .add(DeleteAccountEvent(password: answer));
                    Navigator.pop(context, true);
                  }
                },
              ),
            ],
          ),
        ),
      );
    }),
  );
}
