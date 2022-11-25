import 'package:equatable/equatable.dart';

class TaskActionsStream extends Equatable {
  final Stream allTaskActions;

  const TaskActionsStream({
    required this.allTaskActions,
  });

  @override
  List<Object> get props => [allTaskActions];

  @override
  String toString() => 'TaskActionsStream(allTaskActions: $allTaskActions)';
}
