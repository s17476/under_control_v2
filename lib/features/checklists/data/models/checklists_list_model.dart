import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/checklist.dart';
import '../../domain/entities/checklists_list.dart';
import 'checklist_model.dart';

class ChecklistsListModel extends ChecklistsList {
  const ChecklistsListModel({required super.allChecklists});

  factory ChecklistsListModel.fromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Checklist> checklistsList = [];
    checklistsList = snapshot.docs
        .map((DocumentSnapshot doc) =>
            ChecklistModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList()
      ..sort(
        (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
      );

    return ChecklistsListModel(allChecklists: checklistsList);
  }
}
