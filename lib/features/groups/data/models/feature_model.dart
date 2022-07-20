import 'package:under_control_v2/features/groups/domain/entities/feature.dart';

class FeatureModel extends Feature {
  const FeatureModel({
    required super.type,
    required super.create,
    required super.read,
    required super.edit,
    required super.delete,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'type': type.name});
    result.addAll({'create': create});
    result.addAll({'read': read});
    result.addAll({'edit': edit});
    result.addAll({'delete': delete});

    return result;
  }

  factory FeatureModel.fromMap(Map<String, dynamic> map) {
    return FeatureModel(
      type: FeatureType.fromString(map['type']),
      create: map['create'] ?? false,
      read: map['read'] ?? false,
      edit: map['edit'] ?? false,
      delete: map['delete'] ?? false,
    );
  }
}
