part of 'asset_bloc.dart';

abstract class AssetEvent extends Equatable {
  final List properties;

  const AssetEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetAssetsStreamEvent extends AssetEvent {}

class UpdateAssetsListEvent extends AssetEvent {
  final QuerySnapshot<Object?> snapshot;
  final List<String> locations;

  UpdateAssetsListEvent({
    required this.snapshot,
    required this.locations,
  }) : super(properties: [snapshot, locations]);
}
