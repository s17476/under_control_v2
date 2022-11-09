import 'package:equatable/equatable.dart';

import 'task.dart';

class TasksList extends Equatable {
  final List<Task> allTasks;

  const TasksList({
    required this.allTasks,
  });

  @override
  List<Object> get props => [allTasks];

  @override
  String toString() => 'TasksList(allTasks: $allTasks)';
}
