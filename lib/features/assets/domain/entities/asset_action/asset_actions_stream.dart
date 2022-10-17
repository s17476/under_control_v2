import 'package:equatable/equatable.dart';

class AssetActionsStream extends Equatable {
  final Stream allAssetActions;

  const AssetActionsStream({
    required this.allAssetActions,
  });

  @override
  List<Object> get props => [allAssetActions];

  @override
  String toString() => 'AssetActionsStream(allAssetActions: $allAssetActions)';
}
