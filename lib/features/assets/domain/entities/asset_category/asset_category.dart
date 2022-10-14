import 'package:equatable/equatable.dart';

class AssetCategory extends Equatable {
  final String id;
  final String name;

  const AssetCategory({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];

  @override
  String toString() => 'AssetCategory(id: $id, name: $name)';
}
