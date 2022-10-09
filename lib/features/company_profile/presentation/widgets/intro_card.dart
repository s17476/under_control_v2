import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/responsive_size.dart';
import '../../../core/utils/size_config.dart';

class IntroCard extends StatelessWidget with ResponsiveSize {
  const IntroCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                        height: responsiveSizeVerticalPct(small: 5, medium: 10),
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
                            'assets/company.png',
                          ),
                        ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        AppLocalizations.of(context)!
                            .assign_company_congratulations,
                        style: const TextStyle(fontSize: 32),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          AppLocalizations.of(context)!.assign_company_info,
                          textAlign: TextAlign.justify,
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
      ),
    );
  }
}
