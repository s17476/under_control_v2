import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/task_action/task_actions_list.dart';
import 'task_action_model.dart';

class TaskActionsListModel extends TaskActionsList {
  const TaskActionsListModel({required super.allTaskActions});

  factory TaskActionsListModel.fromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<TaskActionModel> taskActionsList = [];
    taskActionsList = snapshot.docs
        .map(
          (DocumentSnapshot doc) => TaskActionModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          ),
        )
        .toList()
      ..sort(
        (a, b) => b.stopTime.compareTo(a.stopTime),
      );
    return TaskActionsListModel(allTaskActions: taskActionsList);
  }
}
