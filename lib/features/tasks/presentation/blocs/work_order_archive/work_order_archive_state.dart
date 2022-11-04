part of 'work_order_archive_bloc.dart';

abstract class WorkOrderArchiveState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const WorkOrderArchiveState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class WorkOrderArchiveEmptyState extends WorkOrderArchiveState {}

class WorkOrderArchiveLoadingState extends WorkOrderArchiveState {}

class WorkOrderArchiveErrorState extends WorkOrderArchiveState {
  const WorkOrderArchiveErrorState({
    super.message,
    super.error = true,
  });
}

class WorkOrderArchiveLoadedState extends WorkOrderArchiveState {
  final WorkOrdersListModel allWorkOrders;

  WorkOrderArchiveLoadedState({
    required this.allWorkOrders,
  }) : super(properties: [allWorkOrders]);

  WorkOrder? getWorkOrderById(String id) {
    final index =
        allWorkOrders.allWorkOrders.indexWhere((asset) => asset.id == id);
    if (index >= 0) {
      return allWorkOrders.allWorkOrders[index];
    }
    return null;
  }
}
