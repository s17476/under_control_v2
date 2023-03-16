import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/utils/size_config.dart';

class PersonalDataCard extends StatelessWidget {
  const PersonalDataCard({
    Key? key,
    required this.firstNameTexEditingController,
    required this.lastNameTexEditingController,
    required this.phoneNumberTexEditingController,
  }) : super(key: key);

  final TextEditingController firstNameTexEditingController;
  final TextEditingController lastNameTexEditingController;
  final TextEditingController phoneNumberTexEditingController;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: SizedBox(
                width: 500,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 48.0,
                          right: 48.0,
                          top: ResponsiveValue(
                            context,
                            defaultValue: 48,
                            valueWhen: [
                              const Condition.largerThan(
                                name: TABLET,
                                value: 16,
                              ),
                            ],
                          ).value!.toDouble(),
                          bottom: 48,
                        ),
                        child: Image.asset(
                          'assets/person.png',
                        ),
                      ),
                      // first name
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: TextFormField(
                          scrollPadding: const EdgeInsets.only(bottom: 500),
                          controller: firstNameTexEditingController,
                          key: const ValueKey('firstName'),
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          // textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            floatingLabelStyle: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color,
                            ),
                            labelText: AppLocalizations.of(context)!
                                .user_profile_add_user_personal_data_first_name,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // last name
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: TextFormField(
                          scrollPadding: const EdgeInsets.only(bottom: 500),
                          controller: lastNameTexEditingController,
                          key: const ValueKey('lastName'),
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person_outline),
                            floatingLabelStyle: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color,
                            ),
                            labelText: AppLocalizations.of(context)!
                                .user_profile_add_user_personal_data_last_name,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      // phone number
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: TextFormField(
                          scrollPadding: const EdgeInsets.only(bottom: 500),
                          controller: phoneNumberTexEditingController,
                          key: const ValueKey('phoneNumber'),
                          keyboardType: TextInputType.phone,
                          // textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone),
                            floatingLabelStyle: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color,
                            ),
                            labelText: AppLocalizations.of(context)!
                                .user_profile_add_user_personal_data_phone_number,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: kIsWeb ? 170 : 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
