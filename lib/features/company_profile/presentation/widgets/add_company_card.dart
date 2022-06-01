import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/backward_text_button.dart';
import '../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../core/presentation/widgets/forward_text_button.dart';

class AddCompanyCard extends StatelessWidget {
  const AddCompanyCard({
    Key? key,
    required this.pageController,
    required this.nameTexEditingController,
    required this.addressTexEditingController,
    required this.postCodeTexEditingController,
    required this.cityTexEditingController,
    required this.countryTexEditingController,
    required this.vatNumberTexEditingController,
    required this.phoneNumberTexEditingController,
    required this.emailTexEditingController,
    required this.homepageTexEditingController,
    required this.addNewCompany,
  }) : super(key: key);

  final PageController pageController;
  final TextEditingController nameTexEditingController;
  final TextEditingController addressTexEditingController;
  final TextEditingController postCodeTexEditingController;
  final TextEditingController cityTexEditingController;
  final TextEditingController countryTexEditingController;
  final TextEditingController vatNumberTexEditingController;
  final TextEditingController phoneNumberTexEditingController;
  final TextEditingController emailTexEditingController;
  final TextEditingController homepageTexEditingController;
  final Function(BuildContext context) addNewCompany;

  @override
  Widget build(BuildContext context) {
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
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .add_company_intro_card_title,
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                          CustomTextFormField(
                            validator: (val) {
                              if (val!.length < 4) {
                                return AppLocalizations.of(context)!
                                    .add_company_intro_card_to_short;
                              }
                              return null;
                            },
                            fieldKey: 'name',
                            controller: nameTexEditingController,
                            keyboardtype: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            labelText: AppLocalizations.of(context)!
                                .add_company_intro_card_name,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          CustomTextFormField(
                            validator: (val) {
                              if (val!.length < 4) {
                                return AppLocalizations.of(context)!
                                    .add_company_intro_card_to_short;
                              }
                              return null;
                            },
                            fieldKey: 'address',
                            controller: addressTexEditingController,
                            keyboardtype: TextInputType.name,
                            textCapitalization: TextCapitalization.sentences,
                            labelText: AppLocalizations.of(context)!
                                .add_company_intro_card_address,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextFormField(
                            validator: (val) {
                              if (val!.length < 4) {
                                return AppLocalizations.of(context)!
                                    .add_company_intro_card_to_short;
                              }
                              return null;
                            },
                            fieldKey: 'post-code',
                            controller: postCodeTexEditingController,
                            keyboardtype: TextInputType.number,
                            textCapitalization: TextCapitalization.none,
                            labelText: AppLocalizations.of(context)!
                                .add_company_intro_card_postcode,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextFormField(
                            validator: (val) {
                              if (val!.length < 4) {
                                return AppLocalizations.of(context)!
                                    .add_company_intro_card_to_short;
                              }
                              return null;
                            },
                            fieldKey: 'city',
                            controller: cityTexEditingController,
                            keyboardtype: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            labelText: AppLocalizations.of(context)!
                                .add_company_intro_card_city,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextFormField(
                            validator: (val) {
                              if (val!.length < 2) {
                                return AppLocalizations.of(context)!
                                    .add_company_intro_card_to_short;
                              }
                              return null;
                            },
                            fieldKey: 'country',
                            controller: countryTexEditingController,
                            keyboardtype: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            labelText: AppLocalizations.of(context)!
                                .add_company_intro_card_country,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextFormField(
                            validator: (val) {
                              if (val!.length < 4) {
                                return AppLocalizations.of(context)!
                                    .add_company_intro_card_to_short;
                              }
                              return null;
                            },
                            fieldKey: 'vat',
                            controller: vatNumberTexEditingController,
                            keyboardtype: TextInputType.text,
                            textCapitalization: TextCapitalization.characters,
                            labelText: AppLocalizations.of(context)!
                                .add_company_intro_card_vat_number,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextFormField(
                            validator: (val) {
                              if (val!.length < 4) {
                                return AppLocalizations.of(context)!
                                    .add_company_intro_card_to_short;
                              }
                              return null;
                            },
                            fieldKey: 'phone',
                            controller: phoneNumberTexEditingController,
                            keyboardtype: TextInputType.number,
                            textCapitalization: TextCapitalization.none,
                            labelText: AppLocalizations.of(context)!
                                .add_company_intro_card_phone_number,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextFormField(
                            validator: (val) {
                              if (val!.length < 4) {
                                return AppLocalizations.of(context)!
                                    .add_company_intro_card_to_short;
                              }
                              return null;
                            },
                            fieldKey: 'email',
                            controller: emailTexEditingController,
                            keyboardtype: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,
                            labelText: AppLocalizations.of(context)!
                                .add_company_intro_card_email,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextFormField(
                            validator: (val) {
                              if (val!.length < 4) {
                                return AppLocalizations.of(context)!
                                    .add_company_intro_card_to_short;
                              }
                              return null;
                            },
                            fieldKey: 'homepage',
                            controller: homepageTexEditingController,
                            keyboardtype: TextInputType.url,
                            textCapitalization: TextCapitalization.none,
                            labelText: AppLocalizations.of(context)!
                                .add_company_intro_card_homepage,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackwardTextButton(
                        icon: Icons.cancel,
                        color: Theme.of(context).textTheme.headline4!.color!,
                        label: AppLocalizations.of(context)!.cancel,
                        function: () => Navigator.pop(context),
                      ),
                      ForwardTextButton(
                        color: Theme.of(context).textTheme.headline5!.color!,
                        label: AppLocalizations.of(context)!.add,
                        function: () => addNewCompany(context),
                        icon: Icons.check,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
