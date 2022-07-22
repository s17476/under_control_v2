import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GroupManagementPage extends StatelessWidget {
  const GroupManagementPage({Key? key}) : super(key: key);

  static const routeName = '/groups';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.group_management_title),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('data'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(
          Icons.group_add,
          color: Colors.grey.shade200,
        ),
        label: Text(
          AppLocalizations.of(context)!.group_management_add_button,
          style: TextStyle(
            color: Colors.grey.shade200,
          ),
        ),
      ),
    );
  }
}
