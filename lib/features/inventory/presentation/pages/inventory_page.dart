import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              for (var i in Iterable<int>.generate(100).toList())
                Text(
                  AppLocalizations.of(context)!.bottom_bar_title_inventory +
                      i.toString(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
