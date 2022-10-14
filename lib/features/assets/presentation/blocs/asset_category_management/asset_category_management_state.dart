part of 'asset_category_management_bloc.dart';

abstract class AssetCategoryManagementState extends Equatable {
  final BlocMessage message;
  final bool error;
  final List properties;

  const AssetCategoryManagementState({
    this.message = BlocMessage.empty,
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class AssetCategoryManagementEmptyState extends AssetCategoryManagementState {}

class AssetCategoryManagementLoadingState extends AssetCategoryManagementState {
}

class AssetCategoryManagementErrorState extends AssetCategoryManagementState {
  AssetCategoryManagementErrorState({
    required super.message,
    super.error = true,
  }) : super(properties: [error, message]);
}

class AssetCategoryManagementSuccessState extends AssetCategoryManagementState {
  AssetCategoryManagementSuccessState({
    required super.message,
  }) : super(properties: [message]);
}
