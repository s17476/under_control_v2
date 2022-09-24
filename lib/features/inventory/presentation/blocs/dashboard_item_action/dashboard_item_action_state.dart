part of 'dashboard_item_action_bloc.dart';

abstract class DashboardItemActionState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const DashboardItemActionState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class DashboardItemActionEmptyState extends DashboardItemActionState {}

class DashboardItemActionLoadingState extends DashboardItemActionState {}

class DashboardItemActionErrorState extends DashboardItemActionState {
  const DashboardItemActionErrorState({
    required super.message,
    super.error = true,
  });
}

class DashboardItemActionLoadedState extends DashboardItemActionState {
  final ItemActionsListModel allActions;
  final bool isAllItems;

  DashboardItemActionLoadedState({
    required this.allActions,
    this.isAllItems = false,
  }) : super(properties: [allActions, isAllItems]);
}
