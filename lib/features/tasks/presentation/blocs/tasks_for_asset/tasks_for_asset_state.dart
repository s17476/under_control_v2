part of 'tasks_for_asset_bloc.dart';

abstract class TasksForAssetState extends Equatable {
  final List properties;
  const TasksForAssetState({this.properties = const []});

  @override
  List<Object> get props => [properties];
}

class TasksForAssetEmpty extends TasksForAssetState {}

class TasksForAssetError extends TasksForAssetState {
  final String message;
  TasksForAssetError({
    required this.message,
  }) : super(properties: [message]);
}

class TasksForAssetLoading extends TasksForAssetState {}

class TasksForAssetLoaded extends TasksForAssetState {
  final String assetId;
  final TasksListModel tasks;

  TasksForAssetLoaded({
    required this.assetId,
    required this.tasks,
  }) : super(properties: [assetId, tasks]);
}
