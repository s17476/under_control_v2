import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../tasks/presentation/pages/add_work_request_page.dart';
import '../rounded_button.dart';

class PassiveDashboard extends StatelessWidget {
  const PassiveDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                AddWorkRequestPage.routeName,
              ),
              icon: Icons.add,
              iconSize: 40,
              title: AppLocalizations.of(context)!.work_request_add,
              titleSize: 18,
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).errorColor,
                  Theme.of(context).errorColor.withAlpha(80),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              padding: const EdgeInsets.all(16),
            ),
          ],
        ),
      ],
    );
  }
}
