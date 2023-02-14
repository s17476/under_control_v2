part of 'tasks_archive_for_asset_bloc.dart';

abstract class TasksArchiveForAssetState extends Equatable {
  final List properties;
  const TasksArchiveForAssetState({this.properties = const []});

  @override
  List<Object> get props => [properties];
}

class TasksArchiveForAssetEmpty extends TasksArchiveForAssetState {}

class TasksArchiveForAssetError extends TasksArchiveForAssetState {
  final String message;
  TasksArchiveForAssetError({
    required this.message,
  }) : super(properties: [message]);
}

class TasksArchiveForAssetLoading extends TasksArchiveForAssetState {}

class TasksArchiveForAssetLoaded extends TasksArchiveForAssetState {
  final String assetId;
  final TasksListModel tasks;
  final bool isAll;

  TasksArchiveForAssetLoaded({
    required this.assetId,
    required this.tasks,
    required this.isAll,
  }) : super(properties: [assetId, tasks, isAll]);
}
