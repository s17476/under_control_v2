part of 'tasks_for_asset_bloc.dart';

abstract class TasksForAssetEvent extends Equatable {
  final List properities;
  const TasksForAssetEvent({this.properities = const []});

  @override
  List<Object> get props => [properities];
}

class GetTasksForAssetEvent extends TasksForAssetEvent {
  final String assetId;

  GetTasksForAssetEvent({
    required this.assetId,
  }) : super(properities: [assetId]);
}

class UpdateTasksForAssetListEvent extends TasksForAssetEvent {
  final String assetId;
  final QuerySnapshot<Object?> snapshot;

  UpdateTasksForAssetListEvent({
    required this.assetId,
    required this.snapshot,
  }) : super(properities: [snapshot]);
}
