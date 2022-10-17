part of 'asset_action_management_bloc.dart';

abstract class AssetActionManagementState extends Equatable {
  final BlocMessage message;
  final bool error;
  final List properties;

  const AssetActionManagementState({
    this.message = BlocMessage.empty,
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class AssetActionManagementEmptyState extends AssetActionManagementState {}

class AssetActionManagementLoadingState extends AssetActionManagementState {}

class AssetActionManagementErrorState extends AssetActionManagementState {
  AssetActionManagementErrorState({
    required super.message,
    super.error = true,
  }) : super(properties: [message]);
}

class AssetActionManagementSuccessState extends AssetActionManagementState {
  AssetActionManagementSuccessState({
    required super.message,
  }) : super(properties: [message]);
}
