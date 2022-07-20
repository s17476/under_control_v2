import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:under_control_v2/features/groups/data/models/group_model.dart';
import 'package:under_control_v2/features/groups/domain/entities/group.dart';
import 'package:under_control_v2/features/groups/domain/entities/groups_list.dart';

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
        (a, b) => a.name.compareTo(b.name),
      );

    return GroupsListModel(allGroups: groupslist);
  }
}
