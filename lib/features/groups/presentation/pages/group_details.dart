import 'package:flutter/material.dart';

import '../../domain/entities/group.dart';

class GroupDetailsPage extends StatelessWidget {
  const GroupDetailsPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/groups/group-details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('group.name'),
      ),
      body: Center(
        child: Text(
          'group.toString()',
        ),
      ),
    );
  }
}
