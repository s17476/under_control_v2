part of 'work_request_management_bloc.dart';

abstract class WorkRequestManagementEvent extends Equatable {
  final WorkRequest workRequest;
  const WorkRequestManagementEvent({
    required this.workRequest,
  });

  @override
  List<Object> get props => [workRequest];
}

class AddWorkRequestEvent extends WorkRequestManagementEvent {
  final List<File>? images;
  final File? video;
  const AddWorkRequestEvent({
    required super.workRequest,
    this.images,
    this.video,
  });
}

class DeleteWorkRequestEvent extends WorkRequestManagementEvent {
  const DeleteWorkRequestEvent({required super.workRequest});
}

class CancelWorkRequestEvent extends WorkRequestManagementEvent {
  final String comment;
  const CancelWorkRequestEvent({
    required super.workRequest,
    required this.comment,
  });
}

class UpdateWorkRequestEvent extends WorkRequestManagementEvent {
  final List<File>? images;
  final File? video;
  const UpdateWorkRequestEvent({
    required super.workRequest,
    this.images,
    this.video,
  });
}
