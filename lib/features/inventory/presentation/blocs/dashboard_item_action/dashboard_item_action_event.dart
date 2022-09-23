part of 'dashboard_item_action_bloc.dart';

abstract class DashboardItemActionEvent extends Equatable {
  final List properties;

  const DashboardItemActionEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetDashboardItemActionsEvent extends DashboardItemActionEvent {}

class GetDashboardLastFiveItemActionsEvent extends DashboardItemActionEvent {}

class UpdateDashboardItemActionsListEvent extends DashboardItemActionEvent {
  final QuerySnapshot<Object?> snapshot;
  final int limit;
  final bool isLastChunk;

  UpdateDashboardItemActionsListEvent(
      {required this.snapshot, required this.limit, required this.isLastChunk})
      : super(properties: [
          snapshot,
          limit,
          isLastChunk,
        ]);
}
