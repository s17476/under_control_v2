import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/settings/presentation/blocs/notification_settings/notification_settings_cubit.dart';

import '../../utils/get_localizaed_language_name.dart';
import '../blocs/language/language_cubit.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  static const routeName = '/settings/notification';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.language_select,
        ),
      ),
      body: BlocBuilder<NotificationSettingsCubit, NotificationSettingsState>(
        builder: (context, state) {
          if (state is NotificationSettingsLoaded) {
            return Text(state.settings.assets.toString());
          }
          return Text(state.toString());
        },
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
        child: BlocBuilder<LanguageCubit, Locale>(
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
                if (languageCode == locale.languageCode.split('_')[0])
                  const Icon(
                    Icons.done,
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
