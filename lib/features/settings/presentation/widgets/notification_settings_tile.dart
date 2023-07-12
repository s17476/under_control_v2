import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../pages/notification_settings_page.dart';

class NotificationSettingsTile extends StatelessWidget {
  const NotificationSettingsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        NotificationSettingsPage.routeName,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          children: [
            const Icon(Icons.notifications),
            const SizedBox(
              width: 12,
            ),
            Text(
              AppLocalizations.of(context)!.notifications,
              style: const TextStyle(fontSize: 16),
            ),
            const Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
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
