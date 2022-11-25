import 'package:equatable/equatable.dart';

import 'task_action.dart';

class TaskActionsList extends Equatable {
  final List<TaskAction> allTaskActions;

  const TaskActionsList({
    required this.allTaskActions,
  });

  @override
  List<Object> get props => [allTaskActions];

  @override
  String toString() => 'TaskActionsList(allTaskActions: $allTaskActions)';
}
