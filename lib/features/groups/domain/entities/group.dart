import 'package:equatable/equatable.dart';

import 'package:under_control_v2/features/groups/domain/entities/feature.dart';

import '../../../locations/domain/entities/location.dart';

class Group extends Equatable {
  final String id;
  final String name;
  final List<Location> locations;
  final List<Feature> features;

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
