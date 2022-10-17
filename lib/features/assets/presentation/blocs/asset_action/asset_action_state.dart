part of 'asset_action_bloc.dart';

abstract class AssetActionState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const AssetActionState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class AssetActionEmptyState extends AssetActionState {}

class AssetActionLoadingState extends AssetActionState {}

class AssetActionErrorState extends AssetActionState {
  const AssetActionErrorState({
    required super.message,
    super.error = true,
  });
}

class AssetActionLoadedState extends AssetActionState {
  final AssetActionsListModel allActions;
  final bool isAllItems;

  AssetActionLoadedState({
    required this.allActions,
    this.isAllItems = false,
  }) : super(properties: [
          allActions,
          isAllItems,
        ]);
}
