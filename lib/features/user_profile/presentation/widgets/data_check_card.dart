import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/summary_card.dart';
import '../../../core/utils/input_validator.dart';
import '../../../core/utils/size_config.dart';

class DataCheckCard extends StatelessWidget {
  const DataCheckCard({
    Key? key,
    required this.firstNameTexEditingController,
    required this.lastNameTexEditingController,
    required this.phoneNumberTexEditingController,
    this.image,
    required this.pageController,
  }) : super(key: key);

  final TextEditingController firstNameTexEditingController;
  final TextEditingController lastNameTexEditingController;
  final TextEditingController phoneNumberTexEditingController;
  final PageController pageController;
  final File? image;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                width: kIsWeb ? 700 : null,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(
                            height: kIsWeb ? 64 : 16,
                          ),
                          // avatar
                          SummaryCard(
                            title: AppLocalizations.of(context)!
                                .user_details_avatar_updated,
                            validator: () {
                              if (image == null) {
                                return AppLocalizations.of(context)!
                                    .input_validation_no_avatar;
                              }
                              return null;
                            },
                            pageController: pageController,
                            onTapAnimateToPage: 2,
                            child: image != null
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      child: CircleAvatar(
                                        radius: 200,
                                        backgroundColor:
                                            Theme.of(context).cardColor,
                                        backgroundImage: image != null
                                            ? (kIsWeb
                                                    ? NetworkImage(image!.path)
                                                    : FileImage(image!))
                                                as ImageProvider
                                            : null,
                                        child: image == null
                                            ? Text(
                                                '?',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headlineLarge!
                                                      .color,
                                                  fontSize: 100,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              )
                                            : null,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ),

                          const SizedBox(
                            height: 16,
                          ),
                          // first name
                          SummaryCard(
                            title: AppLocalizations.of(context)!
                                .user_profile_add_user_personal_data_first_name,
                            validator: () {
                              if (firstNameTexEditingController.text
                                      .trim()
                                      .length <=
                                  2) {
                                return AppLocalizations.of(context)!
                                    .validation_min_two_characters;
                              } else {
                                return null;
                              }
                            },
                            pageController: pageController,
                            onTapAnimateToPage: 1,
                            child:
                                Text(firstNameTexEditingController.text.trim()),
                          ),

                          const SizedBox(
                            height: 16,
                          ),
                          // last name
                          SummaryCard(
                            title: AppLocalizations.of(context)!
                                .user_profile_add_user_personal_data_last_name,
                            validator: () {
                              if (lastNameTexEditingController.text
                                      .trim()
                                      .length <=
                                  2) {
                                return AppLocalizations.of(context)!
                                    .validation_min_two_characters;
                              } else {
                                return null;
                              }
                            },
                            pageController: pageController,
                            onTapAnimateToPage: 1,
                            child:
                                Text(lastNameTexEditingController.text.trim()),
                          ),
                          const SizedBox(
                            height: 16,
                          ),

                          // phone number
                          SummaryCard(
                            title: AppLocalizations.of(context)!
                                .user_profile_add_user_personal_data_phone_number,
                            validator: () {
                              final result =
                                  InputValidator().phoneNumberFieldValidator(
                                phoneNumberTexEditingController.text.trim(),
                              );
                              if (result != null) {
                                return AppLocalizations.of(context)!
                                    .input_validation_phone_number;
                              }
                              return null;
                            },
                            pageController: pageController,
                            onTapAnimateToPage: 1,
                            child: Text(
                              phoneNumberTexEditingController.text.trim(),
                            ),
                          ),

                          const SizedBox(
                            height: kIsWeb ? 170 : 50,
                          ),
                        ]),
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
