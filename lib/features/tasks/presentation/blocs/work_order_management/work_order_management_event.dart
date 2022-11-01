part of 'work_order_management_bloc.dart';

abstract class WorkOrderManagementEvent extends Equatable {
  final WorkOrder workOrder;
  const WorkOrderManagementEvent({
    required this.workOrder,
  });

  @override
  List<Object> get props => [workOrder];
}

class AddWorkOrderEvent extends WorkOrderManagementEvent {
  final List<File>? images;
  final File? video;
  const AddWorkOrderEvent({
    required super.workOrder,
    this.images,
    this.video,
  });
}

class DeleteWorkOrderEvent extends WorkOrderManagementEvent {
  const DeleteWorkOrderEvent({required super.workOrder});
}

class UpdateWorkOrderEvent extends WorkOrderManagementEvent {
  final List<File>? images;
  final File? video;
  const UpdateWorkOrderEvent({
    required super.workOrder,
    this.images,
    this.video,
  });
}
