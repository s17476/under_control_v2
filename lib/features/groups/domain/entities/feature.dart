import 'package:equatable/equatable.dart';

enum FeatureType {
  tasks('tasks'),
  inventory('inventory'),
  assets('assets'),
  knowledgeBase('knowledgeBase'),
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
      case 'knowledgeBase':
        return FeatureType.knowledgeBase;
      default:
        return FeatureType.unknown;
    }
  }
}

// ignore: must_be_immutable
class Feature extends Equatable {
  final FeatureType type;
  bool create;
  bool read;
  bool edit;
  bool delete;

  Feature({
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
