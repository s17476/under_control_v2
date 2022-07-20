import 'feature_model.dart';
import '../../domain/entities/group.dart';

class GroupModel extends Group {
  const GroupModel({
    required super.id,
    required super.name,
    required super.locations,
    required super.features,
  });

  factory GroupModel.inital() => const GroupModel(
        id: 'id',
        name: 'name',
        locations: [],
        features: [],
      );

  GroupModel copyWith({
    String? id,
    String? name,
    List<String>? locations,
    List<FeatureModel>? features,
  }) {
    return GroupModel(
      id: id ?? this.id,
      name: name ?? this.name,
      locations: locations ?? this.locations,
      features: features ?? this.features,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'locations': locations});
    result.addAll({'features': features.map((x) => x.toMap()).toList()});

    return result;
  }

  factory GroupModel.fromMap(Map<String, dynamic> map, String id) {
    return GroupModel(
      id: id,
      name: map['name'] ?? '',
      locations: List<String>.from(map['locations']),
      features: List<FeatureModel>.from(
        map['features']?.map((x) => FeatureModel.fromMap(x)),
      ),
    );
  }
}
