import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/responsive_size.dart';
import '../../../core/utils/size_config.dart';

class DataCheckCard extends StatelessWidget with ResponsiveSize {
  const DataCheckCard({
    Key? key,
    required this.firstNameTexEditingController,
    required this.lastNameTexEditingController,
    required this.phoneNumberTexEditingController,
    this.image,
  }) : super(key: key);

  final TextEditingController firstNameTexEditingController;
  final TextEditingController lastNameTexEditingController;
  final TextEditingController phoneNumberTexEditingController;

  final File? image;

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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: responsiveSizeVerticalPct(
                                    small: 12, medium: 5),
                              ),
                              // avatar
                              SizedBox(
                                height:
                                    responsiveSizePct(small: 70, medium: 20),
                                width: responsiveSizePct(small: 70, medium: 20),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // shows avatar background only in portrait mode
                                    if (MediaQuery.of(context).orientation ==
                                        Orientation.portrait)
                                      Image.asset(
                                        'assets/undercontrol-without-frame.png',
                                        fit: BoxFit.fill,
                                      ),
                                    CircleAvatar(
                                      radius: responsiveSizePct(small: 22.5),
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    CircleAvatar(
                                      radius: responsiveSizePct(
                                          small: 22, medium: 15),
                                      backgroundColor:
                                          Theme.of(context).errorColor,
                                      backgroundImage: image != null
                                          ? FileImage(image!)
                                          : null,
                                      child: image == null
                                          ? Text(
                                              '?',
                                              style: TextStyle(
                                                fontSize: responsiveSizePct(
                                                    small: 20, medium: 10),
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            )
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: responsiveSizePct(small: 15, medium: 3),
                              ),
                              // first name
                              const Divider(),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .user_profile_add_user_personal_data_first_name,
                                  style: Theme.of(context).textTheme.caption,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Text(firstNameTexEditingController.text),
                              const SizedBox(
                                height: 8,
                              ),
                              // last name
                              const Divider(),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .user_profile_add_user_personal_data_last_name,
                                  style: Theme.of(context).textTheme.caption,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Text(lastNameTexEditingController.text),
                              const SizedBox(
                                height: 8,
                              ),
                              // phone number
                              const Divider(),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .user_profile_add_user_personal_data_phone_number,
                                  style: Theme.of(context).textTheme.caption,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Text(phoneNumberTexEditingController.text),
                              const SizedBox(
                                height: 8,
                              ),
                              const Divider(),
                            ]),
                      ),
                    ),
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
