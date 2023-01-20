part of 'task_templates_bloc.dart';

abstract class TaskTemplatesEvent extends Equatable {
  final List properties;

  const TaskTemplatesEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetTaskTemplatesEvent extends TaskTemplatesEvent {}

class UpdateTaskTemplatesListEvent extends TaskTemplatesEvent {
  final QuerySnapshot<Object?> snapshot;
  UpdateTaskTemplatesListEvent({
    required this.snapshot,
  }) : super(properties: [snapshot]);
}
