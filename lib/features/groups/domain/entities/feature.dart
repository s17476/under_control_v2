import 'package:equatable/equatable.dart';

enum FeatureType {
  tasks('tasks'),
  inventory('inventory'),
  assets('assets'),
  locations('locations'),
  unknown('unknown');

  final String name;

  const FeatureType(this.name);

  factory FeatureType.fromString(String name) {
    switch (name) {
      case 'tasks':
        return FeatureType.tasks;
      case 'inventory':
        return FeatureType.inventory;
      case 'assets':
        return FeatureType.assets;
      case 'locations':
        return FeatureType.locations;
      default:
        return FeatureType.unknown;
    }
  }
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
