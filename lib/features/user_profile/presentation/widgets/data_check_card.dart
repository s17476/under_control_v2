import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/summary_card.dart';
import '../../../core/utils/input_validator.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../core/utils/size_config.dart';

class DataCheckCard extends StatelessWidget with ResponsiveSize {
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
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          height: 16,
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
                          child: image != null
                              ? CircleAvatar(
                                  radius: responsiveSizePct(small: 45),
                                  backgroundImage: FileImage(image!),
                                )
                              : const SizedBox(),
                          pageController: pageController,
                          onTapAnimateToPage: 2,
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
                          child:
                              Text(firstNameTexEditingController.text.trim()),
                          pageController: pageController,
                          onTapAnimateToPage: 1,
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
                          child: Text(lastNameTexEditingController.text.trim()),
                          pageController: pageController,
                          onTapAnimateToPage: 1,
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
                          child: Text(
                            phoneNumberTexEditingController.text.trim(),
                          ),
                          pageController: pageController,
                          onTapAnimateToPage: 1,
                        ),

                        const SizedBox(
                          height: 16,
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
