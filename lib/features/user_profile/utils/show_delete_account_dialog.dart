import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/utils/show_snack_bar.dart';

import '../../assets/presentation/widgets/asset_status_dropdown_button.dart';
import '../../assets/utils/asset_status.dart';
import '../../core/presentation/widgets/glass_layer.dart';

Future<dynamic> showDeleteAccountDialog({
  required BuildContext context,
  required String name,
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
                    minLines: 1,
                    maxLines: 6,
                    onChanged: (value) {
                      answer = value;
                    },
                    validator: (value) {
                      if (value!.trim().toLowerCase() !=
                          name.trim().toLowerCase()) {
                        return '${AppLocalizations.of(context)!.user_details_delete_validation} $name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!
                          .user_profile_add_user_personal_data_first_name,
                    ),
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
                  if (formKey.currentState!.validate() &&
                      (name.trim().toLowerCase() ==
                          answer.trim().toLowerCase())) {
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
