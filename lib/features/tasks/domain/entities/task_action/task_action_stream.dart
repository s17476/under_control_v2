import 'package:equatable/equatable.dart';

class TaskActionStream extends Equatable {
  final Stream taskActionStream;
  const TaskActionStream({
    required this.taskActionStream,
  });

  @override
  List<Object> get props => [taskActionStream];

  @override
  String toString() => 'TaskActionStream(taskActionStream: $taskActionStream)';
}
