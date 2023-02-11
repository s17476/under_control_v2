part of 'task_cubit.dart';

abstract class TaskCubitState extends Equatable {
  final List properties;
  const TaskCubitState({this.properties = const []});

  @override
  List<Object> get props => [properties];
}

class TaskCubitEmpty extends TaskCubitState {}

class TaskCubitError extends TaskCubitState {}

class TaskCubitLoading extends TaskCubitState {}

class TaskCubitLoaded extends TaskCubitState {
  final TaskModel task;
  TaskCubitLoaded({
    required this.task,
  }) : super(properties: [task]);
}
