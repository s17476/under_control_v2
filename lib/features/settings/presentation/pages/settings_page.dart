import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/settings/presentation/widgets/notification_settings_tile.dart';

import '../widgets/language_settings_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.drawer_item_settings),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            LanguageSettingsTile(),
            Divider(
              thickness: 1.5,
            ),
            NotificationSettingsTile(),
            Divider(
              thickness: 1.5,
            ),
          ],
        ),
      ),
    );
  }
}
