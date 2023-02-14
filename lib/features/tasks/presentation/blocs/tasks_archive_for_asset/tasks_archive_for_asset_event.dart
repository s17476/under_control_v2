part of 'tasks_archive_for_asset_bloc.dart';

abstract class TasksArchiveForAssetEvent extends Equatable {
  final List properities;
  const TasksArchiveForAssetEvent({this.properities = const []});

  @override
  List<Object> get props => [properities];
}

class GetTasksArchiveForAssetEvent extends TasksArchiveForAssetEvent {
  final String assetId;
  final bool isAll;

  GetTasksArchiveForAssetEvent({
    required this.assetId,
    required this.isAll,
  }) : super(properities: [assetId, isAll]);
}

class UpdateTasksArchiveForAssetListEvent extends TasksArchiveForAssetEvent {
  final String assetId;
  final QuerySnapshot<Object?> snapshot;
  final bool isAll;

  UpdateTasksArchiveForAssetListEvent({
    required this.assetId,
    required this.snapshot,
    required this.isAll,
  }) : super(properities: [assetId, snapshot, isAll]);
}
