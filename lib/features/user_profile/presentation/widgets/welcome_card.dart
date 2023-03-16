import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/logo_widget.dart';
import '../../../core/utils/size_config.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      width: 500,
                      child: FittedBox(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.0),
                          child: Logo(
                            greenLettersSize: 15,
                            whitheLettersSize: 10,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      AppLocalizations.of(context)!
                          .user_profile_add_user_welcome,
                      style: const TextStyle(fontSize: 32),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        width: 800,
                        child: Text(
                          AppLocalizations.of(context)!
                              .user_profile_add_user_personal_data_info,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
