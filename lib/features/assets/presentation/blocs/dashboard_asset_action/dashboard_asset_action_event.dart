part of 'dashboard_asset_action_bloc.dart';

abstract class DashboardAssetActionEvent extends Equatable {
  final List properties;

  const DashboardAssetActionEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetDashboardAssetActionsEvent extends DashboardAssetActionEvent {}

class ResetEvent extends DashboardAssetActionEvent {}

class GetDashboardLastFiveAssetActionsEvent extends DashboardAssetActionEvent {}

class UpdateDashboardAssetActionsListEvent extends DashboardAssetActionEvent {
  final QuerySnapshot<Object?> snapshot;
  final int limit;

  UpdateDashboardAssetActionsListEvent({
    required this.snapshot,
    required this.limit,
  }) : super(properties: [
          snapshot,
          limit,
        ]);
}
