import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/presentation/widgets/custom_text_form_field.dart';
import '../data/models/user_profile_model.dart';
import '../domain/entities/user_profile.dart';
import '../presentation/blocs/user_management/user_management_bloc.dart';

Future<void> showEditUserModalBottomSheet({
  required BuildContext context,
  required UserProfile user,
}) {
  final GlobalKey<FormState> formKey = GlobalKey();

  UserProfileModel updatedUser = user as UserProfileModel;

  return showModalBottomSheet<void>(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 350,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  bottom: 4,
                ),
                child: Text(
                  AppLocalizations.of(context)!.user_details_edit_data,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              const Divider(),
              Expanded(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Column(
                            children: [
                              // parent name
                              CustomTextFormField(
                                fieldKey: 'userName',
                                labelText: AppLocalizations.of(context)!
                                    .user_profile_add_user_personal_data_first_name,
                                textCapitalization: TextCapitalization.words,
                                initialValue: user.firstName,
                                prefixIcon: const Icon(Icons.person),
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 2) {
                                    return AppLocalizations.of(context)!
                                        .validation_min_two_characters;
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  updatedUser = updatedUser.copyWith(
                                      firstName: value?.trim());
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // location name
                              CustomTextFormField(
                                fieldKey: 'lastName',
                                keyboardType: TextInputType.name,
                                initialValue: user.lastName,
                                prefixIcon: const Icon(Icons.person_outline),
                                labelText: AppLocalizations.of(context)!
                                    .user_profile_add_user_personal_data_last_name,
                                textCapitalization: TextCapitalization.words,
                                onSaved: (value) {
                                  updatedUser = updatedUser.copyWith(
                                      lastName: value?.trim());
                                },
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 2) {
                                    return AppLocalizations.of(context)!
                                        .validation_min_two_characters;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // phone number
                              CustomTextFormField(
                                fieldKey: 'phoneNumber',
                                keyboardType: TextInputType.phone,
                                initialValue: user.phoneNumber,
                                prefixIcon: const Icon(Icons.phone),
                                labelText: AppLocalizations.of(context)!
                                    .user_profile_add_user_personal_data_phone_number,
                                onSaved: (value) {
                                  updatedUser = updatedUser.copyWith(
                                      phoneNumber: value?.trim());
                                },
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 8) {
                                    return AppLocalizations.of(context)!
                                        .input_validation_phone_number;
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Text(
                          AppLocalizations.of(context)!.cancel,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextButton(
                        child: Text(
                          AppLocalizations.of(context)!
                              .user_profile_add_user_personal_data_save,
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          formKey.currentState!.save();

                          context.read<UserManagementBloc>().add(
                                UpdateUserDataEvent(userProfile: updatedUser),
                              );

                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
