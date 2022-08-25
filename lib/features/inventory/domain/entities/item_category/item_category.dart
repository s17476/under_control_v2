import 'package:equatable/equatable.dart';

class ItemCategory extends Equatable {
  final String id;
  final String name;

  const ItemCategory({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];

  @override
  String toString() => 'ItemCategory(id: $id, name: $name)';
}
