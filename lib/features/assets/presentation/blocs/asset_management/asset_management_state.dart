part of 'asset_management_bloc.dart';

abstract class AssetManagementState extends Equatable {
  final BlocMessage message;
  final bool error;
  final List properties;

  const AssetManagementState({
    this.message = BlocMessage.empty,
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class AssetManagementEmptyState extends AssetManagementState {}

class AssetManagementLoadingState extends AssetManagementState {}

class AssetManagementErrorState extends AssetManagementState {
  const AssetManagementErrorState({
    required super.message,
    super.error = true,
  });
}

class AssetManagementSuccessState extends AssetManagementState {
  const AssetManagementSuccessState({
    required super.message,
  });
}
