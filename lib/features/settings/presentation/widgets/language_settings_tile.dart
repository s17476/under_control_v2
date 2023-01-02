import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/settings/presentation/blocs/language/language_cubit.dart';
import 'package:under_control_v2/features/settings/presentation/pages/language_settings_page.dart';

import '../../utils/get_localizaed_language_name.dart';

class LanguageSettingsTile extends StatelessWidget {
  const LanguageSettingsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, LanguageSettingsPage.routeName),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          children: [
            const Icon(Icons.flag),
            const SizedBox(
              width: 12,
            ),
            Text(
              AppLocalizations.of(context)!.language,
              style: const TextStyle(fontSize: 16),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BlocBuilder<LanguageCubit, Locale?>(
                    builder: (context, locale) {
                      return Text(
                        getLocalizedLanguageName(
                          context,
                          locale?.languageCode,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
