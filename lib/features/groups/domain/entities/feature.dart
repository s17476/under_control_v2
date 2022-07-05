import 'package:equatable/equatable.dart';

enum FeatureType {
  tasks('tasks'),
  inventory('inventory'),
  assets('assets'),
  locations('locations');

  final String name;

  const FeatureType(this.name);
}

class Feature extends Equatable {
  final FeatureType type;
  final bool create;
  final bool read;
  final bool edit;
  final bool delete;

  const Feature({
    required this.type,
    required this.create,
    required this.read,
    required this.edit,
    required this.delete,
  });

  @override
  List<Object> get props {
    return [
      type,
      create,
      read,
      edit,
      delete,
    ];
  }

  @override
  String toString() {
    return 'Feature(type: $type, create: $create, read: $read, edit: $edit, delete: $delete)';
  }
}
