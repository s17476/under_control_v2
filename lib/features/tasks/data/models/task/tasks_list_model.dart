import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/task/task.dart';
import '../../../domain/entities/task/tasks_list.dart';
import 'task_model.dart';

class TasksListModel extends TasksList {
  const TasksListModel({required super.allTasks});

  factory TasksListModel.fromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Task> workRequestsList = [];
    workRequestsList = snapshot.docs
            .map(
              (DocumentSnapshot doc) => TaskModel.fromMap(
                doc.data() as Map<String, dynamic>,
                doc.id,
              ),
            )
            .toList()
        // ..sort(
        //   (a, b) => a.executionDate.compareTo(b.executionDate),
        // )
        ;
    return TasksListModel(allTasks: workRequestsList);
  }
}
