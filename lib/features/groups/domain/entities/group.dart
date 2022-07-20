import 'package:equatable/equatable.dart';

import '../../data/models/feature_model.dart';

class Group extends Equatable {
  final String id;
  final String name;
  final List<String> locations;
  final List<FeatureModel> features;

  const Group({
    required this.id,
    required this.name,
    required this.locations,
    required this.features,
  });

  @override
  List<Object> get props => [id, name, locations, features];

  @override
  String toString() {
    return 'Group(id: $id, name: $name, locations: $locations, features: $features)';
  }
}
