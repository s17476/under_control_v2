import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/settings/presentation/blocs/language/language_cubit.dart';
import 'package:under_control_v2/features/settings/utils/get_localizaed_language_name.dart';

class LanguageSettingsPage extends StatelessWidget {
  const LanguageSettingsPage({super.key});

  static const routeName = '/settings/language';

  @override
  Widget build(BuildContext context) {
    final systemLocales = WidgetsBinding.instance.window.locales;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.language_select,
        ),
      ),
      body: ListView.separated(
        itemCount: systemLocales.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1.5,
        ),
        itemBuilder: (context, index) => LanguageButton(
          languageCode: systemLocales[index].languageCode,
        ),
      ),
    );
  }
}

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    Key? key,
    required this.languageCode,
  }) : super(key: key);

  final String languageCode;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<LanguageCubit>().changeLanguage(languageCode),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: BlocBuilder<LanguageCubit, Locale?>(
          builder: (context, locale) {
            return Row(
              children: [
                Expanded(
                  child: Text(
                    getLocalizedLanguageName(
                      context,
                      languageCode,
                    ),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                if (languageCode == locale?.languageCode) const Icon(Icons.done)
              ],
            );
          },
        ),
      ),
    );
  }
}
