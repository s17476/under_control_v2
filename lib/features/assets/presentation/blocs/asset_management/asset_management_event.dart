part of 'asset_management_bloc.dart';

abstract class AssetManagementEvent extends Equatable {
  final AssetModel asset;
  final List properties;

  const AssetManagementEvent({
    required this.asset,
    this.properties = const [],
  });

  @override
  List<Object> get props => [asset, properties];
}

class AddAssetEvent extends AssetManagementEvent {
  final List<File> images;
  final List<File> documents;
  AddAssetEvent({
    required super.asset,
    required this.images,
    required this.documents,
  }) : super(properties: [images, documents]);
}

class UpdateAssetEvent extends AssetManagementEvent {
  final List<File> images;
  final List<File> documents;
  UpdateAssetEvent({
    required super.asset,
    required this.images,
    required this.documents,
  }) : super(properties: [images, documents]);
}

class DeleteAssetEvent extends AssetManagementEvent {
  const DeleteAssetEvent({required super.asset});
}
