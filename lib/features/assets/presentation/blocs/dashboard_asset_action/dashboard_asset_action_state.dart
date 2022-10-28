part of 'dashboard_asset_action_bloc.dart';

abstract class DashboardAssetActionState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const DashboardAssetActionState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class DashboardAssetActionEmptyState extends DashboardAssetActionState {}

class DashboardAssetActionLoadingState extends DashboardAssetActionState {}

class DashboardAssetActionErrorState extends DashboardAssetActionState {
  const DashboardAssetActionErrorState({
    required super.message,
    super.error = true,
  });
}

class DashboardAssetActionLoadedState extends DashboardAssetActionState {
  final AssetActionsListModel allActions;
  final bool isAllItems;

  DashboardAssetActionLoadedState({
    required this.allActions,
    this.isAllItems = false,
  }) : super(properties: [allActions, isAllItems]);
}
