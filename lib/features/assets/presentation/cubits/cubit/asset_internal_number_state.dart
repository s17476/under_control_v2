part of 'asset_internal_number_cubit.dart';

abstract class AssetInternalNumberState extends Equatable {
  const AssetInternalNumberState({
    this.isCodeAvailable = false,
  });

  final bool isCodeAvailable;

  @override
  List<Object> get props => [isCodeAvailable];
}

class AssetInternalNumberEmptyState extends AssetInternalNumberState {}

class AssetInternalNumberErrorState extends AssetInternalNumberState {}

class AssetInternalNumberLoadingState extends AssetInternalNumberState {}

class AssetInternalNumberLoadedState extends AssetInternalNumberState {
  const AssetInternalNumberLoadedState({
    required super.isCodeAvailable,
  });
}
