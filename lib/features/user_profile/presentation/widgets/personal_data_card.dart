import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bottom_navigation.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../core/utils/size_config.dart';

class PersonalDataCard extends StatelessWidget with ResponsiveSize {
  const PersonalDataCard({
    Key? key,
    required this.pageController,
    required this.firstNameTexEditingController,
    required this.lastNameTexEditingController,
    required this.phoneNumberTexEditingController,
  }) : super(key: key);

  final PageController pageController;
  final TextEditingController firstNameTexEditingController;
  final TextEditingController lastNameTexEditingController;
  final TextEditingController phoneNumberTexEditingController;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height:
                                responsiveSizeVerticalPct(small: 5, medium: 10),
                          ),
                          if (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 48.0,
                                right: 48.0,
                                top: 48,
                                bottom: 48,
                              ),
                              child: Image.asset(
                                'assets/person.png',
                              ),
                            ),
                          // first name
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  responsiveSizePx(small: 16, medium: 150),
                            ),
                            child: TextFormField(
                              controller: firstNameTexEditingController,
                              key: const ValueKey('firstName'),
                              keyboardType: TextInputType.name,
                              // textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person),
                                floatingLabelStyle: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1!
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
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  responsiveSizePx(small: 16, medium: 150),
                            ),
                            child: TextFormField(
                              controller: lastNameTexEditingController,
                              key: const ValueKey('lastName'),
                              keyboardType: TextInputType.name,
                              // textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person_outline),
                                floatingLabelStyle: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1!
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
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  responsiveSizePx(small: 16, medium: 150),
                            ),
                            child: TextFormField(
                              controller: phoneNumberTexEditingController,
                              key: const ValueKey('phoneNumber'),
                              keyboardType: TextInputType.phone,
                              // textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.phone),
                                floatingLabelStyle: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1!
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
                        ],
                      ),
                    ),
                  ),
                ),
                BottomNavigation(pageController: pageController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
