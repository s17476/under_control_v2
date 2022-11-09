import 'package:equatable/equatable.dart';

class TasksStream extends Equatable {
  final Stream allTasks;

  const TasksStream({
    required this.allTasks,
  });

  @override
  List<Object> get props => [allTasks];

  @override
  String toString() => 'TasksStream(allTasks: $allTasks)';
}
