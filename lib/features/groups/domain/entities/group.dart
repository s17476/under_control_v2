import 'package:equatable/equatable.dart';

import '../../data/models/feature_model.dart';

class Group extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<String> locations;
  final List<FeatureModel> features;

  const Group({
    required this.id,
    required this.name,
    required this.description,
    required this.locations,
    required this.features,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      description,
      locations,
      features,
    ];
  }

  @override
  String toString() {
    return 'Group(id: $id, name: $name, description: $description, locations: $locations, features: $features)';
  }
}
