part of 'asset_action_bloc.dart';

abstract class AssetActionEvent extends Equatable {
  final List properties;
  const AssetActionEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetAssetActionsEvent extends AssetActionEvent {
  final AssetModel asset;
  final String companyId;

  GetAssetActionsEvent({
    required this.asset,
    required this.companyId,
  }) : super(properties: [
          asset,
          companyId,
        ]);
}

class GetLastFiveAssetActionsEvent extends AssetActionEvent {
  final AssetModel asset;
  final String companyId;

  GetLastFiveAssetActionsEvent({
    required this.asset,
    required this.companyId,
  }) : super(properties: [
          asset,
          companyId,
        ]);
}

class UpdateAssetActionsListEvent extends AssetActionEvent {
  final QuerySnapshot<Object?> snapshot;
  final int limit;

  UpdateAssetActionsListEvent({
    required this.snapshot,
    required this.limit,
  }) : super(properties: [
          snapshot,
          limit,
        ]);
}
