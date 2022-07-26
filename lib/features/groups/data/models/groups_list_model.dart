import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/group.dart';
import '../../domain/entities/groups_list.dart';
import 'group_model.dart';

class GroupsListModel extends GroupsList {
  const GroupsListModel({required super.allGroups});

  factory GroupsListModel.fromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Group> groupslist = [];
    groupslist = snapshot.docs
        .map(
          (DocumentSnapshot doc) => GroupModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          ),
        )
        .toList()
      ..sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );

    return GroupsListModel(allGroups: groupslist);
  }
}
