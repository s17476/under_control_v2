import 'package:equatable/equatable.dart';

class AssetsStream extends Equatable {
  final Stream allAssets;

  const AssetsStream({
    required this.allAssets,
  });

  @override
  List<Object> get props => [allAssets];

  @override
  String toString() => 'AssetsStream(allAssets: $allAssets)';
}
