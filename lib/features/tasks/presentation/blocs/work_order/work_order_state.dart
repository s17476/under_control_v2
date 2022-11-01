part of 'work_order_bloc.dart';

abstract class WorkOrderState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const WorkOrderState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class WorkOrderEmptyState extends WorkOrderState {}

class WorkOrderLoadingState extends WorkOrderState {}

class WorkOrderErrorState extends WorkOrderState {
  const WorkOrderErrorState({
    super.message,
    super.error = true,
  });
}

class WorkOrderLoadedState extends WorkOrderState {
  final WorkOrdersListModel allWorkOrders;

  WorkOrderLoadedState({
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
